/**
 * 🛡️ Quality Gate Universal para Proyectos Node.js / TypeScript
 *
 * ==============================================================================
 * 📋 QUÉ DETECTA ESTE SCRIPT:
 * • Validación de tipos estáticos y AST (tsc --noEmit, 0 errores, 0 warnings).
 * • Detección de patrones de API Keys mediante Regex (Stripe, GitHub, Google, Supabase).
 * • Fuga de entorno: verifica que .env esté protegido en .gitignore.
 * • Ejecución y verificación de la suite de pruebas automatizadas (npm test).
 *
 * ⚠️ QUÉ NO DETECTA (LÍMITES DE INGENIERÍA):
 * • NO detecta errores de lógica de negocio o cálculos matemáticos incorrectos.
 * • NO garantiza cobertura si los tests no evalúan casos límite o excepciones.
 * • NO detecta credenciales si están ofuscadas o divididas en variables dinámicas.
 * • Salida 0 significa "invariantes estáticas superadas", no ausencia total de bugs.
 * ==============================================================================
 */

import { spawn } from 'node:child_process';
import fs from 'node:fs';
import path from 'node:path';

interface Verificacion {
  nombre: string;
  paso: boolean;
  duracionMs: number;
  detalle?: string;
}

const RESULTADOS: Verificacion[] = [];
const ROOT_DIR = process.cwd();

const COLORS = {
  reset: '\x1b[0m',
  bold: '\x1b[1m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  cyan: '\x1b[36m',
  gray: '\x1b[90m',
};

function imprimirTitulo(titulo: string): void {
  console.log(`\n${COLORS.cyan}${COLORS.bold}================================================================${COLORS.reset}`);
  console.log(`${COLORS.cyan}${COLORS.bold}  🛡️  QUALITY GATE NODE / TYPESCRIPT — ${titulo.toUpperCase()}${COLORS.reset}`);
  console.log(`${COLORS.cyan}${COLORS.bold}================================================================${COLORS.reset}\n`);
}

function ejecutarComando(comando: string, args: string[]): Promise<{ codigo: number; stdout: string; stderr: string }> {
  return new Promise((resolve) => {
    const esWindows = process.platform === 'win32';
    const binario = esWindows && (comando === 'npx' || comando === 'npm') ? `${comando}.cmd` : comando;

    const proc = spawn(binario, args, {
      cwd: ROOT_DIR,
      shell: esWindows,
    });

    let stdout = '';
    let stderr = '';

    proc.stdout?.on('data', (data) => (stdout += data.toString()));
    proc.stderr?.on('data', (data) => (stderr += data.toString()));

    proc.on('close', (codigo) => {
      resolve({ codigo: codigo ?? 1, stdout, stderr });
    });

    proc.on('error', (err) => {
      resolve({ codigo: 1, stdout: '', stderr: err.message });
    });
  });
}

async function auditarTiposTypeScript(): Promise<void> {
  const inicio = Date.now();
  const tieneTsConfig = fs.existsSync(path.join(ROOT_DIR, 'tsconfig.json'));

  if (!tieneTsConfig) {
    console.log(`[${COLORS.yellow}1/4${COLORS.reset}] Verificación TypeScript: Omitida (no existe tsconfig.json).`);
    RESULTADOS.push({ nombre: 'TypeScript AST Check', paso: true, duracionMs: Date.now() - inicio });
    return;
  }

  console.log(`[${COLORS.yellow}1/4${COLORS.reset}] Ejecutando comprobación estricta de tipos (tsc --noEmit)...`);
  const { codigo, stdout, stderr } = await ejecutarComando('npx', ['tsc', '--noEmit']);

  if (codigo === 0) {
    console.log(`  ${COLORS.green}✔${COLORS.reset} 0 errores y 0 advertencias de tipos.`);
    RESULTADOS.push({ nombre: 'TypeScript AST Check', paso: true, duracionMs: Date.now() - inicio });
  } else {
    console.log(`  ${COLORS.red}✖${COLORS.reset} Falló la verificación de tipos.`);
    RESULTADOS.push({
      nombre: 'TypeScript AST Check',
      paso: false,
      duracionMs: Date.now() - inicio,
      detalle: (stdout || stderr).trim(),
    });
  }
}

function auditarSecretos(): void {
  const inicio = Date.now();
  console.log(`\n[${COLORS.yellow}2/4${COLORS.reset}] Escaneando posibles credenciales o secretos en código...`);

  const patronesSecretos = [
    { regex: /sk_live_[0-9a-zA-Z]{24,}/, desc: 'Stripe Live Secret Key' },
    { regex: /ghp_[0-9a-zA-Z]{36,}/, desc: 'GitHub Access Token' },
    { regex: /AIzaSy[0-9a-zA-Z_-]{33}/, desc: 'Google Cloud API Key Expuesta' },
    { regex: /service_role[a-zA-Z0-9_\-\.]{30,}/, desc: 'Supabase Service Role Key' },
    { regex: /(?:api_key|secret_key)\s*=\s*['"][a-zA-Z0-9_\-]{20,}['"]/i, desc: 'API Key asignada en texto plano' },
  ];

  const extensiones = ['.ts', '.js', '.json', '.html', '.md', '.env.example'];
  let fallosSecretos = 0;

  function escanearDirectorio(dir: string) {
    const elementos = fs.readdirSync(dir, { withFileTypes: true });

    for (const elem of elementos) {
      const rutaCompleta = path.join(dir, elem.name);

      if (elem.isDirectory()) {
        if (!['node_modules', '.git', 'dist', 'build'].includes(elem.name)) {
          escanearDirectorio(rutaCompleta);
        }
      } else if (extensiones.includes(path.extname(elem.name))) {
        const contenido = fs.readFileSync(rutaCompleta, 'utf-8');
        for (const { regex, desc } of patronesSecretos) {
          if (regex.test(contenido)) {
            console.log(`  ${COLORS.red}✖${COLORS.reset} Posible secreto (${desc}) en ${path.relative(ROOT_DIR, rutaCompleta)}`);
            fallosSecretos++;
          }
        }
      }
    }
  }

  escanearDirectorio(ROOT_DIR);

  if (fallosSecretos === 0) {
    console.log(`  ${COLORS.green}✔${COLORS.reset} Cero credenciales ni secretos en código.`);
    RESULTADOS.push({ nombre: 'Zero-Trust Secret Scanner', paso: true, duracionMs: Date.now() - inicio });
  } else {
    RESULTADOS.push({
      nombre: 'Zero-Trust Secret Scanner',
      paso: false,
      duracionMs: Date.now() - inicio,
      detalle: `Se detectaron ${fallosSecretos} posibles secretos expuestos.`,
    });
  }
}

function auditarEntorno(): void {
  const inicio = Date.now();
  console.log(`\n[${COLORS.yellow}3/4${COLORS.reset}] Verificando integridad de entorno (.gitignore)...`);

  const gitignorePath = path.join(ROOT_DIR, '.gitignore');
  if (fs.existsSync(gitignorePath)) {
    const contenido = fs.readFileSync(gitignorePath, 'utf-8');
    if (!contenido.includes('.env')) {
      console.log(`  ${COLORS.red}✖${COLORS.reset} El archivo .gitignore NO contiene '.env'.`);
      RESULTADOS.push({ nombre: 'Environment Safety Check', paso: false, duracionMs: Date.now() - inicio, detalle: 'Falta .env en .gitignore' });
      return;
    }
    console.log(`  ${COLORS.green}✔${COLORS.reset} .gitignore protege correctamente el archivo .env.`);
    RESULTADOS.push({ nombre: 'Environment Safety Check', paso: true, duracionMs: Date.now() - inicio });
  } else {
    console.log(`  ${COLORS.yellow}⚠${COLORS.reset} No se encontró .gitignore.`);
    RESULTADOS.push({ nombre: 'Environment Safety Check', paso: true, duracionMs: Date.now() - inicio });
  }
}

async function auditarPruebas(): Promise<void> {
  const inicio = Date.now();
  console.log(`\n[${COLORS.yellow}4/4${COLORS.reset}] Ejecutando suite de pruebas automatizadas...`);

  const tieneTests = fs.existsSync(path.join(ROOT_DIR, 'tests')) || fs.existsSync(path.join(ROOT_DIR, '__tests__'));
  if (!tieneTests) {
    console.log(`  ${COLORS.cyan}ℹ${COLORS.reset} No se encontró carpeta de tests. Omitiendo.`);
    RESULTADOS.push({ nombre: 'Test Suite', paso: true, duracionMs: Date.now() - inicio });
    return;
  }

  const { codigo, stdout, stderr } = await ejecutarComando('npm', ['test']);
  if (codigo === 0) {
    console.log(`  ${COLORS.green}✔${COLORS.reset} 100% de pruebas superadas exitosamente.`);
    RESULTADOS.push({ nombre: 'Test Suite', paso: true, duracionMs: Date.now() - inicio });
  } else {
    console.log(`  ${COLORS.red}✖${COLORS.reset} Falló la suite de pruebas.`);
    RESULTADOS.push({
      nombre: 'Test Suite',
      paso: false,
      duracionMs: Date.now() - inicio,
      detalle: (stdout || stderr).trim(),
    });
  }
}

async function main() {
  const inicioTotal = Date.now();
  imprimirTitulo('Auditoría Integral');

  await auditarTiposTypeScript();
  auditarSecretos();
  auditarEntorno();
  await auditarPruebas();

  const totalMs = Date.now() - inicioTotal;
  console.log(`\n${COLORS.cyan}----------------------------------------------------------------${COLORS.reset}`);
  console.log(`Tiempo total: ${(totalMs / 1000).toFixed(2)} segundos`);

  const todosPasaron = RESULTADOS.every((r) => r.paso);

  if (todosPasaron) {
    console.log(`${COLORS.green}${COLORS.bold}🎉 ¡QUALITY GATE 100% SUPERADO! Código seguro y validado.${COLORS.reset}\n`);
    process.exit(0);
  } else {
    console.log(`${COLORS.red}${COLORS.bold}🚨 QUALITY GATE FALLIDO. Corrige los problemas indicados antes de enviar código.${COLORS.reset}\n`);
    for (const r of RESULTADOS.filter((r) => !r.paso)) {
      console.log(`${COLORS.red}• [${r.nombre}]${COLORS.reset}: ${r.detalle ?? 'Error'}`);
    }
    process.exit(1);
  }
}

main().catch((err) => {
  console.error('Error fatal al ejecutar Quality Gate:', err);
  process.exit(1);
});

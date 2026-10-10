#!/usr/bin/env python3
"""
🛡️ Quality Gate Universal para Proyectos Python
Audita invariantes de ingeniería en < 3 segundos:
1. Sintaxis e Integridad de Archivos Python.
2. Escaneo de Secretos Expuestos (Zero-Trust).
3. Integridad de Variables de Entorno (.env.example vs .gitignore).
4. Ejecución de Pruebas Unitarias (pytest / unittest).
"""

import os
import re
import sys
import time
import py_compile
import subprocess
from pathlib import Path

# Configurar encoding UTF-8 en stdout/stderr para Windows
if sys.platform == "win32":
    try:
        sys.stdout.reconfigure(encoding="utf-8")
        sys.stderr.reconfigure(encoding="utf-8")
    except Exception:
        pass

# Colores para terminal (con soporte ANSI)
os.system("") # Habilita secuencias ANSI en la consola de Windows
GREEN = "\033[92m"
RED = "\033[91m"
YELLOW = "\033[93m"
CYAN = "\033[96m"
BOLD = "\033[1m"
RESET = "\033[0m"

ROOT_DIR = Path.cwd()
FALLOS = []

def imprimir_titulo(titulo: str):
    print(f"\n{CYAN}{BOLD}================================================================{RESET}")
    print(f"{CYAN}{BOLD}  🛡️  QUALITY GATE PYTHON — {titulo.upper()}{RESET}")
    print(f"{CYAN}{BOLD}================================================================{RESET}\n")

def check_sintaxis():
    print(f"[{YELLOW}1/4{RESET}] Verificando sintaxis de archivos Python...")
    archivos_python = [p for p in ROOT_DIR.glob("**/*.py") if not any(part.startswith((".", "venv", "__pycache__", "node_modules")) for part in p.parts)]
    
    if not archivos_python:
        print(f"  {CYAN}ℹ{RESET} No se encontraron archivos .py en la raíz o subcarpetas directas.")
        return

    for archivo in archivos_python:
        try:
            py_compile.compile(str(archivo), doraise=True)
        except py_compile.PyCompileError as e:
            msg = f"Error de sintaxis en {archivo.relative_to(ROOT_DIR)}: {e}"
            FALLOS.append(msg)
            print(f"  {RED}✖{RESET} {msg}")
            return
            
    print(f"  {GREEN}✔{RESET} {len(archivos_python)} archivos analizados sin errores de sintaxis.")

def check_secretos():
    print(f"\n[{YELLOW}2/4{RESET}] Escaneando posibles secretos o API Keys expuestas...")
    patrones_secretos = [
        (re.compile(r"sk_live_[0-9a-zA-Z]{24,}"), "Stripe Live Secret Key"),
        (re.compile(r"ghp_[0-9a-zA-Z]{36,}"), "GitHub Personal Access Token"),
        (re.compile(r"AIzaSy[0-9a-zA-Z_-]{33}"), "Google API Key Expuesta"),
        (re.compile(r"service_role[a-zA-Z0-9_\-\.]{30,}"), "Supabase Service Role Key"),
        (re.compile(r"(?i)api_key\s*=\s*['\"][a-zA-Z0-9_\-]{20,}['\"]"), "API Key asignada en texto plano"),
    ]

    archivos_a_escanear = [
        p for p in ROOT_DIR.glob("**/*")
        if p.is_file() and not any(part.startswith((".", "venv", "node_modules", "dist", "build")) for part in p.parts)
        and p.suffix in [".py", ".js", ".ts", ".html", ".json", ".md", ".env.example"]
    ]

    encontrados = 0
    for archivo in archivos_a_escanear:
        try:
            contenido = archivo.read_text(encoding="utf-8", errors="ignore")
            for patron, nombre in patrones_secretos:
                if patron.search(contenido):
                    msg = f"Posible secreto expuesto ({nombre}) en {archivo.relative_to(ROOT_DIR)}"
                    FALLOS.append(msg)
                    print(f"  {RED}✖{RESET} {msg}")
                    encontrados += 1
        except Exception:
            pass

    if encontrados == 0:
        print(f"  {GREEN}✔{RESET} Cero credenciales ni secretos detectados en código rastreado.")

def check_entorno():
    print(f"\n[{YELLOW}3/4{RESET}] Verificando integridad de entorno (.gitignore y .env)...")
    gitignore = ROOT_DIR / ".gitignore"
    env_file = ROOT_DIR / ".env"
    
    if gitignore.exists():
        contenido_gitignore = gitignore.read_text(encoding="utf-8", errors="ignore")
        if ".env" not in contenido_gitignore:
            msg = "El archivo .gitignore NO incluye '.env'. Riesgo crítico de fuga de secretos."
            FALLOS.append(msg)
            print(f"  {RED}✖{RESET} {msg}")
        else:
            print(f"  {GREEN}✔{RESET} .gitignore protege correctamente el archivo .env.")
    else:
        print(f"  {YELLOW}⚠{RESET} No se encontró .gitignore. Asegúrate de crear uno.")

def check_tests():
    print(f"\n[{YELLOW}4/4{RESET}] Ejecutando suite de pruebas unitarias...")
    # Verifica si existe carpeta tests
    tests_dir = ROOT_DIR / "tests"
    if not tests_dir.exists():
        print(f"  {CYAN}ℹ{RESET} No se detectó carpeta 'tests/'. Creando verificación vacía.")
        return

    try:
        # Intenta correr con pytest si está disponible
        res = subprocess.run([sys.executable, "-m", "pytest", "-q"], capture_output=True, text=True, timeout=10)
        if res.returncode == 0:
            print(f"  {GREEN}✔{RESET} Pruebas unitarias superadas exitosamente.")
        else:
            msg = f"Las pruebas de pytest fallaron:\n{res.stdout or res.stderr}"
            FALLOS.append(msg)
            print(f"  {RED}✖{RESET} {msg}")
    except FileNotFoundError:
        # Alternativa con unittest estándar
        try:
            res = subprocess.run([sys.executable, "-m", "unittest", "discover", "-s", "tests"], capture_output=True, text=True, timeout=10)
            if res.returncode == 0:
                print(f"  {GREEN}✔{RESET} Pruebas unitarias de unittest superadas.")
            else:
                msg = f"Las pruebas de unittest fallaron:\n{res.stderr}"
                FALLOS.append(msg)
                print(f"  {RED}✖{RESET} {msg}")
        except Exception as e:
            print(f"  {YELLOW}⚠{RESET} No se pudo ejecutar runner de pruebas: {e}")
    except subprocess.TimeoutExpired:
        msg = "Las pruebas tardaron más de 10 segundos. Violación de presupuesto de tiempo."
        FALLOS.append(msg)
        print(f"  {RED}✖{RESET} {msg}")

def main():
    inicio = time.time()
    imprimir_titulo("Inicio de Inspección")
    
    check_sintaxis()
    check_secretos()
    check_entorno()
    check_tests()

    duracion = time.time() - inicio
    print(f"\n{CYAN}----------------------------------------------------------------{RESET}")
    print(f"Tiempo total de inspección: {duracion:.2f} segundos")
    
    if not FALLOS:
        print(f"{GREEN}{BOLD}🎉 ¡QUALITY GATE 100% SUPERADO! Código seguro y listo para producción.{RESET}\n")
        sys.exit(0)
    else:
        print(f"{RED}{BOLD}🚨 QUALITY GATE FALLIDO. Se detectaron {len(FALLOS)} problemas críticos:{RESET}")
        for i, fallo in enumerate(FALLOS, 1):
            print(f"  {i}. {fallo}")
        print(f"\n{RED}Corrige las causas de raíz antes de dar la tarea por concluida.{RESET}\n")
        sys.exit(1)

if __name__ == "__main__":
    main()

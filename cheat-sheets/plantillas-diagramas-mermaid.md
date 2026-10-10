# 📊 Plantillas de Diagramas Mermaid Listas para Copiar

> **Instrucciones:**  
> Copia cualquiera de estos bloques de texto y pégalos directamente en tus archivos Markdown (`SPEC.md` o documentación). Se renderizarán como diagramas visuales en GitHub, Obsidian, Notion y la mayoría de editores modernos.

---

## 1. El Viaje del Usuario (User Journey Flowchart)

```mermaid
flowchart TD
    INICIO["1. Usuario entra a la pantalla"] --> ACCION["2. Selecciona opción y llena formulario"]
    ACCION --> VALIDAR{"3. ¿Datos válidos?"}
    
    VALIDAR -- No --> ERROR_FORM["Muestra error en el campo y no envía"]
    VALIDAR -- Sí --> ENVIAR["4. Envía petición al backend"]
    
    ENVIAR --> RESPUESTA{"5. ¿Operación exitosa?"}
    RESPUESTA -- No --> ERROR_SERVER["Muestra alerta: 'Intenta nuevamente'"]
    RESPUESTA -- Sí --> EXITO["6. Pantalla de Éxito y confirmación"]
```

---

## 2. Arquitectura en Servilleta (¿Quién habla con quién?)

```mermaid
flowchart LR
    NAVEGADOR["Frontend Web (Navegador)\nHTML / CSS / JS"] -- Petición HTTPS --> API["Backend (Servidor)\nReglas y Autenticación"]
    API -- Consulta segura --> BD[("Base de Datos PostgreSQL\nTablas con RLS")]
    API -- Webhook seguro (HMAC) --> SERVICIO["Servicio Externo\n(Stripe / Meta / Email)"]
```

---

## 3. Máquina de Estados Finitos (State Machine)

```mermaid
stateDiagram-v2
    [*] --> BORRADOR : Creado por usuario
    
    BORRADOR --> EN_REVISION : Envía a revisión
    EN_REVISION --> RECHAZADO : Faltan datos
    RECHAZADO --> BORRADOR : Usuario corrige
    
    EN_REVISION --> APROBADO : Cumple requisitos
    APROBADO --> PUBLICADO : Publicación programada
    
    PUBLICADO --> [*]
```

---

## 4. Diagrama de Secuencia de un Cobro con Webhook

```mermaid
sequenceDiagram
    autonumber
    actor Cliente
    participant Web as Frontend Web
    participant Server as Backend Propio
    participant Stripe as Stripe Checkout
    participant DB as Base de Datos

    Cliente->>Web: Presiona "Pagar Curso $25"
    Web->>Server: POST /api/crear-sesion-pago
    Server->>Stripe: Solicita sesión de pago
    Stripe-->>Server: Retorna URL de checkout
    Server-->>Web: Redirige a Stripe Checkout
    Cliente->>Stripe: Ingresa datos y paga
    Stripe->>Server: POST /webhook (Evento: checkout.completed con firma HMAC)
    Server->>Server: Valida firma criptográfica HMAC
    Server->>DB: Registra orden como 'PAGADA' (Idempotente)
    Server-->>Stripe: 200 OK en <200ms
    Stripe-->>Cliente: Redirige a pantalla de bienvenida
```

---

## 5. Mapa de Datos Mínimo (Diagrama Entidad-Relación)

```mermaid
erDiagram
    USUARIOS ||--o{ PEDIDOS : "realiza"
    PRODUCTOS ||--o{ PEDIDOS : "incluye"

    USUARIOS {
        uuid id PK
        string email UK
        string nombre
        timestamp creado_en
    }

    PRODUCTOS {
        uuid id PK
        string titulo
        integer precio_centavos
        boolean disponible
    }

    PEDIDOS {
        uuid id PK
        uuid usuario_id FK
        uuid producto_id FK
        integer monto_centavos
        string estado
        timestamp creado_en
    }
```

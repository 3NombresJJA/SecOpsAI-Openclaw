# SecOps AI — Asistente Autónomo de Auditoría y Hardening de Seguridad

**Universidad del Cauca — Departamento de Telemática**  
Microproyecto: Aplicaciones basadas en Agentes AI — Opción 2

---

## Descripción

SecOps AI es un agente especializado en seguridad de redes que audita de forma proactiva o bajo demanda la VM del grupo y la subred del laboratorio. Identifica puertos abiertos, banners de servicios desactualizados o reglas de firewall laxas, y propone configuraciones de mitigación (Hardening) con aprobación explícita del usuario.

**Stack:**
- 🦞 **OpenClaw** — Framework del agente, integración con Telegram
- 🦙 **Ollama + qwen2.5:3b** — LLM local cuantizado
- 🐧 **Ubuntu VM** — 16 GB RAM, 4 vCPUs, 30 GB disco

---

## Estructura del Proyecto

```
secops-ai/
├── install.sh              ← Instala todo en OpenClaw
├── SOUL.md                 ← Personalidad del agente
├── AGENTS.md               ← Reglas de seguridad y guardrails
├── TOOLS.md                ← Notas del entorno (rutas, contexto)
│
├── skills/                 ← Skills de OpenClaw (SKILL.md por herramienta)
│   ├── audit-network/      ← /audit_network → nmap -sV localhost
│   ├── firewall-status/    ← /firewall_status → ufw status verbose
│   ├── iptables-status/    ← /iptables_status → iptables -L -n -v
│   ├── listening-ports/    ← /listening_ports → ss -tulnp
│   ├── auth-logs/          ← /auth_logs → grep Failed password auth.log
│   ├── system-info/        ← /system_info → hostnamectl + df + free
│   ├── docker-status/      ← /docker_status → docker ps
│   └── security-updates/   ← /security_updates → apt list --upgradable
│
└── tools/                  ← Scripts bash ejecutados por el agente
    ├── audit_network.sh
    ├── firewall_status.sh
    ├── iptables_status.sh
    ├── listening_ports.sh
    ├── failed_logins.sh
    ├── system_info.sh
    ├── docker_status.sh
    └── security_updates.sh
```

---

## Instalación Rápida

```bash
# 1. Clonar el repositorio
git clone https://github.com/3nombresjja/secops-ai.git
cd secops-ai

# 2. Ejecutar el instalador
bash install.sh

# 3. Recargar OpenClaw
openclaw gateway restart

# 4. Verificar skills cargados
openclaw skills list

# 5. Instalar nmap si no está
sudo apt install nmap -y
```

---

## Prerrequisitos

| Componente | Versión | Notas |
|------------|---------|-------|
| OpenClaw | latest | `npm install -g openclaw@latest` |
| Ollama | latest | Motor LLM local |
| qwen2.5:3b | — | `ollama pull qwen2.5:3b` |
| nmap | any | `sudo apt install nmap` |
| ufw | any | Preinstalado en Ubuntu |
| bash | ≥4.0 | Preinstalado |

---

## Uso desde Telegram

Una vez instalado y con Telegram configurado en OpenClaw:

| Comando | Qué hace |
|---------|---------|
| `/audit_network` | Escanea puertos locales con nmap |
| `/firewall_status` | Muestra estado de UFW |
| `/iptables_status` | Muestra reglas iptables |
| `/listening_ports` | Lista puertos activos con ss |
| `/auth_logs` | Revisa intentos de acceso fallidos |
| `/system_info` | Información del sistema (hostname, memoria, disco) |
| `/docker_status` | Lista contenedores Docker |
| `/security_updates` | Muestra actualizaciones pendientes |

---

## Flujo de Auditoría (Ejemplo)

```
Usuario Telegram: /audit_network

SecOps AI: Ejecutando escaneo de puertos en localhost...
           [ejecuta tools/audit_network.sh]

SecOps AI: He encontrado los siguientes servicios:
           - Puerto 22 (SSH) — OpenSSH 8.9p1 ✓
           - Puerto 80 (HTTP) — Apache 2.4.52 ✓
           - Puerto 21 (FTP) — vsftpd 3.0.3 ⚠️ RIESGO

           El puerto 21 (FTP) está abierto y puede permitir
           acceso anónimo. ¿Deseas que genere una regla en
           UFW para cerrarlo?
           [botón: ✅ Sí, cerrar puerto 21]
           [botón: ❌ No, solo informar]
```

---

## Arquitectura

```
┌─────────────────────────────────────┐
│         Usuario (Telegram)          │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│         OpenClaw Daemon             │
│  - Recibe mensaje de Telegram       │
│  - Carga SOUL.md + AGENTS.md        │
│  - Busca skill relevante            │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│   Ollama Local (qwen2.5:3b)         │
│   http://localhost:11434            │
│  - Analiza el mensaje               │
│  - Decide qué skill invocar         │
│  - Interpreta el output del script  │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│   Skill SKILL.md (ej: audit-network)│
│  - Instruye al agente               │
│  - exec → tools/audit_network.sh    │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│   Script bash (tools/*.sh)          │
│   nmap / ufw / ss / grep / etc.     │
│   READ-ONLY — sin modificaciones    │
└─────────────────────────────────────┘
```

---

## Fases del Proyecto

| Fase | Estado | Descripción |
|------|--------|-------------|
| Fase 1 | ✅ Completa | OpenClaw + Telegram + Ollama funcionando |
| Fase 2 | ✅ Completa | Agente responde mensajes como SecOps AI |
| **Fase 3** | ✅ **Actual** | **Herramientas de auditoría read-only** |
| Fase 4 | 🔜 Pendiente | Herramientas de escritura con aprobación (ufw deny, etc.) |

---

## Seguridad y Guardrails

Este proyecto sigue el principio de **mínimo privilegio**:

- **Fase 3 (actual):** Solo lectura. El agente no puede modificar ninguna configuración.
- **Fase 4 (próxima):** Las operaciones de escritura requerirán confirmación explícita del usuario a través del mecanismo de aprobación de OpenClaw (exec approvals).

Ver `AGENTS.md` para la lista completa de operaciones permitidas y prohibidas.

---

## Autores

Grupo — Electiva Desarrollo de Aplicaciones Web 2026  
Universidad del Cauca, Departamento de Telemática  
Profesor: Javier Alexander Hurtado (javhur@unicauca.edu.co)

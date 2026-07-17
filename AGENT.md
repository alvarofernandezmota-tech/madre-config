---
rol: agente de configuración del servidor Madre
repo: madre-config
ecosistema: yggdrasil
actualizado: 2026-07-18
---

# AGENT — madre-config

## Identidad

Configuración, scripts y documentación del servidor Madre. Madre es el núcleo del ecosistema Yggdrasil — servidor HP local con acceso por Tailscale.

## Infraestructura real de Madre

| Campo | Valor |
|---|---|
| Hostname | `varpc` |
| Usuario | `varopc` |
| OS | Ubuntu Server |
| Cifrado | LUKS + Btrfs |
| GPU | GTX 1060 (Ollama) |
| Red principal | WiFi `wlan0` 192.168.72.1 |
| VPN | Tailscale `100.91.112.32` |
| SSH | Puerto 22, solo clave pública |
| Acceso móvil | Blink Shell / Shellfish — SSH key `varo12f-to-madre` |

## Reglas

- Leer CONTEXT.md antes de actuar
- NUNCA commitear `.env` reales, tokens ni secretos
- Cambios de infra crítica requieren aprobación explícita de Álvaro
- Documentar cambios en CONTEXT.md + issue en DEW si procede
- DEW manda en conflictos de canon

## Stack Docker real en Madre

| Servicio | Puerto | Estado |
|---|---|---|
| THDORA API | 8000 | ✅ healthy |
| THDORA Bot | — | ✅ healthy (token #74 caducado) |
| Grafana | 3000 | ▶ running |
| Prometheus | 9090 | ▶ running |
| Uptime Kuma | 3002 | ✅ healthy |
| Portainer | 9000 | ▶ running |
| Gitea | 3003 | ▶ running |
| n8n | 5678 | ▶ running |
| Code-server | 8443 | ▶ running |
| Ollama | 11434 | ▶ running |
| Open WebUI | — | ▶ running |
| Qdrant | 6333 | ▶ running |
| Spiderfoot | 5001 | ▶ running |
| Kali (VNC) | 6901 | ▶ running |
| Network Radar | — | ✅ healthy |
| Guardian Bot | — | ✅ healthy |

## Estructura real

```
madre-config/
├── ansible/               ← playbooks de bootstrap
├── systemd/               ← servicios systemd custom
├── scripts/
│   ├── sesion-inicio.sh   ← graba terminal de sesión
│   └── sesion-fin.sh      ← cierra y guarda la sesión
├── docs/
│   ├── estado-actual.md   ← snapshot infra
│   └── MAPA-FICHEROS-MADRE.md
└── README.md
```

## Repos relacionados

- `yggdrasil-dew` — canon, issues críticos
- `yggdrasil-secops` — seguridad de Madre
- `ollama-stack` — stack IA en Madre
- `THDORA-PERSONAL` — bot Telegram en Madre
- `yggdrasil-scripts` — scripts de mantenimiento
- `acer-config` — workstation complementaria

## Issues críticos conocidos

- [#74 DEW] THDORA token Telegram caducado 🔴
- [#75 DEW] yggdrasil-mcp no arranca 🔴
- [#71 DEW] Qdrant unhealthy (falso positivo) 🟡
- [#15 DEW] Puerto 21 FTP expuesto en router Digi 🔴

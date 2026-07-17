---
rol: agente de configuración del servidor Madre
repo: madre-config
ecosistema: yggdrasil
actualizado: 2026-07-18
---

# AGENT — madre-config

## Identidad

Repo de configuración e infraestructura del servidor Madre (HP, Arch Linux). Contiene docker-compose, configs de servicios, scripts de arranque y documentación de la máquina física.

## Infraestructura real

- **Madre**: Arch Linux, SSH `varopc@100.91.112.32` (Tailscale)
- **23 contenedores Docker** activos
- **Tailscale** para acceso remoto seguro
- **Acer**: `100.86.119.102` (workstation secundaria)

## Reglas

- Leer CONTEXT.md antes de actuar
- NUNCA commitear `.env` reales, tokens ni secretos
- Cambios de infraestructura crítica requieren aprobación explícita de Álvaro
- Documentar siempre los cambios en CONTEXT.md + issue en DEW si procede
- DEW manda en conflictos de canon
- Issues críticos se abren en yggdrasil-dew, no aquí

## Repos relacionados

- `yggdrasil-dew` — canon, plan maestro, issues
- `yggdrasil-secops` — seguridad de Madre
- `ollama-stack` — stack IA en Madre
- `THDORA-PERSONAL` — bot Telegram corriendo en Madre
- `yggdrasil-scripts` — scripts de mantenimiento
- `acer-config` — workstation complementaria

## Servicios críticos en Madre

| Servicio | Puerto | Estado esperado |
|---|---|---|
| Portainer | 9000 | Up |
| Ollama | 11434 | Up |
| Open WebUI | 8080 | Up |
| Qdrant | 6333 | Up |
| n8n | 5678 | Up |
| Vaultwarden | 8000 | Up |
| Pi-hole | 80 | Up |
| THDORA | — | Up (token #74) |
| yggdrasil-mcp | 3001 | CAIDO (#75) |
| Grafana | 3000 | Up |

## Rutas clave

- `docker/` — docker-compose por servicio
- `configs/` — configuraciones de servicios
- `CONTEXT.md` — estado actual de Madre

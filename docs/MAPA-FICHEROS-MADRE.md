---
tipo: doc
author: Perplexity-MCP <alvarofernandezmota@gmail.com>
creado: 2026-07-03 00:00 CEST
actualizado: 2026-07-05 12:24 CEST
ruta: docs/MAPA-FICHEROS-MADRE.md
tags: [madre, mapa, ficheros, estructura]
status: vigente
---

# Mapa de ficheros — Madre

> Estructura de directorios importantes del servidor Madre.

---

## Rutas clave

| Ruta | Contenido |
|---|---|
| `~/repos/` | Todos los repos clonados |
| `~/repos/yggdrasil-dew` | Cerebro técnico |
| `~/repos/madre-config` | Config de Madre (este repo) |
| `~/repos/THDORA-PERSONAL` | Bot Telegram |
| `~/logs/sesiones/` | Logs de terminal por sesión |
| `/etc/ssh/sshd_config` | Config SSH |
| `~/.ssh/authorized_keys` | Claves SSH autorizadas |
| `/var/lib/docker/` | Datos Docker |

---

## Aliases recomendados en Madre

Añadir a `~/.bashrc`:

```bash
# Sesión
alias inicio='bash ~/repos/madre-config/scripts/sesion-inicio.sh'
alias fin='bash ~/repos/madre-config/scripts/sesion-fin.sh'

# Git rápido
alias ydw='cd ~/repos/yggdrasil-dew && git pull'
alias mc='cd ~/repos/madre-config && git pull'

# Docker
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dunhealthy='docker ps --filter health=unhealthy'
```

---

_Actualizado: 2026-07-05 · Perplexity-MCP_

---
actualizado: 2026-07-18
---

# CONTEXT — madre-config

## Estado actual de Madre

- **OS**: Arch Linux
- **SSH**: `varopc@100.91.112.32` (via Tailscale)
- **Contenedores Docker**: ~23 activos
- **Última actividad en repo**: 2026-07-16

## Issues críticos activos

- [#74 DEW] THDORA token Telegram caducado 🔴 — renovar en BotFather
- [#75 DEW] yggdrasil-mcp no arranca (puerto 3000/3001) 🔴
- [#71 DEW] Qdrant unhealthy (falso positivo telemetría) 🟡
- [#46 DEW] log_guardian_bot crash loop
- [#15 DEW] Puerto 21 FTP expuesto en router Digi 🔴

## Pendientes del repo

- [ ] Documentar hardware real con `dmidecode` (F20 en DEW)
- [ ] Verificar que docker-compose files están en este repo
- [ ] Revisar 3 issues abiertos del repo
- [ ] Completar AGENT.md con rutas reales una vez revisadas

## Hardware conocido

- CPU/placa: pendiente documentar con `dmidecode` (issue F20)
- RAM: desconocida — pendiente
- Disco: desconocido — pendiente `df -h` + `smartctl`

## Última sesión

2026-07-17/18 — auditoría MCP, protocolos creados, scripts bash

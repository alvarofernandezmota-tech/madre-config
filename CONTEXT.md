---
actualizado: 2026-07-18
---

# CONTEXT — madre-config

## Estado actual de Madre

- **OS**: Ubuntu Server (LUKS + Btrfs)
- **SSH**: `varopc@100.91.112.32` (Tailscale) — solo clave pública
- **GPU**: GTX 1060 para Ollama
- **Contenedores Docker**: 16 documentados en README (puede haber más)
- **Última actividad en repo**: 2026-07-16

## Issues críticos activos

- [#74 DEW] THDORA token Telegram caducado 🔴 — renovar en BotFather
- [#75 DEW] yggdrasil-mcp no arranca (puerto 3000/3001) 🔴
- [#71 DEW] Qdrant unhealthy (falso positivo telemetría) 🟡
- [#46 DEW] log_guardian_bot crash loop
- [#15 DEW] Puerto 21 FTP expuesto en router Digi 🔴

## Pendientes del repo

- [ ] Documentar hardware real con `dmidecode` (F20 en DEW)
- [ ] Verificar `docs/estado-actual.md` y actualizarlo
- [ ] Revisar 3 issues abiertos del repo

## Hardware pendiente de documentar

- CPU/placa: ejecutar `sudo dmidecode -t processor` y `dmidecode -t baseboard`
- RAM: `sudo dmidecode -t memory`
- Disco: `df -h` + `sudo smartctl -a /dev/sda`

## Última sesión

2026-07-16 — actividad en repo
2026-07-18 — AGENT.md + CONTEXT.md reescritos con datos reales (auditoría MCP)

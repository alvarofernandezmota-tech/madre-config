---
tipo: contexto
author: Alvaro Fernandez Mota
creado: 2026-07-16
actualizado: 2026-07-16
ruta: CONTEXT.md
tags: [contexto, madre, infra, estado]
status: vigente
---

# CONTEXT.md — madre-config

> Actualizar al inicio y cierre de cada sesion de trabajo.

## Estado actual (2026-07-16)

| Dimension | Estado | Notas |
|---|---|---|
| Repo | Activo | Configuracion base presente |
| AGENT.md | yes 2026-07-16 | Creado F21 |
| CI/CD | sin verificar | Pendiente workflow validate-canon |
| Docker compose | sin verificar | Revisar en terminal |
| Scripts hardening | sin verificar | Revisar en terminal |

## Hardware Madre

- **CPU:** AMD Ryzen (ver isla madre.md)
- **RAM:** ver isla madre.md
- **HDD:** 28.000h — SMART PASSED — monitorizar (issue #31)
- **OS:** Proxmox / Debian
- **Red:** IP local fija — puerto 21 FTP es router Digi (issue #15)

## Servicios core activos (verificar en terminal)

- Docker daemon
- Portainer
- Nginx reverse proxy
- Ver `docker ps` para estado real

## Issues abiertas relacionadas

| Issue | Titulo | Prioridad |
|---|---|---|
| [#31](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/31) | HDD 28.000h SMART | Media |
| [#15](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/15) | Puerto 21 FTP | Media |
| [#60](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/60) | Healthchecks docker | Baja |

## Proximos pasos

- [ ] Verificar estado docker compose en terminal
- [ ] Añadir workflow CI validate-canon
- [ ] Documentar scripts existentes
- [ ] Resolver issue #31 (leer SMART)

---

_Actualizado: 2026-07-16 — F21 — Perplexity MCP_

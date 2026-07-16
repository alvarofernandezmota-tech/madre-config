---
tipo: canon
author: Alvaro Fernandez Mota
creado: 2026-07-16
actualizado: 2026-07-16
ruta: AGENT.md
tags: [agente, canon, madre, infra]
status: vigente
---

# AGENT.md — madre-config

## Identidad del repo

`madre-config` es el repo de configuracion y hardening de la maquina Madre (servidor principal del ecosistema Yggdrasil). Contiene scripts de setup, configuracion de docker compose global, hardening SSH, y documentacion de la infraestructura fisica.

## Proposito

- Configuracion reproducible de la Madre
- Scripts de hardening y seguridad
- Docker compose de servicios core
- Documentacion de hardware y red

## Reglas canon para agentes

1. **Fuente de verdad de infra:** Todo cambio en la Madre debe documentarse aqui
2. **Nunca secrets en repo:** Ningun token, password o clave en ningun archivo
3. **Scripts idempotentes:** Todos los scripts deben poder ejecutarse multiples veces sin efecto secundario
4. **Commits con contexto:** Formato `tipo(scope): descripcion — razon del cambio`
5. **Issues primero:** Toda tarea tiene su issue en `yggdrasil-dew` antes de ejecutarse

## Relacion con el ecosistema

- **Fuente de verdad de protocolos:** `yggdrasil-dew/docs/canon/`
- **Wiki de referencia:** `yggdrasil-wiki/wiki/islas/madre.md`
- **Issues y tracking:** `yggdrasil-dew` (GitHub Issues)
- **Infra relacionada:** `ollama-stack`, `yggdrasil-secops`

## Archivos clave

| Archivo | Proposito |
|---|---|
| `AGENT.md` | Este archivo — identidad del repo |
| `CONTEXT.md` | Estado actual del repo |
| `README.md` | Introduccion publica |
| `docker-compose.yml` | Servicios core de la Madre |
| `scripts/` | Scripts de setup y hardening |

## Protocolo de inicio de sesion

1. Leer este `AGENT.md`
2. Leer `CONTEXT.md` para conocer estado actual
3. Consultar `yggdrasil-dew/docs/canon/PROTOCOLO-INICIO-SESION.md`
4. Revisar issues abiertas en `yggdrasil-dew` etiquetadas `madre`

---

_Creado: 2026-07-16 — F21 — Perplexity MCP_

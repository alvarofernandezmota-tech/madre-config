---
tipo: agent-context
author: Alvaro Fernandez Mota
creado: 2026-07-16
actualizado: 2026-07-16
repo: madre-config
ecosistema: yggdrasil
status: vigente
---

# 🏗️ AGENT.md — madre-config

> Punto de entrada obligatorio para cualquier agente IA que trabaje en este repo.
> Leer este fichero completo antes de ejecutar cualquier acción.
> **Precaución máxima: cambios aquí afectan producción directamente.**

---

## ¿Qué es este repo?

**madre-config** contiene toda la configuración de infraestructura del servidor Madre — el nodo central del ecosistema Yggdrasil. Incluye:

- **Ansible** — playbooks de provisionamiento y configuración
- **systemd** — servicios del sistema
- **scripts** — scripts de mantenimiento y operaciones
- **docs** — documentación de infra

**Rol en ecosistema:** Infra física que sostiene TODO el ecosistema. Si Madre cae, cae todo.

- **Wiki isla:** [madre.md](https://github.com/alvarofernandezmota-tech/yggdrasil-wiki/blob/main/wiki/islas/madre.md) · [infra.md](https://github.com/alvarofernandezmota-tech/yggdrasil-wiki/blob/main/wiki/islas/infra.md)

---

## Estado actual (2026-07-16)

| Componente | Estado | Notas |
|---|---|---|
| Servidor Madre (HP EliteDesk) | 🟢 Running | Host principal |
| Docker Engine | 🟢 Running | Todos los contenedores |
| n8n | 🟡 Running | Sin auditar flujos |
| Ollama + Qdrant | 🟢 Running | Stack IA local |
| Wazuh SIEM | 🟢 Running | Alertas activas |
| Suricata IDS | 🟢 Running | Monitorizando |
| FTP anónimo | 🚨 ALERTA P0 | Detectado — cerrar urgente |
| thdora-bot/api | 🔴 Caído | HAL-007 en THDORA-PERSONAL |

**Alerta activa:**
- 🚨 **FTP anónimo** expuesto — riesgo de seguridad → [DEW #46](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/46)

---

## Estructura del repo

```
madre-config/
├── AGENT.md           ← Este fichero (leer primero)
├── CONTEXT.md         ← Estado actual de infra
├── README.md          ← Overview del repo
├── ansible/           ← Playbooks de provisionamiento
├── systemd/           ← Servicios systemd
├── scripts/           ← Scripts de mantenimiento
└── docs/
    └── sesiones/      ← Logs de sesión de trabajo IA
```

---

## Protocolo de inicio de sesión

1. ✅ Leer `AGENT.md` (este fichero)
2. ✅ Leer `CONTEXT.md` — estado actual de la infra
3. ✅ Verificar alertas activas (FTP, HALs)
4. ✅ Revisar issues en [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues) con label `infra` o `madre`
5. ⚠️ **NUNCA ejecutar cambios en producción sin verificar estado actual primero**

---

## Protocolo de cierre de sesión

1. ✅ Actualizar `CONTEXT.md` con cambios realizados
2. ✅ Crear log en `docs/sesiones/YYYY-MM-DD.md`
3. ✅ Crear issue en `yggdrasil-dew` para trabajo pendiente
4. ✅ Si se modificó algo en producción: documentar exactamente qué y cómo revertir
5. ✅ Actualizar isla `madre.md` o `infra.md` en wiki si cambió algo estructural

---

## Ficheros CRÍTICOS — máxima precaución

| Fichero/Dir | Precaución |
|---|---|
| `ansible/` | Cambios aquí se aplican a producción vía playbook |
| `systemd/` | Cambios en servicios del sistema — pueden tumbar servicios |
| `scripts/` | Verificar siempre en entorno de prueba antes de ejecutar |

---

## Links rápidos

| Recurso | URL |
|---|---|
| Wiki isla madre | [madre.md](https://github.com/alvarofernandezmota-tech/yggdrasil-wiki/blob/main/wiki/islas/madre.md) |
| Wiki isla infra | [infra.md](https://github.com/alvarofernandezmota-tech/yggdrasil-wiki/blob/main/wiki/islas/infra.md) |
| Issues activos (DEW) | [yggdrasil-dew/issues](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues) |
| Alerta FTP | [DEW #46](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/46) |
| Protocolos | [yggdrasil-dew/protocolo/](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/tree/main/protocolo) |

---

_Creado: 2026-07-16 · Perplexity-MCP · Ecosistema Yggdrasil_

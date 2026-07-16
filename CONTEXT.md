---
tipo: context
author: Alvaro Fernandez Mota
creado: 2026-07-16
actualizado: 2026-07-16
repo: madre-config
ecosistema: yggdrasil
status: vigente
---

# 🏗️ CONTEXT.md — madre-config

> Estado actual de la infraestructura del servidor Madre.
> Actualizar al inicio y cierre de cada sesión de trabajo.

---

## Servidor Madre

| Atributo | Valor |
|---|---|
| Hardware | HP EliteDesk (mini PC) |
| OS | Ubuntu Server LTS |
| Rol | Servidor central del ecosistema Yggdrasil |
| Red | Red local + acceso remoto vía VPN/SSH |

---

## Servicios en ejecución (2026-07-16)

| Servicio | Puerto | Estado | Notas |
|---|---|---|---|
| Docker Engine | — | 🟢 Running | Gestor de contenedores |
| n8n | 5678 | 🟡 Running | Flujos sin auditar (AUDIT-003) |
| Ollama | 11434 | 🟢 Running | Modelos: llama3, mistral |
| Qdrant | 6333/6334 | 🟢 Running | Vector DB para RAG |
| Wazuh Manager | 443/1515/55000 | 🟢 Running | SIEM activo |
| Suricata IDS | — | 🟢 Running | Monitorizando tráfico |
| Vaultwarden | 8812 | 🟢 Running | Gestión de secretos |
| Postgres (THDORA) | 5432 | 🟢 Running | BD de thdora-personal |
| thdora-bot | — | 🔴 Caído | HAL-007 [DEW #44](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/44) |
| thdora-api | — | 🔴 Caído | HAL-007 mismo bloqueo |
| FTP (vsftpd) | 21 | 🚨 ALERTA | Anónimo expuesto [DEW #46](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/46) |

---

## Alertas activas

| Alerta | Severidad | Issue | Acción |
|---|---|---|---|
| FTP anónimo expuesto | 🚨 P0 | [DEW #46](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/46) | Deshabilitar acceso anónimo en vsftpd |

---

## Últimos cambios

| Fecha | Cambio | Por |
|---|---|---|
| 2026-07-16 | Añadidos AGENT.md + CONTEXT.md | Perplexity-MCP |
| 2026-07-16 | Detectado FTP anónimo (Wazuh) | Wazuh SIEM |

---

## Pendiente

- [ ] Cerrar FTP anónimo ([DEW #46](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/46))
- [ ] Auditar flujos n8n activos ([DEW #36](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/36))
- [ ] Documentar Ansible playbooks existentes
- [ ] Verificar backups activos

---

_Actualizado: 2026-07-16 · Perplexity-MCP_

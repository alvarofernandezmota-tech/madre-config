---
tipo: doc
author: Perplexity-MCP <alvarofernandezmota@gmail.com>
creado: 2026-07-03 02:19 CEST
actualizado: 2026-07-05 12:24 CEST
ruta: docs/estado-actual.md
tags: [madre, infra, ssh, docker, tailscale, red]
status: vigente
---

# Madre — Estado actual

> Snapshot de infraestructura capturado vía SSH desde Thdora · 2026-07-03 02:05 CEST

---

## Identidad

| Campo | Valor |
|---|---|
| Hostname | `varpc` |
| Usuario principal | `varopc` |
| Uptime capturado | 12h 15m (sesión 2026-07-03) |
| Carga (load average) | 2.27 / 2.68 / 2.77 |
| Usuarios activos | 2 |

---

## Red

| Interfaz | IP | Estado | Notas |
|---|---|---|---|
| `enp4s0` | — | DOWN | Ethernet sin cable |
| `wlan0` | `192.168.72.1/24` | UP | LAN WiFi principal |
| `tailscale0` | `100.91.112.32/32` | UP | VPN Tailscale activa |
| `enp0s20f0u3` | `10.48.234.2/24` | UP (dynamic) | USB tethering |
| `docker0` | `172.17.0.1/16` | UP | Bridge Docker por defecto |

> ⚠️ `enp4s0` (ethernet) está DOWN — Madre opera por WiFi + Tailscale.

---

## SSH

| Campo | Valor |
|---|---|
| Puerto | `22` |
| PasswordAuthentication | `no` |
| PubkeyAuthentication | `yes` |

### Claves autorizadas

| Alias | Dispositivo |
|---|---|
| `acer` | Thdora (Acer) |
| `varopc@madre` | Localhost |
| `varo12f-to-madre` | iPhone 12 (Blink) |

---

## Contenedores con problemas ⚠️

| Contenedor | Estado | Acción |
|---|---|---|
| `log_guardian_bot` | ❌ unhealthy | `docker logs log_guardian_bot` |
| `yggdrasil_watchdog` | ❌ unhealthy | `docker logs yggdrasil_watchdog` |
| `tailscale_monitor` | 🔄 starting | Normal si recién reiniciado |
| `local_tripwire` | 🔄 starting | Normal si recién reiniciado |

---

## TODOs técnicos

- [ ] Investigar `log_guardian_bot` y `yggdrasil_watchdog` unhealthy
- [ ] Añadir `PermitRootLogin no` explícito en `/etc/ssh/sshd_config`
- [ ] Documentar por qué hay 6+ bridges Docker distintos
- [ ] Instalar aliases `inicio` y `fin` en Madre

---

_Actualizado: 2026-07-05 · Perplexity-MCP_

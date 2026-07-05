---
tipo: infra
author: Perplexity-MCP <alvarofernandezmota@gmail.com>
creado: 2026-07-03 02:19 CEST
actualizado: 2026-07-05 20:23 CEST
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
| `enp0s20f0u3` | `10.48.234.2/24` | UP (dynamic) | USB tethering / adaptador externo |
| `docker0` | `172.17.0.1/16` | UP | Bridge Docker por defecto |
| `br-*` | `172.18-24.x.1/16` | varios | Bridges Docker redes personalizadas |

> ⚠️ `enp4s0` (ethernet) está DOWN — Madre opera por WiFi + Tailscale, no por cable ethernet.

---

## SSH

| Campo | Valor |
|---|---|
| Puerto | `22` |
| Escucha | `0.0.0.0:22` + `[::]:22` |
| PasswordAuthentication | `no` |
| PubkeyAuthentication | `yes` |
| PermitRootLogin | no declarado explícitamente (revisar) |

### Claves públicas autorizadas

| Clave | Alias | Dispositivo |
|---|---|---|
| `AAAAC3...hxnn` | `acer` | Thdora (Acer) |
| `AAAAC3...Yp9V` | `varopc@madre` | Localhost |
| `AAAAC3...7nms` | `varo12f-to-madre` | iPhone 12 (Shellfish) |

---

## Stack Docker

| Contenedor | Estado | Puerto(s) | Notas |
|---|---|---|---|
| `thdora` | ✅ healthy | `8000` | API THDORA |
| `thdora-bot` | ✅ healthy | — | Bot Telegram |
| `grafana` | ▶ running | `3000` | Dashboard métricas |
| `prometheus` | ▶ running | `9090` | Scraping |
| `uptime-kuma` | ✅ healthy | `3002` | Monitor |
| `portainer` | ▶ running | `9000` | UI Docker |
| `gitea` | ▶ running | `3003`, `2222` | Git local |
| `n8n` | ▶ running | `5678` | Automatización |
| `code-server` | ▶ running | `8443` | VSCode web |
| `spiderfoot` | ▶ running | `5001` | OSINT |
| `kali-pentest` | ▶ running | `6901` | Kali VNC |
| `log_guardian_bot` | ❌ unhealthy | — | Revisar logs |
| `yggdrasil_watchdog` | ❌ unhealthy | — | Revisar logs |

---

## TODOs técnicos

- [ ] Investigar `log_guardian_bot` y `yggdrasil_watchdog` unhealthy
- [ ] Añadir `PermitRootLogin no` en `/etc/ssh/sshd_config`
- [ ] Verificar ethernet `enp4s0` DOWN por diseño o problema
- [ ] Documentar por qué hay 6+ bridges Docker

---
tipo: infra
author: Perplexity-MCP <alvarofernandezmota@gmail.com>
creado: 2026-07-03 02:19 CEST
actualizado: 2026-07-18 04:55 CEST
ruta: docs/estado-actual.md
tags: [madre, infra, ssh, docker, tailscale, red, thdora]
status: vigente
---

# Madre — Estado actual

> Última actualización: sesión 2026-07-18 04:55 CEST · Perplexity-MCP

---

## Identidad

| Campo | Valor |
|---|---|
| Hostname | `madre` |
| Usuario principal | `varopc` |
| Uptime sesión | 2026-07-18 |
| CPU temp | 51–54°C (idle) |
| GPU temp | 57°C · 11.62W |
| Disco `/` | 43% usado |

---

## Red

| Interfaz | IP | Estado | Notas |
|---|---|---|---|
| `enp4s0` | — | DOWN | Ethernet sin cable |
| `wlan0` | `192.168.72.1/24` | UP | LAN WiFi principal |
| `tailscale0` | `100.91.112.32/32` | UP | VPN Tailscale activa |
| `enp0s20f0u3` | `10.48.234.2/24` | UP | USB tethering |
| `docker0` | `172.17.0.1/16` | UP | Bridge Docker por defecto |
| `br-*` | `172.18–24.x.1/16` | varios | Bridges redes Docker personalizadas |

> ⚠️ `enp4s0` (ethernet) DOWN — Madre opera por WiFi + Tailscale.

---

## SSH

| Campo | Valor |
|---|---|
| Puerto | `22` |
| Escucha | `0.0.0.0:22` + `[::]:22` |
| PasswordAuthentication | `no` |
| PubkeyAuthentication | `yes` |

### ⚠️ Pendiente — Issue #3 DEW

- SSH sigue abierto a `0.0.0.0` (todo internet), debería restringirse a `tailscale0` únicamente.
- Runbook listo para ejecutar:
```bash
sudo ufw allow in on tailscale0 to any port 22
sudo ufw delete NÚMERO_REGLA_22_ABIERTA --force
```

### Claves públicas autorizadas

| Clave | Alias | Dispositivo |
|---|---|---|
| `AAAAC3...hxnn` | `acer` | Acer laptop |
| `AAAAC3...Yp9V` | `varopc@madre` | Localhost |
| `AAAAC3...7nms` | `varo12f-to-madre` | iPhone 12 (Shellfish) |

---

## Stack Docker — Estado 2026-07-18

### Ruta THDORA canónica (confirmada 2026-07-18)

| Elemento | Ruta |
|---|---|
| Repo | `/home/varopc/Projects/thdora` |
| `.env` real | `/home/varopc/Projects/thdora/.env` |
| Compose canónico | `/home/varopc/Projects/thdora/docker-compose.yml` |
| Compose obsoleto | `/home/varopc/Projects/thdora/docker/docker-compose.yml.obsoleto` |

### Contenedores activos

| Contenedor | Estado | Puerto(s) | Notas |
|---|---|---|---|
| `thdora` | ✅ healthy | `8000` | API THDORA — activa |
| `thdora-bot` | ✅ healthy | — | Bot Telegram — activo |
| `grafana` | ▶ running | `3000` | Dashboard métricas |
| `prometheus` | ▶ running | `9090` | Scraping |
| `uptime-kuma` | ✅ healthy | `3002` | Monitor uptime |
| `portainer` | ▶ running | `9000` | UI Docker |
| `gitea` | ▶ running | `3003`, `2222` | Git local |
| `n8n` | ▶ running | `5678` | Automatización |
| `code-server` | ▶ running | `8443` | VSCode web |
| `spiderfoot` | ▶ running | `5001` | OSINT |
| `kali-pentest` | ▶ running | `6901` | Kali VNC |
| `log_guardian_bot` | ❌ unhealthy | — | Crash loop #971 — Issue #46 DEW |
| `yggdrasil_watchdog` | ❌ unhealthy | — | Crash loop — Issue #32 DEW |
| `qdrant` | ⚠️ unhealthy | — | Falso positivo telemetría — Issue #71 DEW |

---

## HDD — Estado SMART (auditado 2026-07-18)

| Campo | Valor |
|---|---|
| Horas de uso | 29.007h |
| Sectores realocados | 0 |
| Sectores pendientes | 0 |
| Temperatura | 43°C |
| Estado general | Sin fallos activos, deuda de vida útil alta |

> ⚠️ 29k horas es límite de vida útil estándar. Monitorizar y planificar sustitución.

---

## UFW — Reglas activas (51 reglas, resumen)

- SSH `22/tcp` abierto a `Anywhere` ⚠️ — pendiente restringir a `tailscale0`
- Puertos Docker expuestos: `3000`, `5678`, `8000`, `8443`, `9000`, `9090`
- Tailscale `41641/udp` abierto
- Ver Issue #3 DEW para runbook de restricción SSH

---

## Systemd timer — Pendiente ejecutar (Issue #1 DEW)

Unidades a crear en `/etc/systemd/system/`:
- `thdora-clean.service` — limpieza artifacts raíz
- `thdora-clean.timer` — disparo diario

Runbook:
```bash
sudo nano /etc/systemd/system/thdora-clean.service
sudo nano /etc/systemd/system/thdora-clean.timer
mkdir -p ~/.logs
sudo systemctl daemon-reload
sudo systemctl enable --now thdora-clean.timer
```

> Fallo anterior: las unidades no existían todavía cuando se intentó `enable --now`.

---

## Secretos — ⚠️ ROTAR URGENTE

Los siguientes secretos quedaron expuestos en terminal durante `docker compose config` el 2026-07-18:

| Secreto | Dónde rotar |
|---|---|
| `TELEGRAM_BOT_TOKEN` | BotFather → /mybots → Revoke |
| `GITHUB_TOKEN` | github.com/settings/tokens → Delete → New |
| `GROQ_API_KEY` | console.groq.com → API Keys → Revoke |
| `ADMIN_TOKEN` | Cambiar en `.env` directamente |

Después de rotar → `docker compose down && docker compose up -d`

---

## Issues DEW pendientes relacionados con Madre

| Issue | Descripción | Prioridad |
|---|---|---|
| [#1](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/1) | Systemd timer thdora-clean | 🔴 |
| [#3](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/3) | Restringir SSH a tailscale0 | 🔴 |
| [#15](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/15) | Puerto 21 FTP abierto en router | 🔴 |
| [#31](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/31) | SMART HDD — auditoría hecha ✅ cerrar | 🟢 |
| [#32](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/32) | Watchdog unhealthy | 🟡 |
| [#34](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/34) | docker-compose raíz identificado ✅ | 🟢 |
| [#43](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/43) | Versionar 16 docker-compose en madre-config | 🟡 |
| [#46](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/46) | log_guardian_bot crash #971 | 🔴 |
| [#71](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/71) | Qdrant falso positivo telemetría | 🟡 |
| [#74](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/74) | Token Telegram — rotar | 🔴 |
| [#75](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/75) | MCP puerto 3000→3001 (conflicto Grafana) | 🟡 |

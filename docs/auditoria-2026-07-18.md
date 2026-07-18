# Auditoría Madre — 2026-07-18 (madrugada)

> **Nodo:** `varpc` | **Usuario:** `varopc` | **Uptime sesión:** ~1h 03min al inicio
> **Sesión:** SSH desde Theodora via Tailscale (`id_ed25519_madre`)
> **Fecha:** Sábado 2026-07-18 ~04:38 CEST

---

## 🖥️ Estado Hardware

| Métrica | Valor |
|---|---|
| Uptime | 1h 03min, 2 usuarios |
| Load average | 2.46 / 3.34 / 3.89 (carga moderada-alta) |
| Disco `/` | 930 GB total — 400 GB usados — 530 GB libres (43%) |
| Filesystem | `/dev/mapper/root` (LUKS/btrfs) |

### Temperaturas

| Sensor | Valor | Límite |
|---|---|---|
| CPU Package | 54°C | 82°C high / 100°C crit |
| Core 0 | 54°C | ✅ |
| Core 1 | 53°C | ✅ |
| Core 2-5 | 51-52°C | ✅ |
| ACPI temp1 | 27.8°C | ✅ |
| GPU GTX 1060 | 57°C, **11.62 W** | ✅ (idle muy eficiente) |

> ⚠️ La GPU en sesión anterior marcaba 57°C/37W. Esta sesión: 57°C/11.62W — carga mínima, correcto.

---

## 💾 Salud SMART del HDD

```
smartctl -a /dev/sda
```

| Atributo | Valor | Estado |
|---|---|---|
| Reallocated_Sector_Ct | 0 | ✅ |
| Power_On_Hours | **29,007 horas** (~3.3 años encendido) | ⚠️ Alto |
| Temperature_Celsius | 45°C | ✅ |
| Reallocated_Event_Count | 0 | ✅ |
| Current_Pending_Sector | 0 | ✅ |

> ⚠️ **29,007 horas** es un umbral de deuda de hardware real. Sin sectores problemáticos hoy, pero el riesgo de fallo aumenta estadísticamente con esta antigüedad. **Deuda pendiente: valorar SSD de reemplazo.**

---

## 📂 Estructura Real de Directorios

### Home (`/home/varopc/`)

```
~/
├── audits/              (3 Jul)
├── docker/              (23 Jun)
├── Documents/
├── Downloads/
├── isos/
├── Obsidian/            (24 Jun)
├── Projects/
│   ├── personal/        ← repo git
│   └── thdora/          ← repo git (9 Jul)
├── repos/
│   └── madre-config/    ← RUTA CANÓNICA de madre-config ✅
├── spiderfoot/
├── WIKI---PERSONAL/     (9 Jul)
├── Work/
├── ygg/
│   ├── yggdrasil-formacion/
│   └── yggdrasil-tracking/
├── yggdrasil-dew/       (14 Jul)
├── yggdrasil-formacion-/
└── yggdrasil-secops/    (12 Jul)
```

### Corrección de rutas (vs. documentación anterior)

| Doc anterior decía | Ruta real |
|---|---|
| `~/Projects/madre-config` | ❌ No existe |
| `~/repos/madre-config` | ✅ Correcto |
| `~/Projects/thdora` | ✅ Existe |

---

## ⏰ Scheduler — crontab vs systemd timers

**`crontab` NO está instalado en este sistema.** El scheduler nativo es `systemd timers`.

```bash
which crontab  # → not found
```

### Timers activos (systemd)

| Timer | Próxima ejecución | Servicio |
|---|---|---|
| snapper-timeline.timer | 05:00 CEST | snapper-timeline.service |
| shadow.timer | Dom 00:00 | shadow.service |
| man-db.timer | Dom 00:36 | man-db.service |
| systemd-tmpfiles-clean.timer | Dom 03:50 | systemd-tmpfiles-clean.service |
| archlinux-keyring-wkd-sync.timer | Dom 26 Jul | archlinux-keyring-wkd-sync.service |
| plocate-updatedb.timer | (ejecutado 04:29) | plocate-updatedb.service |

> ✅ **Decisión:** El mantenimiento semanal de `clean-root-artifacts` (Issue #1) debe implementarse como **systemd timer**, NO como crontab. Ver `/systemd/` en esta repo.

---

## 🌐 Red y Firewall (UFW)

Estado: **active** — 51 reglas totales.

### Reglas principales

| Regla | Puerto | Origen | Nota |
|---|---|---|---|
| SSH | 22/tcp | Anywhere | ⚠️ Abierto a todo — revisar |
| n8n | 5678/tcp | Tailscale + LAN | Docker |
| Portainer | 9000/tcp | Tailscale + LAN | Docker |
| Gitea SSH | 2222 | Tailscale + LAN | Docker |
| Grafana | 3000/tcp | Tailscale + LAN | Docker |
| Prometheus | 9090/tcp | Tailscale + LAN | Docker |
| Netdata | 19999 | LAN + MadreAP | Nativo |
| Ollama | 11434/tcp | Tailscale | Docker |
| Qdrant | 6333/tcp + 6334/tcp | Tailscale + LAN | Docker |
| SearXNG | 8000/tcp | Tailscale + LAN | Docker |
| Pihole | 5001/tcp | Tailscale + LAN | Docker |
| kasm | 6901/tcp | Tailscale + LAN | Docker |
| Caddy/proxy | 8443/tcp | Tailscale + LAN | Docker |
| App 3001 | 3001 | Tailscale + LAN + MadreAP | Docker |
| App 3002-3003 | 3002-3003 | Tailscale + LAN | Docker |
| DENY input-leaps | 24800 | Anywhere | ✅ Bloqueado |
| DENY mDNS | 5355 | Anywhere | ✅ Bloqueado |

### Puerto 53317 — Resolución

```bash
sudo ss -lntup | grep 53317  # → sin output
sudo iptables -S | grep 53317  # → sin output
```

> ✅ **Puerto 53317 NO está activo ni escuchando.** La referencia en issues anteriores está **obsoleta**.
> La regla UFW asociada tampoco aparece en el estado actual.
> **Acción:** Cerrar/actualizar Issue #2 y #3 que mencionaban este puerto.

### input-leaps (24800)

```bash
tcp LISTEN 3 0.0.0.0:24800  users:("input-leaps",pid=1887,fd=6)
```

> `input-leaps` (fork open-source de Synergy/Barrier para compartir teclado/ratón KVM virtual) está activo en el puerto `24800`, pero la regla UFW lo tiene como `DENY IN`. Esto es correcto — corre localmente pero no acepta conexiones externas.

---

## 🐳 Servicios Docker Activos

```bash
sudo ss -lntup | grep docker-proxy
```

| Puerto | Proceso | Servicio probable |
|---|---|---|
| 2222 (tcp+v6) | docker-proxy pid=6567/6574 | Gitea SSH |
| 3000 (tcp+v6) | docker-proxy pid=5850/5857 | Grafana |
| 3002 (tcp+v6) | docker-proxy pid=6408/6415 | App personalizada |
| 3003 (tcp+v6) | docker-proxy pid=6588/6595 | App personalizada |
| 5001 (tcp+v6) | docker-proxy pid=7482/7493 | Pihole web |
| 5678 (tcp+v6) | docker-proxy pid=4599/4610 | n8n |
| 6333 (tcp+v6) | docker-proxy pid=4015/4024 | Qdrant HTTP |
| 6334 (tcp+v6) | docker-proxy pid=7804/… | Qdrant gRPC |
| 6901 (tcp+v6) | docker-proxy pid=10070/10077 | Kasm VNC |
| 8000 (tcp+v6) | docker-proxy pid=4124/4132 | SearXNG |
| 8443 (tcp+v6) | docker-proxy pid=7704/7711 | Caddy HTTPS |
| 9000 (tcp+v6) | docker-proxy pid=4015/4024 | Portainer |
| 9090 (tcp+v6) | docker-proxy pid=7802/7809 | Prometheus |

---

## ✅ Servicios del Sistema

```bash
systemctl is-active hostapd dnsmasq fail2ban tailscaled sshd ufw
```

| Servicio | Estado |
|---|---|
| hostapd | ✅ active |
| dnsmasq | ✅ active |
| fail2ban | ✅ active |
| tailscaled | ✅ active |
| sshd | ✅ active |
| ufw | ✅ active |

### Otros servicios identificados

| Proceso | PID | Nota |
|---|---|---|
| netdata | 1029 | Monitoreo nativo (19999) |
| input-leaps | 1887 | KVM virtual — UFW deniega externo |
| cupsd | 929 | CUPS impresión (solo localhost) |
| avahi-daemon | 927 | mDNS — UFW deniega 5355 |
| containerd | 2870 | Docker runtime |

---

## 🗂️ Repos Locales en Madre

| Ruta | Repo |
|---|---|
| `/home/varopc/Projects/thdora` | thdora |
| `/home/varopc/Projects/personal` | personal |
| `/home/varopc/repos/madre-config` | madre-config ← canónico |

> ⚠️ Existen múltiples copias de directorios `thdora/` en distintas rutas:
> - `~/Projects/thdora` (repo git principal)
> - `~/Projects/thdora/proyectos/thdora`
> - `~/Projects/personal/03_proyectos/thdora`
> - `~/repos/VIDAPERSONAL/03_proyectos/thdora`
> - `~/ygg/yggdrasil-formacion/03_proyectos/thdora`
> - `~/ygg/yggdrasil-tracking/proyectos/thdora`
> - `~/yggdrasil-formacion-/03_proyectos/thdora`
>
> Requiere limpieza — solo `~/Projects/thdora` debe ser el repo activo.

---

## 🔧 Pendientes Derivados de Esta Auditoría

| Prioridad | Tarea | Issue relacionado |
|---|---|---|
| 🔴 Alta | Implementar `clean-root-artifacts` como **systemd timer** (no crontab) | #1 |
| 🔴 Alta | Actualizar Issue #1: cambiar ruta de `~/Projects/madre-config` a `~/repos/madre-config` | #1 |
| 🟡 Media | Cerrar Issue #2 y #3 sobre puerto 53317 — ya no está activo | #2 #3 |
| 🟡 Media | Limpiar duplicados de `thdora/` en rutas no-git | — |
| 🟡 Media | Identificar qué es el Docker en puerto 3002 y 3003 | — |
| 🟢 Baja | Valorar instalación de SSD para reemplazar HDD (29k horas) | #3 |
| 🟢 Baja | Revisar regla SSH `22/tcp ALLOW IN Anywhere` — restringir a Tailscale | #3 |

---

## 📋 Contexto del Sistema (hostnamectl)

```
Static hostname: varpc
Icon name:       computer-desktop
Chassis:         desktop
OS:              Arch Linux
Kernel:          Linux 7.0.9-arch2-1
Architecture:    x86-64
Hardware Vendor: ASUSTeK COMPUTER INC.
Hardware Model:  PRIME B360M-A
Firmware:        0403 — 2018-04-18 (8 años)
```

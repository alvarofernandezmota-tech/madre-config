---
tipo: doc
author: Alvaro Fernandez Mota <alvarofernandezmota@gmail.com>
creado: 2026-06-01 00:00 CEST
actualizado: 2026-07-05 12:24 CEST
ruta: README.md
tags: [madre, infra, servidor, ecosistema]
status: vigente
---

# 🖥️ madre-config

> Configuración, scripts y documentación del servidor Madre.
> Madre es el núcio del ecosistema Yggdrasil — servidor HP Ubuntu local con acceso por Tailscale.

---

## Identidad

| Campo | Valor |
|---|---|
| Hostname | `varpc` |
| Usuario | `varopc` |
| OS | Ubuntu Server |
| Cifrado | LUKS + Btrfs |
| GPU | GTX 1060 (Ollama) |
| Red principal | WiFi `wlan0` 192.168.72.1 |
| VPN | Tailscale `100.91.112.32` |
| SSH | Puerto 22, solo clave pública |

---

## Stack Docker

| Servicio | Puerto | Estado |
|---|---|---|
| THDORA API | 8000 | ✅ healthy |
| THDORA Bot | — | ✅ healthy |
| Grafana | 3000 | ▶ running |
| Prometheus | 9090 | ▶ running |
| Uptime Kuma | 3002 | ✅ healthy |
| Portainer | 9000 | ▶ running |
| Gitea | 3003 | ▶ running |
| n8n | 5678 | ▶ running |
| Code-server | 8443 | ▶ running |
| Ollama | 11434 | ▶ running |
| Open WebUI | — | ▶ running |
| Qdrant | 6333 | ▶ running |
| Spiderfoot | 5001 | ▶ running |
| Kali (VNC) | 6901 | ▶ running |
| Network Radar | — | ✅ healthy |
| Guardian Bot | — | ✅ healthy |

---

## Estructura

```
madre-config/
├── README.md              ← este fichero
├── ansible/               ← playbooks de bootstrap
├── systemd/               ← servicios systemd custom
├── scripts/
│   ├── sesion-inicio.sh   ← graba terminal de sesión
│   └── sesion-fin.sh      ← cierra y guarda la sesión
└── docs/
    ├── estado-actual.md   ← snapshot infra
    └── MAPA-FICHEROS-MADRE.md
```

---

## Acceso desde iPhone (Blink)

```
Host:    100.91.112.32
Usuario: varopc
Auth:    SSH Key (varo12f-to-madre)
App:     Blink Shell o Shellfish
```

---

_Actualizado: 2026-07-05 · Perplexity-MCP_

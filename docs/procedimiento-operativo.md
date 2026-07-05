---
tipo: infra
creado: 2026-07-01
actualizado: 2026-07-05
ruta: docs/procedimiento-operativo.md
tags: [madre, procedimiento, docker, ollama, ssh]
status: vigente
---

# Procedimiento Madre — Infraestructura

> Migrado desde inbox/PROCEDIMIENTO-MADRE-HOY.md — 2026-07-01

---

## Arranque del sistema

```bash
systemctl status ollama
systemctl status hostapd
tmux ls
docker ps -a
ip addr show && tailscale status
```

## Docker Stack — Levantar todo

```bash
docker compose -f ~/yggdrasil-dew/osint-stack/docker-compose.yml up -d
```

## SSH desde exterior

```bash
# Desde theodora
ssh madre

# Desde iPhone (Tailscale)
ssh -i ~/.ssh/id_ed25519 varopc@100.91.112.32
```

## MadreAP — WiFi AP

```bash
cat /var/lib/misc/dnsmasq.leases
ip neigh show dev wlan0
sudo systemctl restart hostapd dnsmasq
```

## Ollama

```bash
ollama list
ollama run llama3.2:3b
curl http://localhost:11434/api/generate -d '{"model":"llama3.2:3b","prompt":"hola"}'
```

_Migrado desde raíz — 2026-07-05 · Perplexity-MCP_

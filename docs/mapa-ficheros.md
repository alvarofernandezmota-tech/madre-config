---
tipo: infra
creado: 2026-07-03
actualizado: 2026-07-05
ruta: docs/mapa-ficheros.md
tags: [madre, rutas, docker, scripts]
status: vigente
---

# 🗺️ MAPA DE FICHEROS — MADRE

> Rutas absolutas de todo lo relevante en Madre (varpc, 100.91.112.32)
> **Última verificación**: 2026-07-03 — TTL: 14 días

---

## Usuarios y home

```
/home/varopc/
  yggdrasil-dew/                         ← repo ecosistema (git) ✅
  Projects/
    thdora/                              ← bot principal (git) ✅
      docker-compose.yml                 ← compose PRINCIPAL thdora ✅
      docker/
        docker-compose.yml               ← compose modular
  spiderfoot/
    docker-compose.yml
  docker/
    batcueva-nueva/
      docker-compose.yml
  .ssh/
    id_ed25519_github                    ← clave SSH GitHub
```

---

## Docker — compose files

```
/home/varopc/Projects/thdora/docker-compose.yml         ← PRINCIPAL
/home/varopc/Projects/thdora/docker/docker-compose.yml
/home/varopc/spiderfoot/docker-compose.yml
/home/varopc/docker/batcueva-nueva/docker-compose.yml
```

---

## Scripts activos

```
~/yggdrasil-dew/scripts/maintenance/
  new-session.sh
  close-session.sh
  fix-unhealthy.sh
  notify-on-change.py
```

---

## Diagnóstico rápido

```bash
echo '=== REPOS ===' && ls ~/yggdrasil-dew/ | head -5 && ls ~/Projects/ && \
echo '=== DOCKER ===' && docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' && \
echo '=== CRONTAB ===' && crontab -l 2>/dev/null || echo 'sin crontab'
```

_Migrado desde raíz — 2026-07-05 · Perplexity-MCP_

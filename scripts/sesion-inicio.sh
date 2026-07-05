#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# =============================================================================
# Nombre:        sesion-inicio.sh
# Función única: Inicia una sesión de trabajo grabando todo lo que pasa en terminal
# Rol:           logger
# Versión:       1.0
# Autor:         Alvaro Fernandez Mota <alvarofernandezmota@gmail.com>
# Creado:        2026-07-05 12:00 CEST
# Actualizado:   2026-07-05 12:00 CEST
# Ruta:          scripts/sesion-inicio.sh
# Tags:          [sesion, logger, terminal]
# Uso:
#   bash scripts/sesion-inicio.sh
#   alias inicio='bash ~/repos/madre-config/scripts/sesion-inicio.sh'
# =============================================================================

log(){ printf '%s %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$*"; }
on_err(){ log "ERROR at line $1"; exit 2; }
trap 'on_err $LINENO' ERR

LOGDIR="$HOME/logs/sesiones"
mkdir -p "$LOGDIR"

TIMESTAMP="$(date +%Y%m%dT%H%M%S)"
LOGFILE="$LOGDIR/${TIMESTAMP}-sesion.log"

export SESION_LOG="$LOGFILE"
export SESION_INICIO="$(date '+%Y-%m-%d %H:%M CEST')"

log "=== SESIÓN INICIADA: $SESION_INICIO ==="
log "Log: $LOGFILE"
log "Para cerrar: escribe 'fin' o ejecuta sesion-fin.sh"
echo ""

# Mostrar estado rápido
echo "--- GIT STATUS ---"
cd "$HOME/repos/yggdrasil-dew" 2>/dev/null && git log --oneline -3 || true
echo ""
echo "--- DOCKER (unhealthy) ---"
docker ps --filter health=unhealthy --format 'table {{.Names}}\t{{.Status}}' 2>/dev/null || true
echo ""

# Grabar todo lo que pase en la sesión
script -a -f "$LOGFILE"

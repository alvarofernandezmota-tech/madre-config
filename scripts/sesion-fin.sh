#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# =============================================================================
# Nombre:        sesion-fin.sh
# Función única: Cierra la sesión grabada y registra el cierre en el log
# Rol:           logger
# Versión:       1.0
# Autor:         Alvaro Fernandez Mota <alvarofernandezmota@gmail.com>
# Creado:        2026-07-05 12:00 CEST
# Actualizado:   2026-07-05 12:00 CEST
# Ruta:          scripts/sesion-fin.sh
# Tags:          [sesion, logger, terminal]
# Uso:
#   bash scripts/sesion-fin.sh   (dentro de la sesión grabada)
#   alias fin='bash ~/repos/madre-config/scripts/sesion-fin.sh'
# =============================================================================

log(){ printf '%s %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$*"; }

FIN="$(date '+%Y-%m-%d %H:%M CEST')"

if [[ -n "${SESION_LOG:-}" ]]; then
  log "=== SESIÓN CERRADA: $FIN ==" >> "$SESION_LOG"
  log "Log guardado en: $SESION_LOG"
  echo ""
  echo "Log guardado en: $SESION_LOG"
else
  log "AVISO: \$SESION_LOG no definida — ¿ejecución fuera de sesión grabada?"
fi

# Esto cierra el proceso script(1) y la terminal
exit

#!/bin/bash

###############################################################################
# 🔍 AUDITORÍA COMPLETA MADRE
# Script para capturar estado actual del servidor
# Uso: bash audit-madre-completo.sh > audit-report-$(date +%Y%m%d-%H%M%S).txt
###############################################################################

set -e

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
HOSTNAME=$(hostname)
KERNEL=$(uname -r)

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║         🔍 AUDITORÍA COMPLETA MADRE - $TIMESTAMP"
echo "║         Host: $HOSTNAME | Kernel: $KERNEL"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# ============================================================================
# 1️⃣ SISTEMA BASE
# ============================================================================
echo "📊 1. INFORMACIÓN DEL SISTEMA"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Hostname: $HOSTNAME"
echo "Kernel: $KERNEL"
echo "OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
uptime
echo ""

# ============================================================================
# 2️⃣ RECURSOS
# ============================================================================
echo "💾 2. RECURSOS DEL SISTEMA"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📈 CPU:"
nproc
lscpu | grep "Model name"
echo ""
echo "🧠 RAM:"
free -h
echo ""
echo "💿 DISCO:"
df -h
echo ""
echo "🔍 Inodos:"
df -i
echo ""

# ============================================================================
# 3️⃣ DOCKER
# ============================================================================
echo "🐳 3. DOCKER - ESTADO ACTUAL"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Versión Docker:"
docker --version 2>/dev/null || echo "❌ Docker no instalado"
echo ""
echo "Versión Docker Compose:"
docker-compose --version 2>/dev/null || docker compose version 2>/dev/null || echo "❌ Docker Compose no instalado"
echo ""
echo "🔴 Contenedores CORRIENDO:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Image}}" 2>/dev/null || echo "❌ No hay contenedores"
echo ""
echo "⚠️ Contenedores PARADOS:"
docker ps -a --filter status=exited --format "table {{.Names}}\t{{.ExitCode}}\t{{.Image}}" 2>/dev/null || echo "Ninguno"
echo ""
echo "📊 Uso de Docker:"
docker system df 2>/dev/null || echo "❌ No disponible"
echo ""
echo "🗂️ Ubicación docker-compose.yml:"
if [ -f docker-compose.yml ]; then
    echo "✅ Encontrado: $(pwd)/docker-compose.yml"
    echo "Tamaño: $(du -h docker-compose.yml | cut -f1)"
elif [ -f /opt/docker-compose.yml ]; then
    echo "✅ Encontrado: /opt/docker-compose.yml"
elif [ -f ~/docker-compose.yml ]; then
    echo "✅ Encontrado: ~/docker-compose.yml"
else
    echo "❌ No encontrado docker-compose.yml"
fi
echo ""

# ============================================================================
# 4️⃣ PUERTOS ESCUCHANDO
# ============================================================================
echo "🔌 4. PUERTOS ABIERTOS/ESCUCHANDO"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if command -v ss &> /dev/null; then
    ss -tlnp 2>/dev/null | grep LISTEN
else
    netstat -tlnp 2>/dev/null | grep LISTEN || echo "❌ Comandos no disponibles"
fi
echo ""

# ============================================================================
# 5️⃣ SERVICIOS SYSTEMD
# ============================================================================
echo "⚙️ 5. SERVICIOS SYSTEMD ACTIVOS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
systemctl list-units --type=service --state=running --no-pager --output=short 2>/dev/null | grep -v "^UNIT" | head -20
echo ""

# ============================================================================
# 6️⃣ PROCESOS PRINCIPALES
# ============================================================================
echo "⚡ 6. TOP 10 PROCESOS POR CPU/MEMORIA"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Por CPU:"
ps aux --sort=-%cpu | head -6
echo ""
echo "Por Memoria:"
ps aux --sort=-%mem | head -6
echo ""

# ============================================================================
# 7️⃣ REDES
# ============================================================================
echo "🌐 7. CONFIGURACIÓN DE RED"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Interfaces:"
ip addr show 2>/dev/null || ifconfig
echo ""
echo "Rutas:"
ip route 2>/dev/null | head -5 || route
echo ""
echo "DNS:"
cat /etc/resolv.conf 2>/dev/null | grep nameserver || echo "❌ No disponible"
echo ""

# ============================================================================
# 8️⃣ ALMACENAMIENTO
# ============================================================================
echo "📂 8. ALMACENAMIENTO"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Discos detectados:"
lsblk -d -o NAME,SIZE,TYPE 2>/dev/null || fdisk -l | grep "^Disk"
echo ""
echo "Volúmenes montados:"
mount | grep -E "^/dev" | head -10
echo ""

# ============================================================================
# 9️⃣ LOGS RECIENTES
# ============================================================================
echo "📋 9. LOGS DEL SISTEMA (últimas 20 líneas)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Systemd journal:"
journalctl -n 20 --no-pager -p err..alert 2>/dev/null || echo "❌ No disponible"
echo ""

# ============================================================================
# 🔟 USUARIO Y PERMISOS
# ============================================================================
echo "👤 10. USUARIO ACTUAL Y PERMISOS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Usuario: $(whoami)"
echo "UID: $(id -u)"
echo "Grupos: $(groups)"
echo ""
echo "Permisos sudo:"
sudo -l 2>/dev/null | grep -v "^[Ll]ectura" || echo "Sin acceso sudo info"
echo ""

# ============================================================================
# 1️⃣1️⃣ VARIABLES DE ENTORNO
# ============================================================================
echo "🔧 11. VARIABLES DE ENTORNO IMPORTANTES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "PATH:"
echo "$PATH" | tr ':' '\n' | head -10
echo ""
echo "Otras variables (seleccionadas):"
env | grep -i "docker\|compose\|home\|shell" | sort
echo ""

# ============================================================================
# 1️⃣2️⃣ ARCHIVOS IMPORTANTES
# ============================================================================
echo "📄 12. ARCHIVOS Y CARPETAS IMPORTANTES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "En /opt:"
ls -lah /opt 2>/dev/null || echo "❌ No accesible"
echo ""
echo "En $HOME:"
ls -lah ~/ 2>/dev/null | head -20 || echo "❌ No accesible"
echo ""
echo "Archivos de configuración en /etc (seleccionados):"
find /etc -maxdepth 1 -type f -name "*.conf" 2>/dev/null | head -10
echo ""

# ============================================================================
# 1️⃣3️⃣ SALUD GENERAL
# ============================================================================
echo "🏥 13. SALUD DEL SISTEMA"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Temperatura CPU (si disponible):"
sensors 2>/dev/null | grep -i "^Core\|^Temp" || echo "❌ lm-sensors no instalado"
echo ""
echo "S.M.A.R.T. (si disponible):"
smartctl -H /dev/sda 2>/dev/null || echo "❌ smartmontools no instalado o no disponible"
echo ""
echo "Load average:"
cat /proc/loadavg
echo ""

# ============================================================================
# FINAL
# ============================================================================
echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║ ✅ AUDITORÍA COMPLETADA - $TIMESTAMP"
echo "║ Información guardada en este archivo"
echo "╚════════════════════════════════════════════════════════════════╝"

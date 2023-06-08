#!/usr/bin/env bash
# exit on error
set -o errexit

# Instalar dependencias
poetry install --no-root

# Ejecutar comandos de construcción
python manage.py collectstatic --no-input
python manage.py migrate

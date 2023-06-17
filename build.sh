#!/bin/bash

# Salir en caso de error
set -e

# Ejecutar los comandos necesarios
poetry install
python manage.py collectstatic --no-input
python manage.py migrate

# Comprobar si hubo errores en la ejecución
if [ $? -eq 0 ]; then
  # No hubo errores
  echo "Build exitoso."
  echo
  echo "Registro de salida:"
  echo
  cat "$TEMP/build_success.log"
  rm "$TEMP/build_success.log"
else
  # Hubo errores
  echo "Build fallido. Se encontraron errores durante la ejecución."
  echo
  echo "Registro de errores:"
  echo
  cat "$TEMP/build_err.log"
  rm "$TEMP/build_err.log"
  exit 1
fi

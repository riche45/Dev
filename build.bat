@echo off
REM Salir en caso de error
setlocal enabledelayedexpansion
set "ERR_FILE=%TEMP%\build_err.log"
set "SUCCESS_FILE=%TEMP%\build_success.log"

REM Ejecutar los comandos necesarios
poetry install
python manage.py collectstatic --no-input
python manage.py migrate

REM Comprobar si hubo errores en la ejecución
IF NOT EXIST %ERR_FILE% (
  REM No hubo errores
  echo Build exitoso.
  echo.
  echo Registro de salida:
  echo.
  type %SUCCESS_FILE%
  del %SUCCESS_FILE% > nul
) ELSE (
  REM Hubo errores
  echo Build fallido. Se encontraron errores durante la ejecución.
  echo.
  echo Registro de errores:
  echo.
  type %ERR_FILE%
  del %ERR_FILE% > nul
  exit /b 1
)

@echo off
echo ==========================================================
echo   Herramienta de Edicion de Archivos PowerApps MSAPP
echo ==========================================================
echo.

:: 1. Solicitar el nombre del archivo .msapp
set /p msapp_file="Ingresa el nombre del archivo .msapp (ejemplo: mi_aplicacion.msapp): "

echo.
echo [1/3] Desempaquetando %msapp_file%...
call pac canvas unpack --msapp "%msapp_file%" --sources "./src"

:: Validar si hubo un error en el comando anterior
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Hubo un problema al desempaquetar. Revisa que el nombre sea correcto y el archivo exista.
    pause
    exit /b
)

echo.
echo [2/3] Archivos desempaquetados. 
echo Ahora puedes buscar el archivo .fx.yaml que desees editar dentro de la carpeta "src" usando este mismo editor.
echo Por favor realiza los cambios necesarios y guarda el archivo usando "Ctrl + S".
echo.

:: Ciclo para esperar la palabra "ya"
:esperar
set /p input_ya="Cuando hayas terminado de editar y guardar, escribe 'ya' y presiona Enter para empaquetar: "
if /i not "%input_ya%"=="ya" (
    echo No has escrito "ya". Sigo esperando...
    goto esperar
)

echo.
echo [3/3] Empaquetando nuevamente a %msapp_file%...
call pac canvas pack --msapp "%msapp_file%" --sources "./src"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Hubo un problema al empaquetar la aplicacion.
    pause
    exit /b
)

echo.
echo ==========================================================
echo   Proceso finalizado con exito!
echo ==========================================================
pause

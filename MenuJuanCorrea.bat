@echo off

title  Juan David Correa Zapata

:MENU
cls
echo.
echo.
echo. Hola, bienvenido/a a tu proceso de automatizacion
echo. 
echo. 
rem CREO EL MENU CON LAS OPCIONES QUE OFRECE
echo. **MENU AUTOMATIZACION**
echo. 1- Creacion carpeta DATOS_SISTEMA
echo. 2- Obtener nombre de usuario
echo. 3- Obtener el serial del equipo
echo. 4- Obtener la mayor informacion de la configuracion de red del equipo 
echo. 5- Politicas de grupos del sistema operativo 
echo. 6- Consultar la tabla de enrutamiento del equipo
echo. 7- Registro de la Limpieza  los temporales del navegador  
echo. 8- Obtener una lista de todo lo que hay en el directorio Temporal
echo. 9- Mostrar el contenido de la memoria cache de resolucion de DNS
echo. 10- Consultar los atributos de los archivos y carpeta
echo. 11- Salir

echo.
echo.
echo.
REM ACA DECLARO UNA VARIABLE QUE SE ENCARGA DE OBTENER LA RESPUESTA Y ASIGNARLA A UNA ETIQUETA O FUNCION
set /p res= Elija una opcion:
if %res%== 1 goto :CARPETA
if %res%== 2 goto :USUARIO
if %res%== 3 goto :SERIAL
if %res%== 4 goto :RED
if %res%== 5 goto :POLITICAS
if %res%== 6 goto :ENRUTAMIENTO
if %res%== 7 goto :LIMPIEZA
if %res%== 8 goto :DIRECTORIOTEMPORAL
if %res%== 9 goto :DNS
if %res%== 10 goto :ATRIBUTOS
if %res%== 11 exit
if %res% GEQ 12 goto :Error
pause>nul
goto :MENU



rem EN ESTA ETIQUETA ME ENCARGO DE GESTIONAR EN DONDE VA A QUEDAR GUARDADA LA CARPETA, GUARDO LA RUTA EN UNA VARIABLE PARA LUEGO USARLA EN EL RESTO DE ETIQUETAS
:CARPETA
cd /d C:\
echo. ¿En donde quisiera crear su carpeta?
dir
set /p resCarpeta= Elija un directorio
cd %resCarpeta%
echo. Estas en el siguiente directorio:
cd
md DATOS_SISTEMA
echo. Carpeta creada con exito
cd DATOS_SISTEMA
rem Capturo la ruta en donde queda la carpeta
set "ruta_carpeta=%CD%"
rem Imprimir la ruta en donde queda la carpeta
echo La ruta de su carpeta es: %ruta_carpeta%
pause
goto :MENU
exit /b

rem ACA ME ENCARGO DE QUE ESA VARIABLE DECLARADA EN LA ETIQUETA CARPETA SE PUEDA USAR EN EL RESTO DE ETIQUETAS
call :CARPETA
call :USUARIO %ruta_carpeta% 
call :SERIAL %ruta_carpeta% 
call :RED %ruta_carpeta% 
call :POLITICAS %ruta_carpeta% 
call :ENRUTAMIENTO %ruta_carpeta% 
call :LIMPIEZA %ruta_carpeta% 
call :DIRECTORIOTEMPORAL %ruta_carpeta% 
call :DNS %ruta_carpeta% 
call :ATRIBUTOS %ruta_carpeta% 

rem ACA SE GESTIONA LA FUNCION DE OBTENER EL USUARIO MEDIANTE EL COMANDO ESTIPULADO PARA ESO Y CREO EL ARCHIVO DE TEXTO CON SU RESPECTIVO NOMBRE
:USUARIO
cd %ruta_carpeta%
query user
query user > Usuario.txt
echo. Se ha creado el archivo de texto con el usuario activo satisfactoriamente.
pause
goto :MENU


rem EN ESTA ETIQUETA SE OBTIENE EL SERIAL DEL EQUIPO MEDIANTE UN COMANDO DESIGNADO PARA ELLO PARA DESPUES GUARDARLO EN EL ARCHIVO DE TEXTO 
:SERIAL
cd %ruta_carpeta%
wmic bios get serialnumber
wmic bios get serialnumber > Serial.txt
echo. Se ha creado el archivo de texto con el serial del equipo satisfactoriamente.
pause
goto :MENU


rem SE OBTIENE LA INFORMACION DE LA RED DEL EQUIPO CON EL COMANDO IPCONFIG Y SE TRASLADA LA INFO AL ARCHIVO DE TEXTO
:RED
cd %ruta_carpeta%
ipconfig 
ipconfig > Red.txt
echo. Se ha creado el archivo de texto con la informacion de su red satisfactoriamente.
pause
goto :MENU



rem ACA SE PUEDE VER LA INFO DE LOS GRUPOS OPERATIVOS EN EL SISTEMA OPERATIVO Y SUS POLITICAS
:POLITICAS
cd %ruta_carpeta%
gpresult /r
gpresult /r > Politicas.txt
echo. Se ha creado el archivo de texto con la informacion de las politicas del sistema operativo satisfactoriamente.
pause
goto :MENU



rem EN ESTA ETIQUETA SE OBTIENE LA LISTA DE ENRUTAMIENTO DEL EQUIPO Y SE ENVIA LA INFO AL ARCHIVO DE TEXTO
:ENRUTAMIENTO
cd %ruta_carpeta%
netstat -r 
netstat -r > TblEnrutamiento.txt
echo. Se ha creado el archivo de texto con la informacion de la tabla de enrutamiento satisfactoriamente.
pause
goto :MENU


rem EN ESTA FUNCION SE LLEVA AL ARCHIVO DE TEXTO LAS PRINCIPALES CLAVES DE REGISTRO DE LOS NAVEGADORES WEB MAS USADOS
:LIMPIEZA
cd %ruta_carpeta%
echo HKEY_CURRENT_USER\Software\Google\Chrome HKEY_CURRENT_USER\Software\Mozilla\Firefox  HKEY_CURRENT_USER\Software\Microsoft\Edge > Limpieza.txt
echo Se ha creado el archivo de texto con la informacion de los registros de la eliminacion de archivos temporales del navegador satisfactoriamente.
pause
goto :MENU


rem SE ACCEDE AL DIRECTORIO TEMPORAL MEDIANTE LA VARIABLE GLOBAL Y SE GUARDA LA INFO AL RESPECTIVO ARCHIVO DE TEXTO
:DIRECTORIOTEMPORAL
cd %ruta_carpeta%
dir %TEMP% 
dir %TEMP% > GET.TXT
echo. Se ha creado el archivo de texto con la informacion del directorio temporal satisfactoriamente.
pause
goto :MENU


rem OBTENEMOS LA LISTA DEL CONTENIDO DE MEMORIA CACHE DEL DNS DEL EQUIPO
:DNS
cd %ruta_carpeta%
ipconfig /displaydns
ipconfig /displaydns > DNS.txt
echo. Se ha creado el archivo de texto con la informacion del DNS satisfactoriamente.
pause
goto :MENU


rem ACA PODEMOS CONSULTAR Y TRASLADAR LA INFO DE LAS PROPIEDADES DE LA CARPETA Y SUS ARCHIVOS ENLISTADOS
:ATRIBUTOS
cd %ruta_carpeta%
dir /a /s "%ruta_carpeta%"
dir /a /s "%ruta_carpeta%" > Atributos.txt
echo Se ha creado el archivo de texto con los atributos de la carpeta y sus archivos.
pause
goto :MENU
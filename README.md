# CinemaFan

## Preparación para el ambiente de desarrollo

1. Copiar el archivo .env.template y renombrar la copia a .env

2. Completar las variables de entorno con valores de desarrollo

3. Cuando se hacen cambios en las entidades se debe ejecutar:

``` bash
        flutter pub run build_runner build
```

## Preparación para el ambiente de release

1. Cambiar nombre de la aplicación:
   Instalar el paquete 'change_app_package_name' como DEV dependency
   Y ejecutar esta instrucción

``` bash
        flutter pub run change_app_package_name:main me.ferpaz.cinemafan
```

2. Generar el ícono de la aplicación

   Instalar el paquete 'flutter_launcher_icons' como DEV dependency

   Agregar al pubspec.yaml, las instrucciones para que se generen los íconos

   Y luego ejecutar esta instrucción

``` bash
        flutter pub run flutter_launcher_icons
```

3. Cambiar el Splash Screen

   Instalar el paquete 'flutter_native_splash'

   Modificar el pubspec.yaml con la configuración deseada

   Y luego se ejecuta esta instrucción para crear el splash screen

``` bash
        dart run flutter_native_splash:create
```

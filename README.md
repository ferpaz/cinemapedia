# Cinema Fan

   Enciclopedia de películas y series para entusiastas del cine y las series

## Descripción

   Además de permitirte buscar por nombre de la película o serie, te permite buscar actores o miembros del casting, así como del equipo técnico que la produjo.

   Te permite además marcar como favoritas aquellas producciones que más te han gustado y crear listas de estrenos por ver o de temas que se adapten a tu manera de disfrutar del cine y las series.

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

4. Generate Android AAB

   Se genera el JKS (keystore certificate) y se copia en el folder /android/app

   Luego se ejecuta este commando

``` bash
        flutter build appbundle
```

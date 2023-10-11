# CinemaFan

## Preparación para el ambiente de desarrollo

1. Copiar el archivo .env.template y renombrar la copia a .env

2. Completar las variables de entorno con valores de desarrollo

3. Cuando se hacen cambios en las entidades se debe ejecutar:

        flutter pub run build_runner build

## Preparación para el ambiente de release

1. Cambiar nombre de la aplicación:

        flutter pub run change_app_package_name:main me.ferpaz.cinemafan



        -------------- NAVEGACIÓN + FIREBASE --------------------
PASO 0;
    -CONECTAR FIREBASE CON LA APP.
        COMANDO;
            - firebase login
            - flutterfire configure
        DEPENDENCIAS;
            - go_router: ^13.2.0
            - firebase_core: ^3.15.2
            - firebase_auth: ^5.7.0
PASO 1; 
    - HACER LOGIN PAGE Y REGISTER. 
PASO 2;
    - HACER EL GO_ROUTER.
PASO 3;
    - IR AL MY_APP , Y AÑADIR EL MATERIARL.ROUTER.
PASO 4;
    - HACER EL DRAWER.
PASO 5;
    - AÑADIRLO AL HOME O, A LA CLASE QUE PIDA.
PASO 6;
    - HACER EL NAVIGATION BAR, SI LO PIDE.
PASO 7;
    - HACER EL FIRESTORE. 
        - DEPENDENCIAS:
            - cloud_firestore: ^5.6.12
PASO 8;
    - HACER EL ENTITIES.
        -Document snapshot y mapa de datos.
PASO 9;
    - HACER EL EDIT_PAGE.

        ----------------------- MULTIMEDIA IMÁGENES -----------------------

    DEPENDENCIAS;
        -  image_picker: ^1.2.1 -> Para seleccionar imágenes de galreia o camara
        -  cached_network_image: ^3.4.1 # Para cached network
        -  flutter_svg: ^2.2.3 # Para los SVG
        -  vector_graphics: ^1.1.19  # SVG A VECTOR.
        -  flutter_exif_rotation: ^0.5.2 # Para tener info extra.
        -  native_exif : ^0.6.2 # Para tener info extra.

        -   Añadir los assets al .yaml , ejemplo ;
                -  assets:
                     - assets/imagenes/
                     - assets/imagenes/svg

        - Añadir al Manifest ;
                <uses-permission android:name="android.permission.CAMERA"/>
       
        --------------------- MULTIMEDIA VIDEOS ---------------------------
       DEPENDENCIAS:  
        -   video_player: ^2.10.1 # Reproducir video assets
        -   youtube_explode_dart: ^3.0.5 # Reproducir video de youtube
        - Añadirlos al .yaml , ejemplo;
            -assets:
                assets/video/
        - Añadirlo al Manifest; 
            - <uses-permission android:name="android.permission.INTERNET"/>
        

        --------------------- PERMISOS -------------------------------
        
        COPIAR utils/permissions.dart

        ---------------------- MAPAS ---------------------------
        DEPENDENCIAS;  
            -  map_launcher: ^4.4.2 # Para localización(mapas).
        - Ir al proyecto de antonio en multimedia los dos 
        ultimos commits.
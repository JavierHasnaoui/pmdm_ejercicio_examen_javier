import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pmdm_ejercicio_examen/utils/permissions.dart';

import '../multimedia_videos/video_url/video_url_page.dart';
import '../multimedia_videos/video_youtube/video_youtube_page.dart';
import '../utils/snackbars.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // Funcion para comprobar los permisos necesarios
    Future<void> _revisarPermisos() async{
      // comprobar un permiso determinado
      final granted = await permissionHandle(
          context,
          Permission.locationWhenInUse,
          'Ubicacion mientras la app se usa',
          'La app necesita acceso a tu ubicacion. Por favor dale permiso para usar esta función.'
      );
      if(!mounted) return;

      if(!granted) return;

      // si se ha concedido permiso entonces continuamos
      snackBarShow(context, 'Permiso concedido, puedes continuar');

    }
    // Funcion para navegar a la página de video URL
    void _videoUrl() {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => const VideoUrlPage(),
        ),
      );
    }

    // Función para navegar a la página del video de Youtube
    void _videoYoutube() {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => const VideoYoutubePage(),
        ),
      );
    }
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user?.displayName ?? 'Usuario'),
            accountEmail: Text(user?.email ?? ''),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              context.go('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              // Redirigir a configuración (puedes añadir ruta)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Página de configuración')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar sesión'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              context.go('/login');
            },
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Imágenes'),
            onTap: () {
              Navigator.pop(context); // cerrar drawer
              context.go('/imagenes'); // navegación con go_router
            },
          ),
          ListTile(
            leading: const Icon(Icons.video_library),
            title: const Text('Video Assets'),
            onTap: () {
              Navigator.pop(context); // cerrar drawer
              context.go('/video_assets'); // navegación con go_router
            },
          ),
          ListTile(
            leading: const Icon(Icons.video_collection_outlined),
            title: const Text('Video URL'),
            onTap: _videoUrl,
          ),
          ListTile(
            leading: const Icon(Icons.play_circle),
            title: const Text('Video YouTube'),
            onTap: _videoYoutube,
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Comprobar Permisos'),
            onTap: _revisarPermisos,
          ),
        ],
      ),
    );
  }
}

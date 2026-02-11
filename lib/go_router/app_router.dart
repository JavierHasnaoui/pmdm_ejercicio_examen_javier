import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:pmdm_ejercicio_examen/multimedia_imagenes/CargarImagenes/TiposImagenes.dart';
import 'package:pmdm_ejercicio_examen/multimedia_imagenes/ImagenCachedNetwork/images_cached_network_image.dart';
import 'package:pmdm_ejercicio_examen/multimedia_imagenes/imagen_con_galeria/imagen_gallery.dart';
import 'package:pmdm_ejercicio_examen/multimedia_imagenes/imagenes_svg/imagenes_svg.dart';
import 'package:pmdm_ejercicio_examen/pages/register_page.dart';
import '../home_page/home_page.dart';
import '../multimedia_videos/video_assets/video_assets_page.dart';
import '../multimedia_videos/video_url/video_url_page.dart';
import '../multimedia_videos/video_youtube/video_youtube_page.dart';
import '../pages/login_page.dart';
import '../multimedia_imagenes/imagen_con_camara/imagen_camara.dart';

final GoRouter appRouter = GoRouter(
  // Si es necesario poner login pues se pone /login.
  initialLocation: '/',
  redirect: (context, state) {
    final user = FirebaseAuth.instance.currentUser;
    final loggingIn = state.matchedLocation == '/login';
    final registering = state.matchedLocation == '/register';

    // Y se quita esto.
    // Si no esta registrado o logueado o es nulo entonces va al login.
    if (user == null && !loggingIn && !registering) {
      return '/login';
    }
    // Si lo esta entonces va al home.
    if (user != null && (loggingIn || registering)) {
      return '/';
    }
    return null;
  },
  // Y aqui añado las rutas con su Page.
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(title: 'HOME PAGE',),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(path: '/register',
    builder: (context , state) => const RegisterPage()
    ),
    GoRoute(
      path: '/imagenes',
      builder: (context, state) => ImageCameraPage(),
    ),
    GoRoute(
      path: '/cargarimagenes',
      builder: (context, state) => ImagesImagePage(),
    ),
    GoRoute(
      path: '/imagenescongaleria',
      builder: (context, state) => ImageGalleryPage(),
    ),
    GoRoute(
      path: '/imagenescached',
      builder: (context, state) => ImagesCachedNetworkImagePage(),
    ),
    GoRoute(
      path: '/imagenessvg',
      builder: (context, state) => ImagesSvgPage(),
    ),

    GoRoute(
      path : '/video_assets',
      builder: (context, state) => const VideoAssetsPage(),
    ),
    GoRoute(
      path: '/video_url',
      builder: (context, state) => const VideoUrlPage(),
    ),
    GoRoute(
      path: '/video_youtube',
      builder: (context, state) => const VideoYoutubePage(),
    ),
  ],
);

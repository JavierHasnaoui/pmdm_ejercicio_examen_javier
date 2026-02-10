import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:pmdm_ejercicio_examen/pages/register_page.dart';
import '../home_page/home_page.dart';
import '../multimedia_videos/video_assets/video_assets_page.dart';
import '../multimedia_videos/video_url/video_url_page.dart';
import '../multimedia_videos/video_youtube/video_youtube_page.dart';
import '../pages/login_page.dart';
import '../multimedia_imagenes/imagen_con_camara/imagen_camara.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final user = FirebaseAuth.instance.currentUser;
    final loggingIn = state.matchedLocation == '/login';
    final registering = state.matchedLocation == '/register';

    if (user == null && !loggingIn && !registering) {
      return '/login';
    }
    if (user != null && (loggingIn || registering)) {
      return '/';
    }
    return null;
  },

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

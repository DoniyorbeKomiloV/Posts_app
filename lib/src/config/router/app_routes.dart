import 'package:chuck_interceptor/chuck.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posts_app/src/data/models/home/posts_response.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';
import '../../presentation/bloc/main/home/home_bloc.dart';
import '../../presentation/bloc/main/main_bloc.dart';
import '../../presentation/pages/auth/auth_page.dart';
import '../../presentation/pages/auth/register/register_page.dart';
import '../../presentation/pages/main/main_page.dart';
import '../../presentation/pages/main/profile/post_detail/post_detail_page.dart';
import '../../presentation/pages/others/error/error_page.dart';
import '../../presentation/pages/others/splash/splash_page.dart';

part 'name_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

final Chuck chuck = Chuck(navigatorKey: rootNavigatorKey);

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.initial,
  errorBuilder: (_, state) => ErrorPage(state: state),
  routes: <RouteBase>[
    /// splash
    GoRoute(
      path: Routes.initial,
      name: Routes.initial,
      builder: (_, __) => const SplashPage(),
    ),

    /// main
    GoRoute(
      name: Routes.main,
      path: Routes.main,
      builder: (_, state) => MultiBlocProvider(
        providers: [
          BlocProvider<MainBloc>(create: (_) => MainBloc()),
          BlocProvider<HomeBloc>(create: (_) => HomeBloc()),
        ],
        child: const MainPage(),
      ),
    ),

    /// profile
    GoRoute(
      path: Routes.postDetail,
      name: Routes.postDetail,
      builder: (_, state) => PostDetailPage(
        postsResponse: state.extra as PostsResponse,
      ),
    ),

    /// auth
    GoRoute(
      path: Routes.auth,
      name: Routes.auth,
      builder: (_, __) => BlocProvider(
        create: (_) => AuthBloc(),
        child: const AuthPage(),
      ),
    ),

    GoRoute(
      path: Routes.register,
      name: Routes.register,
      builder: (_, __) => BlocProvider(
        create: (_) => AuthBloc(),
        child: const RegisterPage(),
      ),
    ),
  ],
);

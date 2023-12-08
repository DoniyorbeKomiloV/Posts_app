import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:posts_app/src/config/themes/themes.dart';
import 'package:posts_app/src/data/source/local_source.dart';
import '../../../../config/router/app_routes.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/extension/extension.dart';
import 'package:posts_app/src/core/utils/app_utils.dart';
import '../../../components/loading_widgets/staggered_dots_wave.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  final LocalSource localSource = LocalSource();
  @override
  void initState() {
    super.initState();
    Future.delayed(
      splashPageAnimationDuration,
      () {
        localSource.userId.isEmpty
            ? context.goNamed(Routes.auth)
            : context.goNamed(Routes.main);
      },
    );
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: context.theme.primaryColor,
          body: const Stack(
            children: [
              Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      AppIcons.main,
                      color: Colors.white,
                      size: 48,
                    ),
                    AppUtils.kGap8,
                    Text(
                      'POSTS',
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: Center(
                  child: StaggeredDotsWave(
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

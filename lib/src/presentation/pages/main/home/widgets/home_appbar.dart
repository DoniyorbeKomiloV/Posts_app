import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posts_app/src/config/themes/themes.dart';
import '../../../../../core/extension/extension.dart';
import 'package:posts_app/src/core/utils/app_utils.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.innerBoxIsScrolled,
  });

  final bool innerBoxIsScrolled;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      forceElevated: true,
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w900,
      ),
      systemOverlayStyle: innerBoxIsScrolled
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      backgroundColor: innerBoxIsScrolled
          ? context.theme.appBarTheme.backgroundColor
          : context.colorScheme.primary,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(AppIcons.main),
          AppUtils.kGap6,
          Text('POSTS'),
        ],
      ),
    );
  }
}

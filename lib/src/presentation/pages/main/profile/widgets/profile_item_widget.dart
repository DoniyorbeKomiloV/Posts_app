import 'package:flutter/material.dart';
import '../../../../../core/extension/extension.dart';
import 'package:posts_app/src/core/utils/app_utils.dart';

class ProfileItemWidget extends StatelessWidget {
  const ProfileItemWidget({
    super.key,
    required this.icon,
    required this.iconBackgroundColor,
    required this.title,
    this.trailingText,
    this.onTap,
  });

  final Widget icon;
  final Color iconBackgroundColor;
  final String title;
  final String? trailingText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onTap,
        horizontalTitleGap: 10,
        leading: Ink(
          padding: AppUtils.kPaddingAll4,
          decoration: BoxDecoration(
            borderRadius: AppUtils.kBorderRadius6,
            color: iconBackgroundColor,
          ),
          child: icon,
        ),
        title: Text(title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (trailingText != null)
              Text(
                trailingText ?? '',
                style: context.theme.listTileTheme.leadingAndTrailingTextStyle,
              ),
            AppUtils.kGap4,
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
            ),
          ],
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:posts_app/src/core/utils/app_utils.dart';
import '../../../core/extension/extension.dart';

void show(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: AppUtils.kPaddingAll16,
      behavior: SnackBarBehavior.fixed,
      backgroundColor: context.theme.colorScheme.primary,
      clipBehavior: Clip.antiAlias,
      dismissDirection: DismissDirection.none,
      content: Text(message),
    ),
  );
}

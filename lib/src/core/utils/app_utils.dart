
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

sealed class AppUtils {
  AppUtils._();
  static const kSpacer = Spacer();
  static const kGap4 = Gap(4);
  static const kGap6 = Gap(6);
  static const kGap8 = Gap(8);
  static const kGap12 = Gap(12);
  static const kGap16 = Gap(16);
  static const kGap20 = Gap(20);
  static const kPaddingAll4 = EdgeInsets.all(4);
  static const kPaddingAll16 = EdgeInsets.all(16);
  static const kPaddingAll24 = EdgeInsets.all(24);
  static const kPaddingHorizontal16 = EdgeInsets.symmetric(horizontal: 16);
  static const kPaddingHor14Ver16 =
      EdgeInsets.symmetric(horizontal: 14, vertical: 16);
  static const kPaddingHor16Ver12 =
      EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  static const kBorderRadius6 = BorderRadius.all(Radius.circular(6));
}

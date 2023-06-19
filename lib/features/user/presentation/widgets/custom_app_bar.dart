import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/theme/app_styles.dart';
import 'package:flutter_chat_app/config/theme/app_themes.dart';

AppBar customAppBar({title}) {
  return AppBar(
    backgroundColor: AppColors.backGroundColorBottomNav,
    title: Text(
      title,
      style: fEncodeSansBold.copyWith(
        color: AppColors.primaryColor,
      ),
    ),
  );
}

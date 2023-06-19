import 'package:flutter/widgets.dart';
import 'package:flutter_chat_app/config/theme/app_themes.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast({required String message, Color? backGroundColor}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: backGroundColor ?? AppColors.backGroundColorBottomNav,
    textColor: AppColors.primaryColor,
    fontSize: 16.0,
  );
}

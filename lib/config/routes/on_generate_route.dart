import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/theme/app_styles.dart';
import 'package:flutter_chat_app/config/theme/app_themes.dart';
import 'package:flutter_chat_app/core/constants/constants.dart';
import 'package:flutter_chat_app/features/app/home/home_page.dart';
import 'package:flutter_chat_app/features/user/presentation/pages/sign_in_page.dart';
import 'package:flutter_chat_app/features/user/presentation/pages/sign_up_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.signIn:
        return routeBuilder(const SignInPage());

      case PageConst.signUp:
        return routeBuilder(const SignUpPage());

      case PageConst.home:
        return routeBuilder(const HomePage());

      default:
        const NoScreenFound();
    }
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class NoScreenFound extends StatelessWidget {
  const NoScreenFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        title: Text(
          "Screen not found!",
          style: fEncodeSansBold.copyWith(color: AppColors.primaryColor),
        ),
      ),
      body: Center(
        child: Text(
          "Screen not found!",
          style: fEncodeSansMedium.copyWith(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}

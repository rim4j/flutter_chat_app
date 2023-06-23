import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/theme/app_styles.dart';
import 'package:flutter_chat_app/config/theme/app_themes.dart';
import 'package:flutter_chat_app/core/constants/constants.dart';
import 'package:flutter_chat_app/features/group/domain/entities/single_chat_entity.dart';
import 'package:flutter_chat_app/features/group/presentation/pages/create_group_page.dart';
import 'package:flutter_chat_app/features/group/presentation/pages/single_chat_page.dart';
import 'package:flutter_chat_app/features/user/presentation/pages/forget_password_page.dart';
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

      case PageConst.forgetPassword:
        return routeBuilder(const ForgetPasswordPage());

      case PageConst.createGroup:
        if (args is String) {
          return routeBuilder(CreateGroupPage(
            uid: args,
          ));
        } else {
          return routeBuilder(const NoScreenFound());
        }

      case PageConst.singleChat:
        if (args is SingleChatEntity) {
          return routeBuilder(SingleChatPage(singleChatEntity: args));
        } else {
          return routeBuilder(const NoScreenFound());
        }

      default:
        return routeBuilder(const NoScreenFound());
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
        backgroundColor: AppColors.backGroundColorBottomNav,
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

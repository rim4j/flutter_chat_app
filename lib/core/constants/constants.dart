import 'package:flutter/material.dart';

class IMAGES {
  static const backgroundWallpaper1 = "assets/images/background_wallpaper.png";
  static const backgroundWallpaper2 = "assets/images/background.jpg";
  // static const profileDefault = "assets/images/profile_default.png";

  static const profileDefault =
      "https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg";

  static const googleNetworkIcon =
      "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/crypto%2Fsearch%20(2).png?alt=media&token=24a918f7-3564-4290-b7e4-08ff54b3c94c";
}

//firebase constants
class FirebaseCollectionsName {
  static const users = "users";
  static const profile = "profile";
  static const group = "group";
}

//route names
class PageConst {
  static const String signUp = "signUp";
  static const String signIn = "signIn";
  static const String home = "home";
  static const String forgetPassword = "forgetPassword";
}

Widget sizeVer(double height) {
  return SizedBox(height: height);
}

Widget sizeHor(double width) {
  return SizedBox(width: width);
}

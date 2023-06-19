import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/theme/app_styles.dart';
import 'package:flutter_chat_app/config/theme/app_themes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool? loading;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading == true ? () {} : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blueColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: loading == true
          ? const SizedBox(
              height: 50,
              child: SpinKitThreeBounce(
                color: AppColors.primaryColor,
                size: 20,
              ),
            )
          : Text(
              title,
              style: fEncodeSansBold.copyWith(color: AppColors.primaryColor),
            ),
    );
  }
}

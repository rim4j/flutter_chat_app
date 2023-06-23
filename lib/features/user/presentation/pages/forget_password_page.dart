import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/config/theme/app_themes.dart';
import 'package:flutter_chat_app/core/constants/constants.dart';
import 'package:flutter_chat_app/core/utils/custom_toast.dart';
import 'package:flutter_chat_app/core/widgets/custom_button.dart';
import 'package:flutter_chat_app/features/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:flutter_chat_app/features/user/presentation/widgets/custom_app_bar.dart';
import 'package:flutter_chat_app/features/user/presentation/widgets/form_container_widget.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: customAppBar(title: "Forget password"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              sizeVer(20),
              FormContainerWidget(
                hintText: "Email",
                controller: _emailController,
                prefixIcon: const Icon(Icons.email),
              ),
              sizeVer(30),
              CustomButton(
                title: "Recovery",
                onTap: _submitRecovery,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitRecovery() {
    if (_emailController.text.isEmpty) {
      toast(
        message: "Enter your email",
        backGroundColor: Colors.red,
      );

      return;
    }

    if (!_emailController.text.endsWith("@gmail.com")) {
      toast(
        message: "Please enter a valid email",
        backGroundColor: Colors.red,
      );

      return;
    }

    BlocProvider.of<CredentialCubit>(context)
        .forgetPassword(email: _emailController.text)
        .then((value) {
      toast(
          message: "Please check your email for reset password",
          backGroundColor: Colors.green);
      Navigator.pushNamedAndRemoveUntil(
        context,
        PageConst.signIn,
        (route) => false,
      );
    });
  }
}

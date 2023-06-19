import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/config/theme/app_styles.dart';
import 'package:flutter_chat_app/config/theme/app_themes.dart';
import 'package:flutter_chat_app/core/constants/constants.dart';
import 'package:flutter_chat_app/core/utils/custom_toast.dart';
import 'package:flutter_chat_app/core/widgets/custom_button.dart';
import 'package:flutter_chat_app/features/app/home/home_page.dart';
import 'package:flutter_chat_app/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_chat_app/features/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:flutter_chat_app/features/user/presentation/widgets/custom_app_bar.dart';
import 'package:flutter_chat_app/features/user/presentation/widgets/form_container_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CredentialCubit, CredentialState>(
      listener: (context, credentialState) {
        if (credentialState is CredentialSuccess) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }

        if (credentialState is CredentialFailed) {
          toast(
            message: 'wrong email or password please check',
            backGroundColor: Colors.red,
          );
        }
      },
      builder: (context, credentialState) {
        if (credentialState is CredentialSuccess) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is Authenticated) {
                return HomePage(uid: authState.uid);
              } else {
                return Scaffold(
                  backgroundColor: AppColors.backGroundColor,
                  appBar: customAppBar(title: "sign In"),
                  body: BlocConsumer<CredentialCubit, CredentialState>(
                    listener: (context, credentialState) {},
                    builder: (context, credentialState) {
                      return _bodyWidget();
                    },
                  ),
                );
              }
            },
          );
        }

        return Scaffold(
          backgroundColor: AppColors.backGroundColor,
          appBar: customAppBar(title: "sign In"),
          body: BlocConsumer<CredentialCubit, CredentialState>(
            listener: (context, credentialState) {},
            builder: (context, credentialState) {
              return _bodyWidget();
            },
          ),
        );
      },
    );
  }

  Widget _bodyWidget() {
    return SingleChildScrollView(
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
            sizeVer(15),
            FormContainerWidget(
              hintText: "Password",
              isPasswordField: true,
              controller: _passwordController,
              prefixIcon: const Icon(Icons.lock),
            ),
            sizeVer(10),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PageConst.forgetPassword);
              },
              child: Text(
                "Forget password ?",
                style: fEncodeSansMedium.copyWith(
                  color: AppColors.blueColor,
                ),
              ),
            ),
            sizeVer(30),
            BlocBuilder<CredentialCubit, CredentialState>(
              builder: (context, credentialState) {
                if (credentialState is CredentialLoading) {
                  return CustomButton(
                    title: "Sign In",
                    onTap: () {},
                    loading: true,
                  );
                }
                return CustomButton(
                  title: "Sign In",
                  onTap: _submitLogin,
                );
              },
            ),
            sizeVer(15),
            Row(
              children: [
                Text(
                  "Don't have an account?",
                  style:
                      fEncodeSansMedium.copyWith(color: AppColors.primaryColor),
                ),
                sizeHor(5),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, PageConst.signUp, (route) => false);
                  },
                  child: Text(
                    "Sign Up",
                    style: fEncodeSansBold.copyWith(
                      color: AppColors.blueColor,
                    ),
                  ),
                )
              ],
            ),
            sizeVer(20),
            _signInWithGoogleBtn(),
          ],
        ),
      ),
    );
  }

  Widget _signInWithGoogleBtn() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
      ),
      child: TextButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              IMAGES.googleNetworkIcon,
              width: 20,
            ),
            sizeHor(15),
            Text(
              "Sign in with Google",
              style: fEncodeSansBold.copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  void _submitLogin() {
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

    if (_passwordController.text.isEmpty) {
      toast(
        message: "Enter your password",
        backGroundColor: Colors.red,
      );
      return;
    }

    if (_passwordController.text.length < 6) {
      toast(
        message: "at least enter 6 characters",
        backGroundColor: Colors.red,
      );
      return;
    }
    if (_passwordController.text.length > 13) {
      toast(
        message: "maximum characters is 13",
        backGroundColor: Colors.red,
      );
      return;
    }

    BlocProvider.of<CredentialCubit>(context).signIn(
        email: _emailController.text, password: _passwordController.text);
  }
}

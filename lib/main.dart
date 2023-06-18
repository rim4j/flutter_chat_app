import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/config/routes/on_generate_route.dart';
import 'package:flutter_chat_app/features/app/home/home_page.dart';
import 'package:flutter_chat_app/features/injection_container.dart' as di;
import 'package:flutter_chat_app/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_chat_app/features/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:flutter_chat_app/features/user/presentation/pages/sign_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => di.locator<AuthCubit>()..appStarted(),
        ),
        BlocProvider<CredentialCubit>(
          create: (context) => di.locator<CredentialCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'chat app',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: OnGenerateRoute.route,
        initialRoute: "/",
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  //home page
                  return HomePage();
                } else {
                  //login page
                  return SignInPage();
                }
              },
            );
          }
        },
      ),
    );
  }
}

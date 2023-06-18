import 'package:flutter_chat_app/features/injection_container.dart';
import 'package:flutter_chat_app/features/user/data/data_sources/remote_data/user_remote_data_source.dart';
import 'package:flutter_chat_app/features/user/data/data_sources/remote_data/user_remote_data_source_impl.dart';
import 'package:flutter_chat_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:flutter_chat_app/features/user/domain/repositories/user_repository.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/forget_password_usecase.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/get_all_users.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/get_create_current_user_usecase.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/get_current_uid.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/get_single_user.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/get_update_user.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/google_auth_usecase.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/is_sign_in_usecase.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/sign_in_usecase.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/sign_out_usecase.dart';
import 'package:flutter_chat_app/features/user/domain/use_cases/sign_up_usecase.dart';
import 'package:flutter_chat_app/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_chat_app/features/user/presentation/cubit/credential/credential_cubit.dart';

Future<void> userInjectionContainer() async {
  //cubit

  locator.registerFactory<AuthCubit>(
    () => AuthCubit(
      isSignInUseCase: locator(),
      signOutUseCase: locator(),
      getCurrentUidUseCase: locator(),
    ),
  );

  locator.registerFactory<CredentialCubit>(
    () => CredentialCubit(
      signUpUseCase: locator(),
      signInUseCase: locator(),
      forgetPasswordUseCase: locator(),
      googleAuthUseCase: locator(),
    ),
  );

  //use cases
  locator.registerLazySingleton<ForgetPasswordUseCase>(
      () => ForgetPasswordUseCase(repository: locator()));

  locator.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(repository: locator()));

  locator.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: locator()));

  locator.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: locator()));

  locator.registerLazySingleton<GetSingleUserUseCase>(
      () => GetSingleUserUseCase(repository: locator()));

  locator.registerLazySingleton<GetUpdateUserUseCase>(
      () => GetUpdateUserUseCase(repository: locator()));

  locator.registerLazySingleton<GoogleAuthUseCase>(
      () => GoogleAuthUseCase(repository: locator()));

  locator.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: locator()));

  locator.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: locator()));

  locator.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: locator()));

  locator.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: locator()));

  //repositories
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  //remoteDataSource
  locator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      auth: locator(),
      fireStore: locator(),
      googleSignIn: locator(),
    ),
  );
}

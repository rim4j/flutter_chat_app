import 'package:flutter_chat_app/features/group/data/data_sources/remote/group_remote_data_source.dart';
import 'package:flutter_chat_app/features/group/data/data_sources/remote/group_remote_data_source_impl.dart';
import 'package:flutter_chat_app/features/group/data/repositories/group_repository_impl.dart';
import 'package:flutter_chat_app/features/group/domain/repositories/group_repsitory.dart';
import 'package:flutter_chat_app/features/group/domain/use_cases/get_create_group_usecase.dart';
import 'package:flutter_chat_app/features/group/domain/use_cases/get_groups_usecase.dart';
import 'package:flutter_chat_app/features/group/domain/use_cases/get_messages_usecase.dart';
import 'package:flutter_chat_app/features/group/domain/use_cases/sent_text_message_usecase.dart';
import 'package:flutter_chat_app/features/group/domain/use_cases/update_group_usecase.dart';
import 'package:flutter_chat_app/features/group/presentation/cubit/chat/chat_cubit.dart';
import 'package:flutter_chat_app/features/group/presentation/cubit/group/group_cubit.dart';
import 'package:flutter_chat_app/features/injection_container.dart';

Future<void> groupInjectionContainer() async {
  //state management
  locator.registerFactory<GroupCubit>(
    () => GroupCubit(
      getCreateGroupUseCase: locator(),
      getGroupsUseCase: locator(),
      updateGroupUseCase: locator(),
    ),
  );

  locator.registerFactory<ChatCubit>(
    () => ChatCubit(
      getMessagesUseCase: locator(),
      sendTextMessageUseCase: locator(),
    ),
  );

  //useCases
  locator.registerLazySingleton<GetCreateGroupUseCase>(
      () => GetCreateGroupUseCase(groupRepository: locator()));

  locator.registerLazySingleton<GetGroupsUseCase>(
      () => GetGroupsUseCase(groupRepository: locator()));

  locator.registerLazySingleton<GetMessagesUseCase>(
      () => GetMessagesUseCase(groupRepository: locator()));

  locator.registerLazySingleton<SendTextMessageUseCase>(
      () => SendTextMessageUseCase(groupRepository: locator()));

  locator.registerLazySingleton<UpdateGroupUseCase>(
      () => UpdateGroupUseCase(groupRepository: locator()));

  //repositories
  locator.registerLazySingleton<GroupRepository>(
      () => GroupRepositoryImpl(groupRemoteDataSource: locator()));

  //data source
  locator.registerLazySingleton<GroupRemoteDataSource>(
      () => GroupRemoteDataSourceImpl(firestore: locator()));
}

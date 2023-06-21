import 'package:flutter_chat_app/features/injection_container.dart';
import 'package:flutter_chat_app/features/storage/data/data_sources/remote/cloud_storage_remote_data_source.dart';
import 'package:flutter_chat_app/features/storage/data/data_sources/remote/cloud_storage_remote_data_source_impl.dart';
import 'package:flutter_chat_app/features/storage/data/repositories/cloud_storage_repository_impl.dart';
import 'package:flutter_chat_app/features/storage/domain/repositories/cloud_storage_repository.dart';
import 'package:flutter_chat_app/features/storage/domain/use_cases/upload_group_image_usecase.dart';
import 'package:flutter_chat_app/features/storage/domain/use_cases/upload_profile_image_usecase.dart';

Future<void> storageInjectionContainer() async {
//useCase
  locator.registerLazySingleton<UploadGroupImageUseCase>(
      () => UploadGroupImageUseCase(repository: locator()));
  locator.registerLazySingleton<UploadImageProfileUseCase>(
      () => UploadImageProfileUseCase(repository: locator()));

//repositories

  locator.registerLazySingleton<CloudStorageRepository>(
    () => CloudStorageRepositoryImpl(remoteData: locator()),
  );

//remote data

  locator.registerLazySingleton<CloudStorageRemoteDataSource>(
      () => CloudStorageRemoteDataSourceImpl(storage: locator()));
}

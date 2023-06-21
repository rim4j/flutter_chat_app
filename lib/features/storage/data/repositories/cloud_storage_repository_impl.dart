import 'dart:io';

import 'package:flutter_chat_app/features/storage/data/data_sources/remote/cloud_storage_remote_data_source.dart';
import 'package:flutter_chat_app/features/storage/domain/repositories/cloud_storage_repository.dart';

class CloudStorageRepositoryImpl implements CloudStorageRepository {
  final CloudStorageRemoteDataSource remoteData;

  CloudStorageRepositoryImpl({
    required this.remoteData,
  });
  @override
  Future<String> uploadGroupImage({required File file}) async =>
      remoteData.uploadGroupImage(file: file);

  @override
  Future<String> uploadImageProfile({required File file}) async =>
      remoteData.uploadImageProfile(file: file);
}

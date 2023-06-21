import 'dart:io';

import 'package:flutter_chat_app/features/storage/data/data_sources/remote/cloud_storage_remote_data_source.dart';

class UploadGroupImageUseCase {
  final CloudStorageRemoteDataSource repository;

  UploadGroupImageUseCase({
    required this.repository,
  });

  Future<String> call({required File file}) async {
    return repository.uploadGroupImage(file: file);
  }
}

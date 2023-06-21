import 'dart:io';

abstract class CloudStorageRemoteDataSource {
  Future<String> uploadImageProfile({required File file});
  Future<String> uploadGroupImage({required File file});
}

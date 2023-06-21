import 'dart:io';

abstract class CloudStorageRepository {
  Future<String> uploadImageProfile({required File file});
  Future<String> uploadGroupImage({required File file});
}

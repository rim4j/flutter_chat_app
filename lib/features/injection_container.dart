import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/features/group/group_injection_container.dart';
import 'package:flutter_chat_app/features/storage/storage_injection_container.dart';
import 'package:flutter_chat_app/features/user/user_injection_container.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //external
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseStorage storage = FirebaseStorage.instance;

  locator.registerLazySingleton(() => auth);
  locator.registerLazySingleton(() => fireStore);
  locator.registerLazySingleton(() => googleSignIn);
  locator.registerLazySingleton(() => storage);

  await userInjectionContainer();
  await storageInjectionContainer();
  await groupInjectionContainer();
}

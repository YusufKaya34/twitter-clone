import 'package:get_it/get_it.dart';
import 'package:twitter/core/repository/user_repository.dart';
import 'package:twitter/core/services/fake_auth_services.dart';
import 'package:twitter/core/services/firebase_auth_service.dart';
import 'package:twitter/core/services/firebase_storage_service.dart';
import 'package:twitter/core/services/firestore_db_service.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FakeAuthenticationService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => FirestoreDBService());
  locator.registerLazySingleton(() => FirebaseStorageService());
}

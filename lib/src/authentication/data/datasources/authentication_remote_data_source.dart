import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/data/models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String name,
    required String createdAt,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

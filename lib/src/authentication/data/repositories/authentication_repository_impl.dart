import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/core/utils/typedef.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/domain/entities/user.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) {
    
  }

  @override
  ResultFuture<List<User>> getUsers() {

    throw UnimplementedError();
  }
}

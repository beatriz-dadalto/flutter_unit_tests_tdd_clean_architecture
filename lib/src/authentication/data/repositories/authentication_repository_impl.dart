import 'package:dartz/dartz.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/core/utils/typedef.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/domain/entities/user.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  const AuthenticationRepositoryImpl(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    /* Test-Driven Development
    call the remote data source.
    check if the method returns the proper data.
    make sure that it returns the proper data if there is no exception.
    check if when the remoteDataSource throws an exception, we return a failure.
    */
    //! implement createUser. after TDD
    await _remoteDataSource.createUser(
      name: name,
      createdAt: createdAt,
      avatar: avatar,
    );
    return const Right(null); // when is void fpdart return is null
  }

  @override
  ResultFuture<List<User>> getUsers() {
    throw UnimplementedError();
  }
}

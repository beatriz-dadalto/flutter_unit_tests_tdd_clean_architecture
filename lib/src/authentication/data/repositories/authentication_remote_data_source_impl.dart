import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final http.Client _client;

  const AuthenticationRemoteDataSourceImpl(this._client);

  @override
  Future<void> createUser({
    required String name,
    required String createdAt,
    required String avatar,
  }) async {
    /*
    1. check to make sure that it returns the right data when the response code
    is 200 or the proper response code
    2. check to make sure that it throws a custom exception with the right
    message when status code is the bad one
    */

    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getUsers() async {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}

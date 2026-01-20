import 'dart:convert';

import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/core/errors/exceptions.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/core/utils/constants.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

const kCreateUserEndpoint = '/users';
const kGetUsersEndpoint = '/users/:id';

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

    final response = await _client.post(
      Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
      body: jsonEncode({
        'createdAt': createdAt,
        'name': name,
        'avatar': avatar,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ApiException(
        message: response.body,
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/core/errors/exceptions.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/core/utils/constants.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/data/models/user_model.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/data/repositories/authentication_remote_data_source_impl.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../datasources/mock_client.dart';

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthenticationRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test(
      'should complete successfully when the status code is 200 or 201',
      () async {
        // Arrange
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('User created successfully', 201),
        );

        // Act
        final methodCall = remoteDataSource.createUser;

        // Assert
        expect(
          methodCall(name: 'name', createdAt: 'createdAt', avatar: 'avatar'),
          completes,
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'should throw [ApiException] when the status code is not 200 or 201',
      () async {
        // Arrange
        when(
          () => client.post(any(), body: any(named: 'body')),
        ).thenAnswer((_) async => http.Response('Invalid email address', 400));

        // Act
        final methodCall = remoteDataSource.createUser;

        // Assert
        expect(
          () async => methodCall(
            name: 'name',
            createdAt: 'createdAt',
            avatar: 'avatar',
          ),
          throwsA(
            const ApiException(
              message: 'Invalid email address',
              statusCode: 400,
            ),
          ),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  group('getUsers', () {
    const tUsers = [UserModel.empty()];

    test('should return [List<User>] when the status code is 200', () async {
      // Arrange
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200),
      );

      // Act
      final result = await remoteDataSource.getUsers();

      // Assert
      expect(result, equals(tUsers));

      verify(
        () => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint)),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [ApiException] when the status code is not 200', () {
      
    });
  });
}

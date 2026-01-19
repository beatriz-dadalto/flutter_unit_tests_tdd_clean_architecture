import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/data/repositories/authentication_remote_data_source_impl.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'mock_client.dart';

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthenticationRemoteDataSourceImpl(client);
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
          () => methodCall(
            name: 'name',
            createdAt: 'createdAt',
            avatar: 'avatar',
          ),
          completes,
        );

        verify(() => client.post(url));
      },
    );
  });

  group('getUsers', () {});
}

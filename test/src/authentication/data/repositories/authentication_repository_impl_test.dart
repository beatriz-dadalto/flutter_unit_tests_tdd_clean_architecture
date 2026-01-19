import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/core/errors/exceptions.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/core/errors/failure.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/domain/entities/user.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_auth_remote_data_source.dart';

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImpl repositoryImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repositoryImpl = AuthenticationRepositoryImpl(remoteDataSource);
  });

  const tException = ApiException(
    message: 'unknown error occured',
    statusCode: 500,
  );

  group('createUser', () {
    final createdAt = 'whatever.createdAt';
    final name = 'whatever.name';
    final avatar = 'whatever.avatar';

    test(
      'should call the [RemoteDataSource.createUser] and complete successfully when the call to the remote source is succcessful',
      () async {
        // Arrange
        when(
          () => remoteDataSource.createUser(
            name: any(named: 'name'),
            createdAt: any(named: 'createdAt'),
            avatar: any(named: 'avatar'),
          ),
        ).thenAnswer(
          (_) async => Future.value(),
        ); // when you expect null always return Future.value() instead

        // Act
        final result = await repositoryImpl.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        );

        // Assert
        expect(result, equals(const Right(null)));

        verify(
          () => remoteDataSource.createUser(
            name: name,
            createdAt: createdAt,
            avatar: avatar,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [ApiFailure] when the call to the remote source is unsuccessful',
      () async {
        // Arrange
        when(
          () => remoteDataSource.createUser(
            name: any(named: 'name'),
            createdAt: any(named: 'createdAt'),
            avatar: any(named: 'avatar'),
          ),
        ).thenThrow(tException);

        // Act
        final result = await repositoryImpl.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        );

        // Assert
        expect(
          result,
          equals(
            Left(
              ApiFailure(
                message: tException.message,
                statusCode: tException.statusCode,
              ),
            ),
          ),
        );

        verify(
          () => remoteDataSource.createUser(
            name: name,
            createdAt: createdAt,
            avatar: avatar,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getUsers', () {
    test(
      'should call the [RemoteDataSource.getUsers] and return [List<User>] when call to remote source is successful',
      () async {
        // Arrange
        when(() => remoteDataSource.getUsers()).thenAnswer((_) async => []);

        // Act
        final result = await repositoryImpl.getUsers();

        // Assert
        expect(result, isA<Right<dynamic, List<User>>>());

        verify(() => remoteDataSource.getUsers()).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [ApiFailure] when the call to the remote source is unsuccessful',
      () async {
        // Arrange
        when(() => remoteDataSource.getUsers()).thenThrow(tException);

        // Act
        final result = await repositoryImpl.getUsers();

        // Assert
        expect(result, equals(Left(ApiFailure.fromException(tException))));

        verify(() => remoteDataSource.getUsers()).called(1);
        
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/core/utils/typedef.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/data/models/user_model.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  // Arrange
  const tUserModel = UserModel.empty();

  test('should be a subclass of [User] entity', () {
    // Act

    // Assert
    expect(tUserModel, isA<User>());
  });

  // Arrange
  final testJson = fixture('user.json');
  final testMap = jsonDecode(testJson) as DataMap;

  group('fromMap', () {
    test('should return a [UserModel] with the right data', () {
      // Act
      final result = UserModel.fromMap(testMap);

      // Assert
      expect(result, equals(tUserModel));
    });
  });

  group('fromJson', () {
    test('should return a [UserModel] with the right data', () {
      // Act
      final result = UserModel.fromJson(testJson);

      // Assert
      expect(result, equals(tUserModel));
    });
  });

  group('toMap', () {
    test('should return a [Map] with the right data', () {
      // Act
      final result = tUserModel.toMap();

      // Assert
      expect(result, equals(testMap));
    });
  });

  group('toJson', () {
    test('should return a [Json] String with the right data', () {
      // Act
      final result = tUserModel.toJson();

      // Assert
      expect(jsonDecode(result), equals(jsonDecode(testJson)));
    });
  });
}

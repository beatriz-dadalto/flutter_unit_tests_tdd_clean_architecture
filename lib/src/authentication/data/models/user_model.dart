import 'dart:convert';

import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/core/utils/typedef.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.avatar,
  });

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json) as DataMap);

  UserModel.fromMap(DataMap map)
    : this(
        avatar: map['avatar'] as String,
        id: map['id'] as String,
        createdAt: map['createdAt'] as String,
        name: map['name'] as String,
      );

  DataMap toMap() => {
    'id': id,
    'avatar': avatar,
    'createdAt': createdAt,
    'name': name,
  };

  String toJson() => jsonEncode(toMap());
}

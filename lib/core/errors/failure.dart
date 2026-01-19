import 'package:equatable/equatable.dart';
import 'package:flutter_tests_bloc_firebase_tdd_clean_architecture/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});

  factory ApiFailure.fromException(ApiException exception) {
    return ApiFailure(
      message: exception.message,
      statusCode: exception.statusCode,
    );
  }
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.statusCode});
}

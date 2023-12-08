import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:posts_app/src/data/models/auth/login/login_response.dart';
import '../../../core/constants/constants.dart';
import '../../../core/either_dart/either.dart';
import '../../failure/failure.dart';
import '../../failure/server_error.dart';

part 'auth_repository_impl.dart';

abstract class AuthRepository {
  const AuthRepository();

  Future<Either<Failure, List<UserResponse>>> login();

  Future<Either<Failure, String>> registerUser({
    required Map<String, dynamic> request,
  });
}

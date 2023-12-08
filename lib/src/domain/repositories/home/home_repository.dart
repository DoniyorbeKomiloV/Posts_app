import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:posts_app/src/core/constants/constants.dart';
import 'package:posts_app/src/core/either_dart/either.dart';
import 'package:posts_app/src/data/models/auth/login/login_response.dart';
import 'package:posts_app/src/data/models/home/posts_response.dart';
import 'package:posts_app/src/domain/failure/failure.dart';
import 'package:posts_app/src/domain/failure/server_error.dart';

part 'home_repository_impl.dart';

abstract class HomeRepository {
  const HomeRepository();

  Future<Either<Failure, List<PostsResponse>>> getPosts();

  Future<Either<Failure, dynamic>> post(
      {required Map<String, dynamic> request});

  Future<Either<Failure, dynamic>> deletePost({required String id});
  
  Future<Either<Failure, UserResponse>> saveUserInfo(
      {required Map<String, dynamic> request, required String id});
}

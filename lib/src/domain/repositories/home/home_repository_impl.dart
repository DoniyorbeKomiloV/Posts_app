part of 'home_repository.dart';

final class HomeRepositoryImpl extends HomeRepository {
  const HomeRepositoryImpl({
    required this.dio,
  }) : super();

  final Dio dio;

  @override
  Future<Either<Failure, List<PostsResponse>>> getPosts() async {
    try {
      final Response response = await dio.get(Constants.baseUrl + Urls.posts);
      return Right((response.data as List)
          .map((e) => PostsResponse.fromJson(e))
          .toList());
    } on DioException catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, dynamic>> post(
      {required Map<String, dynamic> request}) async {
    try {
      final Response response = await dio.post(
        Constants.baseUrl + Urls.posts,
        data: request,
      );
      return Right(response.data['id']);
    } on DioException catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, dynamic>> deletePost({required String id}) async {
    try {
      final Response response = await dio.delete(
        '${Constants.baseUrl}${Urls.posts}/$id',
      );
      return Right(response.data['id']);
    } on DioException catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, UserResponse>> saveUserInfo(
      {required Map<String, dynamic> request, required String id}) async {
    try {
      final Response response = await dio.patch(
        '${Constants.baseUrl}${Urls.login}/$id',
        data: request,
      );
      return Right(UserResponse.fromJson(response.data));
    } on DioException catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }
}

part of 'auth_repository.dart';

final class AuthRepositoryImpl extends AuthRepository {
  const AuthRepositoryImpl({
    required this.dio,
  }) : super();

  final Dio dio;

  @override
  Future<Either<Failure, List<UserResponse>>> login() async {
    try {
      final Response response = await dio.get(Constants.baseUrl + Urls.login);
      return Right((response.data as List)
          .map((e) => UserResponse.fromJson(e))
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
  Future<Either<Failure, String>> registerUser({
    required Map<String, dynamic> request,
  }) async {
    try {
      final Response response = await dio.post(
        Constants.baseUrl + Urls.login,
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
}

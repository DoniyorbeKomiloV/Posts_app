import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/src/data/models/home/posts_response.dart';
import 'package:posts_app/src/data/source/local_source.dart';
import 'package:posts_app/src/domain/repositories/home/home_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeScroll>(_onHomeScroll);
    on<GetPostsEvent>(_getPosts);
    on<PostEvent>(_post);
    on<DeletePostEvent>(_deletePost);
  }

  final HomeRepository homeRepository = HomeRepositoryImpl(dio: Dio());
  final LocalSource localSource = LocalSource();
  void _onHomeScroll(HomeScroll event, Emitter<HomeState> emit) {
    emit(state.copyWith(isScrollingTop: event.isScrollingTop));
  }

  void _getPosts(GetPostsEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(getPostsStatus: PostsStatus.loading));
    final result = await homeRepository.getPosts();
    result.fold(
      (l) {
        emit(state.copyWith(getPostsStatus: PostsStatus.error));
      },
      (r) {
        emit(state.copyWith(getPostsStatus: PostsStatus.succes, posts: r));
      },
    );
  }

  void _post(PostEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(postRequestStatus: PostsStatus.loading));
    final result = await homeRepository.post(request: {
      "title": event.title,
      "creatorId": localSource.userId,
      "name": localSource.fullName,
      "body": event.body,
    });
    result.fold(
      (l) {
        emit(state.copyWith(postRequestStatus: PostsStatus.error));
      },
      (r) {
        emit(state.copyWith(postRequestStatus: PostsStatus.succes));
      },
    );
  }

  void _deletePost(DeletePostEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(postDeleteStatus: PostsStatus.loading));
    final result = await homeRepository.deletePost(id: event.id);
    result.fold(
      (l) {
        emit(state.copyWith(postDeleteStatus: PostsStatus.error));
      },
      (r) {
        emit(state.copyWith(postDeleteStatus: PostsStatus.succes));
      },
    );
  }
}

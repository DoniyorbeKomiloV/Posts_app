part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.isScrollingTop = false,
    this.getPostsStatus = PostsStatus.initial,
    this.postDeleteStatus = PostsStatus.initial,
    this.postRequestStatus = PostsStatus.initial,
    this.posts = const [],
  });

  final bool isScrollingTop;
  final PostsStatus getPostsStatus;
  final PostsStatus postRequestStatus;
  final PostsStatus postDeleteStatus;
  final List<PostsResponse> posts;

  HomeState copyWith({
    bool? isScrollingTop,
    PostsStatus? getPostsStatus,
    PostsStatus? postRequestStatus,
    PostsStatus? postDeleteStatus,
    List<PostsResponse>? posts,
  }) =>
      HomeState(
        isScrollingTop: isScrollingTop ?? this.isScrollingTop,
        getPostsStatus: getPostsStatus ?? PostsStatus.initial,
        postDeleteStatus: postDeleteStatus ?? PostsStatus.initial,
        postRequestStatus: postRequestStatus ?? PostsStatus.initial,
        posts: posts ?? this.posts,
      );

  @override
  List<Object?> get props => [
        isScrollingTop,
        getPostsStatus,
        posts,
        postDeleteStatus,
        postRequestStatus,
      ];
}

enum PostsStatus { initial, loading, error, succes }

part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeScroll extends HomeEvent {
  const HomeScroll({
    required this.isScrollingTop,
  });

  final bool isScrollingTop;

  @override
  List<Object?> get props => [isScrollingTop];
}

class GetPostsEvent extends HomeEvent {
  const GetPostsEvent();

  @override
  List<Object?> get props => [];
}

class PostEvent extends HomeEvent {
  const PostEvent({
    required this.body,
    required this.title,
  });
  final String title;
  final String body;
  @override
  List<Object?> get props => [
        body,
        title,
      ];
}

class DeletePostEvent extends HomeEvent {
  const DeletePostEvent({
    required this.id,
  });
  final String id;
  @override
  List<Object?> get props => [
        id,
      ];
}

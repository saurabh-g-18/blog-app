part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class Blogfailure extends BlogState {
  final String error;

  Blogfailure(this.error);
}

final class BlogSuccess extends BlogState {}
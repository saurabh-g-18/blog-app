import 'dart:io';


import 'package:blog_app/features/auth/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'blog_event.dart';
part 'blog_state.dart';


class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;

  BlogBloc({required this.uploadBlog})
      : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });

    on<BlogUpload>(_onUploadBlogEvent);
  }

  Future<void> _onUploadBlogEvent(
    BlogUpload event,
    Emitter<BlogState> emit,
  ) async {
    final res = await uploadBlog(
      UploadBlogParams(
        image: event.image,
        title: event.title,
        content: event.content,
        posterId: event.posterId,
        topics: event.topics,
      ),
    );

    res.fold(
      (failure) => emit(BlogFailure(failure.toString())),
      (blog) => emit(BlogSuccess()),
    );
  }
}

import 'dart:io';

import 'package:articles_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  BlogBloc(this.uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(Blogloading());
    });
    on<BlogUpload>(_onBlogUpload);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await uploadBlog(UploadBlogParams(
        userid: event.userid,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics));
    res.fold(
        (l) => emit(BlogFailure(error: l.message)), (r) => emit(BlogSuccess()));
  }
}

import 'dart:io';

import 'package:articles_app/core/usecase/usecases.dart';
import 'package:articles_app/features/blog/domain/entities/blog.dart';
import 'package:articles_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:articles_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final getAllBlogs _get_all_blogs;
  BlogBloc({required UploadBlog uploadBlog, required getAllBlogs get_all_blogs})
      : _get_all_blogs = get_all_blogs,
        _uploadBlog = uploadBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(Blogloading());
    });
    on<BlogUpload>(_onBlogUpload);
    on<BlogGetAllBlogs>(_onBlogGetAllBlogs);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(UploadBlogParams(
        userid: event.userid,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics));
    res.fold(
        (l) => emit(BlogFailure(error: l.message)), (r) => emit(BlogSuccess()));
  }

  void _onBlogGetAllBlogs(
      BlogGetAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _get_all_blogs(NoParams());
    res.fold((l) => emit(BlogFailure(error: l.message)),
        (r) => emit(BlogDisplaySuccess(blogList: r)));
  }
}

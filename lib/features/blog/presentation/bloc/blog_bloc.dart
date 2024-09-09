import 'dart:io';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final GetAllBlogs _getAllBlogs;
  final UploadBlog _uploadBlog;
  BlogBloc({required GetAllBlogs getAllBlogs, required UploadBlog uploadBlog})
      : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((_, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlog>(_onGetAllBlogs);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(UploadBlogParams(
        image: event.image,
        title: event.title,
        content: event.content,
        posterId: event.posterId,
        topics: event.topics));

    res.fold((failure) => emit(BlogFailure(failure.message)),
        (success) => emit(BlogUploadSuccess()));
  }

  void _onGetAllBlogs(BlogFetchAllBlog event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs(NoParams());

    res.fold((failure) => emit(BlogFailure(failure.message)),
        (success) => emit(BlogsDisplaySuccess(success)));
  }
}

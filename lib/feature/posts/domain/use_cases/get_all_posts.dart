import 'package:dartz/dartz.dart';
import 'package:flutt_pro/core/errors/failure.dart';
import 'package:flutt_pro/feature/posts/domain/reprositories/posts_reprositorty.dart';

import '../entity/post_entity.dart';

class GetAllPostsUseCase{
  final PostsRepository repository;

  GetAllPostsUseCase({required this.repository});

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
  ///callable class GetAllPost() ,GetAllPost.call()

}
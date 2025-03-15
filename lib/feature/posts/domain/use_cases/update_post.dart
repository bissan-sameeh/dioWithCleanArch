import 'package:dartz/dartz.dart';
import 'package:flutt_pro/core/errors/failure.dart';
import 'package:flutt_pro/feature/posts/domain/entity/post_entity.dart';
import 'package:flutt_pro/feature/posts/domain/reprositories/posts_reprositorty.dart';

class UpdatePostUseCase{
  final PostsRepository repository;
  UpdatePostUseCase({required this.repository});
  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}
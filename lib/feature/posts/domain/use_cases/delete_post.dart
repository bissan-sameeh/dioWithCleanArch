import 'package:dartz/dartz.dart';
import 'package:flutt_pro/core/errors/failure.dart';
import 'package:flutt_pro/feature/posts/domain/reprositories/posts_reprositorty.dart';

class DeletePostUseCae{
  final PostsRepository repository;
  DeletePostUseCae({required this.repository});
  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deletePost(id);
  }
}
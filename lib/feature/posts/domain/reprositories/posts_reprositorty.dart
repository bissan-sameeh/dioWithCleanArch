import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entity/post_entity.dart';

abstract class PostsRepository{
  Future<Either<Failure,List<Post>>> getAllPosts();
  Future<Either<Failure,Unit>> deletePost(int id);
  Future<Either<Failure,Unit>> updatePost(Post post);
  Future<Either<Failure,Unit>> addPost(Post post);


}
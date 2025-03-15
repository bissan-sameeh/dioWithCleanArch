import 'package:dartz/dartz.dart';
import 'package:flutt_pro/core/errors/excpations.dart';
import 'package:flutt_pro/core/errors/failure.dart';
import 'package:flutt_pro/core/network/network_info.dart';
import 'package:flutt_pro/feature/posts/data/models/post_model.dart';
import 'package:flutt_pro/feature/posts/domain/entity/post_entity.dart';
import 'package:flutt_pro/feature/posts/domain/reprositories/posts_reprositorty.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_sources/post_local_data_source.dart';
import '../data_sources/post_remote_data_source.dart';

typedef Future<Unit> DeleteOrAddOrUpdate(params);

class PostRepositoryImp implements PostsRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDatSource localeDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImp(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localeDataSource});

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    // await remoteDataSource.deletePost(id);
    return await _getMessage(
      () {
        return remoteDataSource.addPost(postModel);
      },
    );
    // if(await networkInfo.isConnected){
    //   try{
    //     await remoteDataSource.addPost(postModel);
    //     return const Right(unit);
    //   }on ServerException{
    //     return Left(ServerFailure());
    //   }
    // }else{
    //  return Left(OfflineFailure());
    // }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _getMessage(
      () {
        return remoteDataSource.deletePost(id);
      },
    );
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getAllPosts();

        SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

        if(  sharedPreferences.getString('Cached_Posts')==null){
         await  localeDataSource.cachedPost(response);
        }

        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {


        final localVar = await localeDataSource.getCachedPosts();
        return Right(localVar);
      } on EmptyCacheException {
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(title: post.title, body: post.body);
    return await _getMessage(
      () {
        return remoteDataSource.updatePost(postModel);
      },
    );
  }

  Future<Either<Failure, Unit>> _getMessage(
      Future<Unit> Function() updateDeleteAddFunction) async {
    if (await networkInfo.isConnected) {
      try {
        await updateDeleteAddFunction();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}

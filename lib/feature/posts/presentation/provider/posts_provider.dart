import 'package:dartz/dartz.dart';
import 'package:flutt_pro/core/api_helper/api_response.dart';
import 'package:flutt_pro/core/errors/failure.dart';
import 'package:flutt_pro/feature/posts/domain/use_cases/add_post.dart';
import 'package:flutt_pro/feature/posts/domain/use_cases/get_all_posts.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/strings/failure.dart';
import '../../domain/entity/post_entity.dart';
import '../../domain/use_cases/delete_post.dart';
import '../../domain/use_cases/update_post.dart';

class PostsProvider extends ChangeNotifier{
 final GetAllPostsUseCase getAllPostsUseCase;

 final AddPostUseCase addPostUseCase;
 final UpdatePostUseCase updatePostUseCase;
 final DeletePostUseCae deletePostUseCae;
  ApiResponse<Unit> _postResponse=ApiResponse.loading('Loading !');
  // final ApiResponse<Unit> _deletePostStatus=ApiResponse.loading('Loading ');
 ApiResponse<Unit> get addPostResponse=>_postResponse;
 ApiResponse<Unit> get deletePostStatus=>_postResponse;
 ApiResponse<Unit> get updatePostStatus=>_postResponse;

 ApiResponse<List<Post>> _postsResponse=ApiResponse.loading('Loading posts ');
 ApiResponse<List<Post>> get postsList=>_postsResponse;

 PostsProvider({required this.addPostUseCase, required this.updatePostUseCase, required this.deletePostUseCae, required this.getAllPostsUseCase});

 getAllPosts() async {
 final failureOrPosts= await getAllPostsUseCase();
 _mapFailureOrPosts(failureOrPosts);
 }


 Future<void> addPost(Post post) async{
  _postResponse=ApiResponse.loading('Loading ');
  final failureOrSuccess=await addPostUseCase(post);

  _mapFailureOrSuccess(failureOrSuccess);
 }

 Future<void> deletePost(int postId) async{
  final failureOrSuccess=await deletePostUseCae(postId);

  _mapFailureOrSuccess(failureOrSuccess);

 }

 Future<void> updatePost(Post post) async{
  final failureOrSuccess=await updatePostUseCase(post);
  _mapFailureOrSuccess(failureOrSuccess);
 }

 _mapFailureOrSuccess(Either<Failure,Unit> either){
  either.fold((failure) {
   _postResponse=ApiResponse.error(_mapFailureToMessage(failure));
 //  _postResponse=ApiResponse.error(failure.toString());
   print(failure);
   notifyListeners();
  }, (_) {
   _postResponse= ApiResponse.completed(unit);
   print('oooooooooooooooooooo');
   getAllPosts();


  },);
 }

 _mapFailureOrPosts(Either<Failure, List<Post>>  either){
  either.fold((failure) {
   print(failure);
   _postsResponse = ApiResponse.error(_mapFailureToMessage(failure));
   notifyListeners();
  }, (postsList) {
   _postsResponse = ApiResponse.completed(postsList);
   notifyListeners();
  });
 }



 String _mapFailureToMessage(Failure failure) {
  if (failure is OfflineFailure) {
   print('ggggggggggggggggggg');
   return OFFLINE_FAILURE_MESSAGE;
  } else if (failure is ServerFailure) {
   return SERVER_FAILURE_MESSAGE;
  } else if (failure is EmptyCacheFailure) {
   return EMPTY_FAILURE_MESSAGE;
  } else {
   print('jjjjjjjjjjjjjjjjjjjjjj');

   return 'Unexpected Error! Please try again';
  }
 }


}
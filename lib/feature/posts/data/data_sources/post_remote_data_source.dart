
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutt_pro/core/api_helper/dio_inspector.dart';
import 'package:flutt_pro/core/errors/excpations.dart';
import 'package:flutt_pro/feature/posts/data/models/post_model.dart';

abstract class PostRemoteDataSource{
  Future<List<PostModel>> getAllPosts( );
  Future<Unit> addPost(PostModel post);
  Future<Unit> deletePost(int id);
  Future<Unit> updatePost(PostModel post);
}
const BASE_URL='https://jsonplaceholder.typicode.com';
class PostRemoteDataSourceImp implements PostRemoteDataSource{
  final Dio dio;

  PostRemoteDataSourceImp({required this.dio}){
    dio.interceptors.add(DioInterceptor());
  }


  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await dio.get('$BASE_URL/posts');

    if (response.statusCode == 200) {
      print('ssssssssssssss');
      List posts = response.data;
      print("Response data: $posts");

      // // إذا كانت الاستجابة عبارة عن نص (String) نقوم بتحويلها إلى JSON
      // if (posts is String) {
      //   try {
      //     posts = json.decode(posts); // تحويل النص إلى JSON
      //   } catch (e) {
      //     print("Error decoding JSON: $e");
      //     throw ServerException();
      //   }
      // }

      // استخدام map لتحويل العناصر من النوع dynamic إلى PostModel
      return posts.map((e) => PostModel.fromJson(e)).toList();

      // else {
      //   print('Unexpected data format: $posts');
      //   throw ServerException();
      // }
    } else {
      print('Server error: ${response.statusCode}');
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel post) async {
    final response=await dio.post('$BASE_URL/posts/',
    data:{
      'title':post.title.toString(),
    'body':post.body.toString(),
    // 'id':post.id,
    });
    if(response.statusCode==201){
      print('jjjjjjjFJJJJJJJJJJJJN');
      print(response.data);
      return Future.value(unit);
    }else{
      throw ServerException();
    }

  }

  @override
  Future<Unit> deletePost(int id) async {
    final response=await dio.delete('$BASE_URL/posts/${id.toString()}',);
    if(response.statusCode==200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }


  @override
  Future<Unit> updatePost(PostModel post) async {
    final postId=post.id.toString();
    final body= {'title':post.body,'body':post.title};


    final response=await dio.patch('$BASE_URL/posts/$postId',
      data: body

    );
    if(response.statusCode==200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }
  
}
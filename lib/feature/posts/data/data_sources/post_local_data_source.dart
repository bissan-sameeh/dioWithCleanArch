import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutt_pro/core/errors/excpations.dart';
import 'package:flutt_pro/feature/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDatSource {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> cachedPost(List<PostModel> post);
}

class PostLocalDatSourceImp implements PostLocalDatSource {
  final SharedPreferences sharedPreferences;

  PostLocalDatSourceImp({required this.sharedPreferences});

  @override
  Future<Unit> cachedPost(List<PostModel> post) async {
    List postModelToJson = post
        .map<Map<String, dynamic>>(
          (e) => e.toJson(),
        )
        .toList();
    sharedPreferences.setString('Cached_Posts', json.encode(postModelToJson));

    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    // TODO: implement getCachedPosts
 final jsonString= sharedPreferences.getString('Cached_Posts');
 if(jsonString!=null){
   List decodedJsonData =json.decode(jsonString); //convert string into list
   List<PostModel> postList=decodedJsonData.map((e) => PostModel.fromJson(e),).toList();
   return Future.value(postList);
 }else{
   throw EmptyCacheException();
 }


 }
}

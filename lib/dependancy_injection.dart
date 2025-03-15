import 'package:dio/dio.dart';
import 'package:flutt_pro/core/network/network_info.dart';
import 'package:flutt_pro/feature/posts/data/data_sources/post_local_data_source.dart';
import 'package:flutt_pro/feature/posts/data/data_sources/post_remote_data_source.dart';
import 'package:flutt_pro/feature/posts/data/reprositories/post_repositery.dart';
import 'package:flutt_pro/feature/posts/domain/reprositories/posts_reprositorty.dart';
import 'package:flutt_pro/feature/posts/domain/use_cases/add_post.dart';
import 'package:flutt_pro/feature/posts/domain/use_cases/delete_post.dart';
import 'package:flutt_pro/feature/posts/domain/use_cases/get_all_posts.dart';
import 'package:flutt_pro/feature/posts/domain/use_cases/update_post.dart';
import 'package:flutt_pro/feature/posts/presentation/provider/posts_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl =GetIt.instance;

Future<void> init() async{
  /// feature=>
  /// provider
  sl.registerFactory(() => PostsProvider(getAllPostsUseCase: sl.call(), addPostUseCase: sl(), updatePostUseCase: sl(), deletePostUseCae: sl(),),);//register for the first provider
  // sl.registerFactory(() => AddDeleteUpdateProvider(deletePostUseCae: sl(), updatePostUseCase: sl(), addPostUseCase: sl()),);//register for the first provider
  /// useCases
  sl.registerLazySingleton(() => GetAllPostsUseCase(repository: sl()),);
  sl.registerLazySingleton(() => AddPostUseCase(repository: sl()),); // when need function call it
  sl.registerLazySingleton(() => UpdatePostUseCase(repository: sl()),);
  sl.registerLazySingleton(() => DeletePostUseCae(repository: sl()),);
  /// repository
  sl.registerLazySingleton<PostsRepository>(() => PostRepositoryImp( remoteDataSource: sl(), localeDataSource: sl(), networkInfo: sl(),),);

  /// data sources
  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImp(dio: sl() ),);
  sl.registerLazySingleton<PostLocalDatSource>(() => PostLocalDatSourceImp(sharedPreferences: sl() ),);

  sl.registerLazySingleton(() => InternetConnectionChecker.instance);
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()),);
  /// core => external
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences,);
  sl.registerLazySingleton(() => Dio(),);



}
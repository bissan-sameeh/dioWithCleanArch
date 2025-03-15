import 'package:flutt_pro/core/api_helper/api_response.dart';
import 'package:flutt_pro/feature/posts/presentation/provider/posts_provider.dart';
import 'package:flutt_pro/feature/posts/presentation/screens/add_update_screen.dart';
import 'package:flutt_pro/feature/posts/presentation/screens/post_details_screen.dart';
import 'package:flutt_pro/feature/posts/presentation/widgets/posts_page/loaded_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Posts",style: TextStyle(color: Colors.white),),centerTitle: true,backgroundColor: Theme.of(context).primaryColor,),
      body: Consumer<PostsProvider>(
       builder: (context, postsPro, child) {
         // final postData=postsPro.postsList.data!;
         if(postsPro.postsList.status == ApiStatus.LOADING){
           return const LoadingWidget();
         }else if(postsPro.postsList.status == ApiStatus.COMPLETED){
           return LoadedStateWidget(posts:postsPro.postsList.data!);
         }else if(postsPro.postsList.status == ApiStatus.ERROR){
           return CustomErrorWidget( errorMessage: postsPro.postsList.message.toString());
         }else{
           return const LoadingWidget();
         }
       },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder:  (context) => const AddUpdateScreen(),));
      } ,
        backgroundColor: Theme.of(context).primaryColor,
      child:  const Icon(Icons.add,color: Colors.white,

      ),
      ),
    );
  }
}

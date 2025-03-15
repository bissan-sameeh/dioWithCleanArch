import 'package:flutt_pro/core/helper/snackbar.dart';
import 'package:flutt_pro/feature/posts/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/api_helper/api_response.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../provider/posts_provider.dart';

class DeleteDialogWidget extends StatefulWidget  {
  final int id;
  const DeleteDialogWidget({super.key, required this.id});

  @override
  State<DeleteDialogWidget> createState() => _DeleteDialogWidgetState();
}

class _DeleteDialogWidgetState extends State<DeleteDialogWidget> with ShowSnackBar{
  bool isDeleting=false;
  @override
  Widget build(BuildContext context) {
      return  AlertDialog(
        title: const Text('Are You Sure?'),
       content: isDeleting ?SizedBox(
           height: 40,
           width: 40,
           child: LoadingWidget()): SizedBox(),
       actions: [
         if(!isDeleting)

         TextButton(onPressed:  () {
           _deletePost(context,postId: widget.id);
         }, child:  const Text('Yes')),
         if(!isDeleting)

         TextButton(onPressed: () {
           Navigator.pop(context);
         }, child: const Text('No')),


       ],
      );
  }
  // _onAlertPressed(){
  //   Provider.of<PostsProvider>(context,listen: false).deletePost(postId);
  //   _deletePost();
  // }
 Future<LoadingWidget> _deletePost (BuildContext context,{required int postId}) async{
    // showDialog(context: context,
    //   barrierDismissible: false,
    //   builder: (context) {

      // return LoadingWidget();
   setState(() {
     isDeleting=true;
   });
  final postProvider= Provider.of<PostsProvider>(context,listen: false);
  await postProvider.deletePost(postId);

             if(postProvider.deletePostStatus.status==ApiStatus.COMPLETED){

                WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>showSnackBar(context, message: 'Post Deleted Successfully!'));
                if(context.mounted){

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen(),), (route) => false,);
                }
                setState(() {
                  isDeleting=false;
                });
              } if(postProvider.deletePostStatus.status==ApiStatus.ERROR){
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>showSnackBar(context, message: postProvider.deletePostStatus.message.toString(),error: true));
                  if(context.mounted) {
                    Navigator.pop(context);
                  }
              } return const LoadingWidget();
            }}







    // },);


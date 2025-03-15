import 'package:flutt_pro/core/api_helper/api_response.dart';
import 'package:flutt_pro/core/helper/snackbar.dart';
import 'package:flutt_pro/core/widgets/error_widget.dart';
import 'package:flutt_pro/core/widgets/loading_widget.dart';
import 'package:flutt_pro/feature/posts/presentation/provider/posts_provider.dart';
import 'package:flutt_pro/feature/posts/presentation/screens/add_update_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entity/post_entity.dart';
import '../delete_dialog_widget.dart';

class DetailsPostWidget extends StatelessWidget with ShowSnackBar{
  const DetailsPostWidget({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(
            height: 50,
          ),
          Text(post.body,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(
            height: 50,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddUpdateScreen(
                          post: post,
                        ),
                      ));
                    },
                    label: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Theme.of(context).primaryColor)),
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    )),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: ElevatedButton.icon(
                    onPressed: () {
                      deleteDialog(context,postId: post.id!);
                    //  deleteDialog(context, postId: post.id!,);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => AddUpdateScreen(
                      //     post: post,
                      //   ),
                      // ));
                    },
                    label: const Text('Delete',style: TextStyle(color: Colors.white),),
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.redAccent)),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }



  deleteDialog(BuildContext context,{required int postId}){
    showDialog(context: context, builder: (context) {
      return DeleteDialogWidget(id: postId, );
      // return Consumer<PostsProvider>(builder: (context, postPro, child) {
      //   if(postPro.deletePostStatus.status==ApiStatus.LOADING){
      //     return const LoadingWidget();
      //   } else if(postPro.deletePostStatus.status==ApiStatus.COMPLETED){
      //     // return show;
      //   } if(postPro.deletePostStatus.status==ApiStatus.ERROR){
      //     return  CustomErrorWidget(errorMessage: postPro.deletePostStatus.message.toString());
      //   } return const LoadingWidget();
      // },);
    },);
  }
  }


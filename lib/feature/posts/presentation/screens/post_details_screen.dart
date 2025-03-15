import 'package:flutt_pro/feature/posts/presentation/widgets/posts_page/details_post_widget.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/post_entity.dart';

class PostDetailsScreen extends StatefulWidget {
  final Post post;
  const PostDetailsScreen({super.key, required this.post});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: buildAppBar(context),
      body: _buildBody(),
    );

  }

  AppBar buildAppBar(BuildContext context) => AppBar(title: const Text('Post Details',style: TextStyle(color: Colors.white),),centerTitle: true,backgroundColor: Theme.of(context).primaryColor,);
  _buildBody(){
    return DetailsPostWidget(post: widget.post);
  }
}

import 'package:flutter/material.dart';

import '../../../domain/entity/post_entity.dart';
import '../../screens/post_details_screen.dart';

class LoadedStateWidget extends StatelessWidget {
  const LoadedStateWidget({super.key, required this.posts});
  final List<Post> posts;


  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
        // shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
      return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostDetailsScreen(post: posts[index]),)),

        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          title:Text(posts[index].title.toString(),style: const TextStyle(color: Colors.black,fontSize: 18),),
          subtitle:Text(posts[index].title.toString(),style: const TextStyle(color: Colors.grey,fontSize: 16),),


        ),
      );
    }, separatorBuilder: (context, index) {
      return const Divider(thickness: 1,);
    }, itemCount: posts.length);
  }
}

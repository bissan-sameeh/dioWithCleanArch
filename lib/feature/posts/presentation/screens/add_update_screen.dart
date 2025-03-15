import 'package:flutter/material.dart';

import '../../domain/entity/post_entity.dart';
import '../widgets/form_widgets/form_widget.dart';

class AddUpdateScreen extends StatelessWidget {
  final Post? post;

  const AddUpdateScreen({super.key, this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar buildAppBar(BuildContext context) => AppBar(
        title: Text(
          post == null ? 'Add' : 'Update',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      );

  _buildBody(context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          FormWidget(post: post,),
        ]),
      ),
    );
  }
}

import 'package:flutt_pro/core/api_helper/api_response.dart';
import 'package:flutt_pro/core/helper/snackbar.dart';
import 'package:flutt_pro/core/widgets/loading_widget.dart';
import 'package:flutt_pro/feature/posts/presentation/provider/posts_provider.dart';
import 'package:flutt_pro/feature/posts/presentation/screens/home_screen.dart';
import 'package:flutt_pro/feature/posts/presentation/widgets/form_widgets/submit_form_btn.dart';
import 'package:flutt_pro/feature/posts/presentation/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entity/post_entity.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key, this.post});

  final Post? post;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> with ShowSnackBar {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController(
        text: widget.post == null ? '' : widget.post!.title.toString());
    _bodyController = TextEditingController(
        text: widget.post == null ? '' : widget.post!.body.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _bodyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Text field
              TextFormFieldWidget(
                controller: _titleController, hint: 'Title',
                maxLines: false,
                // minLines: false,
              ),
              TextFormFieldWidget(
                controller: _bodyController, hint: 'Body',
                maxLines: true,
                // minLines: true,
              ),

              //btn
              SubmitFormBtn(
                onTap: () {
                  validateFormThenUpdateOrAddPost();
                },
                isAdd: widget.post == null,
              )
            ],
          ),
        ));
  }

  validateFormThenUpdateOrAddPost() async {
    final isValid = _formKey.currentState!.validate();
    print('uuuuuuuuuuuuuuuuuuuuuuuuuuuu');
    if (isValid) {
      final post = Post(
          id: widget.post != null ? widget.post!.id : null,
          title: _titleController.text,
          body: _bodyController.text);
        final updateOrAddPostPro =
            Provider.of<PostsProvider>(context, listen: false);
      if (widget.post != null) { //update
        //update
        await updateOrAddPostPro.updatePost(post);

        print('iiiiiiiiiiiiiiiiiiiiiiiiiii');
        if (mounted) {
          if (updateOrAddPostPro.updatePostStatus.status == ApiStatus.LOADING) {
            return const LoadingWidget();
          } else if (updateOrAddPostPro.updatePostStatus.status ==
              ApiStatus.COMPLETED) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
                showSnackBar(context, message: 'Post updated Successfully'));
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false,
            );
          } else if (updateOrAddPostPro.updatePostStatus.status ==
              ApiStatus.ERROR) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
                showSnackBar(context,
                    message: updateOrAddPostPro.updatePostStatus.message.toString(),
                    error: true));
          }
        }
      } else {
        await updateOrAddPostPro.addPost(post);
          if (mounted) {
            if (updateOrAddPostPro.addPostResponse.status == ApiStatus.LOADING) {
              return const LoadingWidget();
            } else if (updateOrAddPostPro.addPostResponse.status ==
                ApiStatus.COMPLETED) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
                  showSnackBar(context, message: 'Post added Successfully'));
              Navigator.pop(
                context,
              );
            } else if (updateOrAddPostPro.addPostResponse.status ==
                ApiStatus.ERROR) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
                  showSnackBar(context,
                      message: updateOrAddPostPro.addPostResponse.message.toString(),
                      error: true));
            }
        }
      }
    }
  }
}

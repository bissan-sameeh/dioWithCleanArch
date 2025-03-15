import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({super.key, required this.controller, required this.hint, this.maxLines=false});
  final TextEditingController controller;
  final String hint;
  final bool? maxLines;



  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(controller: controller,validator: (value) => value!.isEmpty ?'$hint can not be empty !':null,
        decoration:  InputDecoration(hintText: hint,border: const OutlineInputBorder(),focusedBorder: OutlineInputBorder()),minLines: maxLines==true ?6 :1,
      maxLines: maxLines==true?6 :1,
      ),
    );
  }
}

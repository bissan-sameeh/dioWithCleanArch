import 'package:flutter/material.dart';

class SubmitFormBtn extends StatelessWidget {
  const SubmitFormBtn({super.key, required this.onTap, required this.isAdd});
  final Function() onTap;
  final bool isAdd;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Theme.of(context).primaryColor) ),
        onPressed: onTap, label: Text(isAdd ?"Add":"Edit",style: TextStyle(color: Colors.white),),
        icon: Icon(isAdd ?Icons.add:Icons.edit,color: Colors.white,));
  }
}

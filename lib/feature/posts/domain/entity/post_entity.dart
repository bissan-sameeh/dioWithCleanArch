import 'package:equatable/equatable.dart';

class Post extends Equatable{
  final int? id;
  final String title;
  final String body;

   const Post({ this.id, required this.title, required this.body});

  //لما انشء تو اوبجيكت من نفس الكلاس واقله isEqual فهو لا , فبخليهم ايكول عن طريق الهاش ماب
  @override
  List<Object?> get props => [id,title,body];

}
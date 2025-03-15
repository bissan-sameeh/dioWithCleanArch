import 'package:flutt_pro/feature/posts/presentation/provider/posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'core/utils/style.dart';
import 'dependancy_injection.dart' as di;
import 'feature/posts/presentation/screens/home_screen.dart';

final sl = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //initialize the getter method
        ChangeNotifierProvider(
          create: (context) => di.sl<PostsProvider>()..getAllPosts(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: kBoldBlue),
        home: const HomeScreen(),
      ),
    );
  }
}

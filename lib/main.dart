import 'package:chating/Register/register_view.dart';
import 'package:chating/add_room/add_room_view.dart';
import 'package:chating/chat/chat_view.dart';
import 'package:chating/home/home_view.dart';
import 'package:chating/login/login_view.dart';
import 'package:chating/provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        RegisterView.routeName: (context) => RegisterView(),
        LoginView.routeName: (context) => LoginView(),
        HomeView.routeName: (context) => HomeView(),
        AddRoomView.routeName: (context) => AddRoomView(),
        ChatView.routeName: (context) => ChatView(),
      },
      initialRoute: provider.fireAuthUser == null
          ? LoginView.routeName
          : HomeView.routeName,
    );
  }
}

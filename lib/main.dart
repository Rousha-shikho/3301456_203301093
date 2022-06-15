import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/pages/Register_page.dart';
import 'package:scholar_chat/pages/chat_page.dart';

import 'firebase_options.dart';
import 'pages/login_page.dart';

void main()async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id :(context) => RegisterPage(),
        chatPage.id :(context) => chatPage(),
      },
      initialRoute: LoginPage.id,
    );
  }
}
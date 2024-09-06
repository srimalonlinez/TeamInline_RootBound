import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rootbound/screens/login_signup_screen.dart'; // Update with actual path
import 'package:rootbound/screens/home_screen.dart'; // Update with actual path
import 'package:rootbound/screens/account_screen.dart'; // Update with actual path

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAhBa5Ldzb5ZDa3NytMqeJ-XNO6-TAO1Bc",
      appId: "1:490156445439:android:68fe6cc47c7c70fa0886ca",
      messagingSenderId: "490156445439",
      projectId: "rootbound-d7942",
      storageBucket: "rootbound-d7942.appspot.com", // Ensure this is correct
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RootBound',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Set initial route
      routes: {
        '/login': (context) => LoginSignupScreen(),
        '/home': (context) => HomePage(),
        '/account': (context) => AccountScreen(),
      },
      debugShowCheckedModeBanner: false,
      onUnknownRoute: (settings) {
        // Handle unknown routes
        return MaterialPageRoute(builder: (context) => LoginSignupScreen());
      },
    );
  }
}

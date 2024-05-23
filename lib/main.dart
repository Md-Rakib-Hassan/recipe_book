import 'package:flutter/material.dart';
import 'package:recipe_book/pages/home.dart';
import 'package:recipe_book/pages/login.dart';


void main() {
  runApp(MyApp());
}

 class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       title: "RecipeBook",
       theme: ThemeData(
         colorScheme: ColorScheme.fromSeed(
             seedColor: Colors.deepOrange,
         ),
         useMaterial3: true,
         appBarTheme: AppBarTheme(
             titleTextStyle: TextStyle(
               color: Colors.black,
               fontSize: 26,
               fontWeight: FontWeight.bold,
             ))
       ),
      debugShowCheckedModeBanner: false,
      initialRoute:"/login" ,
      routes: {
         "/login":(context)=>Login(),
         "/home":(context)=>Home(),

      },
     );
   }
 }

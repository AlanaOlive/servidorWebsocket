import 'package:flutter/material.dart';
import 'package:server_socket/client_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicação cliente - Socket',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        bottomSheetTheme: const BottomSheetThemeData(
          constraints: BoxConstraints(
            maxHeight: 500.0,
            maxWidth: 1100
          ),
          backgroundColor: Color(0xFFFFFFF0)
        ),        
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.lightGreenAccent,
          elevation: 2.5,
          hoverColor: Colors.green,
          iconSize: 40,
          sizeConstraints: BoxConstraints(
            minHeight: 70,
            maxHeight: 85,
            minWidth: 110,
            maxWidth: 200
          )
          
          ),
          
      ),      
      home: const MyHomePage(title: 'Cliente Socket'),
    );
  }
}


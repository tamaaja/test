import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabularapp/controller/controller.dart';
import 'package:tabularapp/pages/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PredictionProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: true,
      home: const PredictionScreen(),
    );
  }
}


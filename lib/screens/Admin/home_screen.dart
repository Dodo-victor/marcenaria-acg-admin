import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Olá ${FirebaseAuth.instance.currentUser!.displayName }"),),
      body: Center(child: InkWell(
        onTap: () async {

         await FirebaseAuth.instance.signOut();
        },
        child: Text("Sair"),
      ),),
    );
  }
}
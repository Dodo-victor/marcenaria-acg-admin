import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  greetings() {
    final currentDate = DateTime.now();

    if (currentDate.hour >= 18) {
      return "Boa Noite";
    } else if (currentDate.hour < 12) {
      return "Bom Dia";
    } else if (currentDate.hour >= 12) {
      return "Boa Tarde";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 80),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text("${greetings()}, ${FirebaseAuth.instance.currentUser!.displayName} ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                    ),
                    const CircleAvatar(
                      radius: 20,
                    )
                  ],
                ),
              ),
            ],
          )),
    ));
  }
}

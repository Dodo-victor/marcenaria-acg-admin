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
        appBar: AppBar(
          title: Text(
            "Olá ${FirebaseAuth.instance.currentUser!.displayName}",
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit_note,
                size: 35,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text("Relatório Geral",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 8,
              ),
              const Divider(),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      //  border: Border(right: BorderSide(color: Colors.grey)),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                    child: const Column(
                      children: [
                        Text(
                          "350",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Mercadoria",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                      //border: Border(right: BorderSide(color: Colors.grey),),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          "2000000",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Solicitações",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ) /* Center(
        child: InkWell(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
          },
          child: Text("Sair"),
        ),
      ), */
        );
  }
}

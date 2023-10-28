import 'package:acg_admin/screens/Admin/add_merchandise_screen.dart';
import 'package:acg_admin/utilis/colors.dart';
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddMerchandiseScreen(),
                  ),
                );
              },
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
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 120,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          //  border: Border(right: BorderSide( : Colors.grey)),
                          borderRadius: BorderRadius.circular(10),
                          color: ColorsApp.googleSignInColor),
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
                      width: 10,
                    ),
                    Container(
                      width: 120,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: ColorsApp.googleSignInColor,
                        borderRadius: BorderRadius.circular(10),
                        //border: Border(right: BorderSide(color: Colors.grey),),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            "3525",
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
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 120,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: ColorsApp.googleSignInColor,
                        borderRadius: BorderRadius.circular(10),
                        //border: Border(right: BorderSide(color: Colors.grey),),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            "20",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Vendas",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
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

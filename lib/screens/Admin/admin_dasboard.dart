import 'package:acg_admin/screens/Admin/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Resources/firestore_methods.dart';
import '../../utilis/colors.dart';
import '../../widgets/settings_card.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 80),
        child: Container(
          color: ColorsApp.primaryTheme,
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
                      child: Text(
                        "Olá, ${FirebaseAuth.instance.currentUser!.displayName} ",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          FirebaseAuth.instance.currentUser!.photoURL!),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SettingsCard(
                  function: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsScreen())),
                  title: "Adicionar número",
                  icon: Icons.phone,
                ),
                const SizedBox(
                  width: 8,
                ),
                SettingsCard(
                  function: () async {
                    final _contact = {"numeroDeTelefone": "921750554"};
                    await FirestoreMethods().settingsRemote(
                        settingsType: "contactos",
                        data: _contact,
                        context: context);
                  },
                  title: "Editar Mercadoria",
                  icon: Icons.store_rounded,
                ),
              ],
            ),
            const Divider(),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius:
                    BorderRadiusDirectional.only(topEnd: Radius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

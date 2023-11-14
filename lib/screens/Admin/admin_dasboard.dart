import 'package:acg_admin/screens/Admin/settings_screen.dart';
import 'package:acg_admin/screens/Admin/statisc_screen.dart';
import 'package:acg_admin/widgets/submit_button.dart';
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
        body: ListView(
          children: [
            const SizedBox(
              height: 5,
            ),
            ListTile(
              autofocus: true,
              horizontalTitleGap: 10,
              hoverColor: ColorsApp.primaryTheme,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              focusColor: ColorsApp.primaryTheme,
              leading: const Text(
                "Adicionar contacto",
              ),
              leadingAndTrailingTextStyle: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 17),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                //  color: ColorsApp.primaryTheme,
              ),
            ),
            const Divider(),
            ListTile(
              autofocus: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              horizontalTitleGap: 10,
              hoverColor: ColorsApp.primaryTheme,
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog.adaptive(
                        title: const Text("Sair"),
                        content: const SizedBox(
                          height: 80,
                          child: Column(
                            children: [
                              Text("Tens a certeza que deseja saír?"),
                            ],
                          ),
                        ),
                        actions: [
                          SubmitButton(
                            title: "Não",
                            height: 50,
                            width: 80,
                            function: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SubmitButton(
                            title: "Sim",
                            width: 80,
                            function: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
              focusColor: ColorsApp.primaryTheme,
              leading: const Text(
                "Saír",
              ),
              leadingAndTrailingTextStyle: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 17),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                //  color: ColorsApp.primaryTheme,
              ),
            ),
            const Divider(),
            ListTile(
              autofocus: true,
              horizontalTitleGap: 10,
              hoverColor: ColorsApp.primaryTheme,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StatiscScreen(),
                  ),
                );
              },
              focusColor: ColorsApp.primaryTheme,
              leading: const Text(
                "Estatisticas",
              ),
              leadingAndTrailingTextStyle: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 17),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                //  color: ColorsApp.primaryTheme,
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utilis/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
              children: [
                Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: ColorsApp.googleSignInColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: FittedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone,
                          size: 30,
                          color: Colors.grey.shade900,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Adicionar número",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.black45),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: ColorsApp.googleSignInColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: FittedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.store_rounded,
                          size: 30,
                          color: Colors.grey.shade900,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Editar Mercadoria",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.black45),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

import 'package:acg_admin/screens/Admin/home_screen.dart';
import 'package:acg_admin/widgets/google_sign_button.dart';
import 'package:flutter/material.dart';

class AuthAdmin extends StatefulWidget {
  const AuthAdmin({super.key});

  @override
  State<AuthAdmin> createState() => _AuthAdminState();
}

class _AuthAdminState extends State<AuthAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SizedBox(
            height: 25,
          ),
          Container(
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Seja bem Vindo',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Marcenaria ACG Gonçalvess",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.black45,
                      ),
                ),
                const SizedBox(
                  height: 45,
                ),
                GoogleSignInButton(
                  function: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

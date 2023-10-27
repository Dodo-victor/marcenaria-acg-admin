import 'package:acg_admin/Resources/auth_admin_methods.dart';
import 'package:acg_admin/screens/Admin/bottomBar.dart';
import 'package:acg_admin/screens/Admin/home_screen.dart';
import 'package:acg_admin/widgets/google_sign_button.dart';
import 'package:flutter/material.dart';

class AuthAdmin extends StatefulWidget {
  const AuthAdmin({super.key});

  @override
  State<AuthAdmin> createState() => _AuthAdminState();
}

bool _isLogging = false;

class _AuthAdminState extends State<AuthAdmin> {
  final AuthAdminMethods _adminMethods = AuthAdminMethods();

  _signInWithGoogle({required BuildContext context}) async {
    setState(() {
      _isLogging = true;
    });
    bool res = await _adminMethods.authAdminUserWithGoogle(context: context);
    setState(() {
      _isLogging = false;
    });
    print(res);

    if (res == true) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const BottomBar(),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 200,
            ),
            Text(
              'Seja bem Vindo',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 80,
            ),
            Text(
              "Marcenaria ACG Gonçalves",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.black45,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 80,
            ),
            GoogleSignInButton(
              isLoading: _isLogging,
              function: () async {
                await _signInWithGoogle(context: context);

                // print(res);
              },
            ),
          ],
        ),
      ),
    );
  }
}

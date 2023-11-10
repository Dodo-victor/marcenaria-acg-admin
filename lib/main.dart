import 'package:acg_admin/Repository/contact_repository.dart';
import 'package:acg_admin/Repository/product_sell_repository.dart';
import 'package:acg_admin/firebase_options.dart';
import 'package:acg_admin/screens/Admin/bottomBar.dart';
import 'package:acg_admin/screens/Auth/auth_admin.dart';
import 'package:acg_admin/utilis/colors.dart';
import 'package:acg_admin/widgets/loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Resources/auth_admin_methods.dart';
import 'repository/merchandise_repository.dart';
import 'repository/request_repository.dart';

final requestProvider = ChangeNotifierProvider(
  (ref) => RequestRepository(),
);
final merchandiseProvider = ChangeNotifierProvider(
  (ref) => MercahndiseRepository(),
);
final productSellProvider = ChangeNotifierProvider(
  (ref) => ProductSellRepository(),
);
final addContactProvider = ChangeNotifierProvider(
  (ref) => ContactRepositoy(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACG Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        appBarTheme: AppBarTheme(backgroundColor: ColorsApp.primaryTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: ColorsApp.primaryTheme),
        scaffoldBackgroundColor: Colors.grey.shade100,
        bottomNavigationBarTheme:
            BottomNavigationBarThemeData(backgroundColor: Colors.grey.shade200),
        useMaterial3: true,
      ),
      home: StreamBuilder<dynamic>(
          stream: AuthAdminMethods().authStateChange(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Loader(),
              );
            }
            if (snapshot.hasData) {
              return const BottomBar();
            }
            return const AuthAdmin();
          }),
    );
  }
}

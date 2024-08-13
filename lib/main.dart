import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tayaar/core/components/constants.dart';
import 'package:tayaar/core/service_locator.dart/service_locator.dart';
import 'package:tayaar/features/checkingInfo/checking_info_screen.dart';
import 'package:tayaar/features/login/UI/login_screen.dart';

String? token = "";
void main() async {
  setupLocator();
  await Hive.initFlutter();
  await Hive.openBox(kTokenBoxString);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: kTokenBox.get(kTokenBoxString) == null
          ? const LoginScreen()
          : const CheckingInfo(),
    );
  }
}

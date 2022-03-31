import 'package:app_plantilla/screens/screens.dart';
import 'package:app_plantilla/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return const Text('Espere...');
            if (snapshot.data == '') {
              Future.microtask(() {
                /* Navigator.pushReplacementNamed(context, '/login'); */
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const LoginScreen(),
                      transitionDuration: const Duration(milliseconds: 0),
                    ));
              });
            } else {
              Future.microtask(() {
                /* Navigator.pushReplacementNamed(context, '/home'); */
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const HomeScreen(),
                      transitionDuration: const Duration(milliseconds: 0),
                    ));
              });
            }

            return Container();
          },
        ),
      ),
    );
  }
}

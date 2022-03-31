import 'package:app_plantilla/screens/screens.dart';
import 'package:app_plantilla/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthService()),
      ChangeNotifierProvider(create: (_) => ProductService()),
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/check-auth': (context) => const CheckAuthScreen(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/product': (context) => const ProductScreen(),
        '/register': (context) => const RegisterScreen(),
      },
      scaffoldMessengerKey: NotificationService.meesageKey,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[300],
      ),
    );
  }
}

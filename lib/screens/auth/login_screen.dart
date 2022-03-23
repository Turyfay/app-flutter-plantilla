import 'package:app_plantilla/providers/login_provider.dart';
import 'package:app_plantilla/utils/UI/input_decorations.dart';
import 'package:app_plantilla/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: 230),
        CardContainer(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                'Bienvenido',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 10),
              ChangeNotifierProvider(
                create: (_) => LoginProvider(),
                child: const _LoginForm(),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Olvidaste tu contraseña?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 50),
      ]),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Form(
        key: loginProvider.formKey,
        child: Column(children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'ejemplo@unah.hn',
                labelText: 'Correo institucional',
                icon: Icons.alternate_email_rounded),
            onChanged: (value) => loginProvider.email = value,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese su correo institucional';
              }

              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);

              if (!regExp.hasMatch(value)) {
                return 'Por favor ingrese un correo institucional válido';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Contraseña',
                icon: Icons.lock_rounded,
                hintText: '******'),
            obscureText: true,
            onChanged: (value) => loginProvider.password = value,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese su contraseña';
              }

              return null;
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (!loginProvider.isValidForm()) return;
              loginProvider.isLoading = true;
              Navigator.pushReplacementNamed(context, '/home');
            },
            disabledColor: Colors.grey,
            color: Colors.purple,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                loginProvider.isLoading ? 'Cargando...' : 'Iniciar sesión',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.blue, width: 2),
            ),
          ),
        ]));
  }
}

import 'package:duitku/auth/data/messages/login_request.dart';
import 'package:duitku/auth/presentation/bloc/providers/auth_provider.dart';
import 'package:duitku/auth/presentation/bloc/states/login_state.dart';
import 'package:duitku/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/login";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  AuthProvider? authProv;

  @override
  void initState() {
    authProv = context.read<AuthProvider>();
    super.initState();
  }

  String? _username;
  String? _password;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final body = LoginRequest(
        username: _username!,
        password: _password!,
      );

      await authProv?.login(body: body);

      if (authProv?.loginState is LoginOkState) {
        authProv?.resetStates();

        if (mounted) {
          Navigator.of(context).pushReplacementNamed(MyHomePage.routeName);
        }
      } else if (authProv?.loginState is! LoginLoadingState) {
        final message = authProv?.loginState is LoginFailureState
            ? (authProv?.loginState as LoginFailureState).message
            : "Failed to login";
        final snackBar = SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
        );

        if (mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Duitku",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Username",
                              hintText: "Enter your username",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onChanged: (String? val) {
                              setState(() {
                                _username = val;
                              });
                            },
                            onSaved: (String? val) {
                              setState(() {
                                _username = val;
                              });
                            },
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter your username";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Enter your password",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            onChanged: (String? val) {
                              setState(() {
                                _password = val;
                              });
                            },
                            onSaved: (String? val) {
                              setState(() {
                                _password = val;
                              });
                            },
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Provider.of<AuthProvider>(context).loginState
                                      is LoginLoadingState
                                  ? const CircularProgressIndicator()
                                  : Expanded(
                                      child: ElevatedButton(
                                        onPressed: _login,
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                        ),
                                        child: const Text(
                                          "Submit",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  MyHomePage.routeName,
                                );
                              },
                              child: const Text(
                                "Sign in as Guest",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

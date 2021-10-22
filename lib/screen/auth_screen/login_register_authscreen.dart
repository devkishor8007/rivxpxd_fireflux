import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rivxpxd_fireflux/riverpod/auth_riverpod.dart';
import 'package:rivxpxd_fireflux/utilis/colors/colors_utilis.dart';

enum Status {
  login,
  signup,
}

Status type = Status.login;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _isLoading1 = false;

  void loading() {
    _isLoading1 = !_isLoading1;
  }

  void _switchType() {
    if (type == Status.signup) {
      setState(() {
        type = Status.login;
      });
    } else {
      setState(() {
        type = Status.signup;
      });
    }
    debugPrint(type.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, watch, _) {
        final _auth = watch(authenticationProvider);

        Future<void> _onPressedFunction() async {
          if (!_formkey.currentState!.validate()) {
            return;
          }
          if (type == Status.login) {
            loading();
            await _auth
                .loginWithEmail(email: _email.text, password: _password.text)
                .whenComplete(() => _auth.authStateChanges.listen((data) async {
                      if (data == null) {
                        loading();
                        return;
                      }
                    }));
          } else {
            loading();
            await _auth
                .createWithEmail(email: _email.text, password: _password.text)
                .whenComplete(() => _auth.authStateChanges.listen((data) async {
                      if (data == null) {
                        loading();
                        return;
                      }
                    }));
          }
        }

        return Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: ColorApp.red,
                  child: Text(
                    '<^>',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.headline3!.fontSize,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  'Rivxpxd FireFlux',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Theme.of(context).textTheme.headline6!.fontSize,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _email,
                  autocorrect: true,
                  enableSuggestions: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email address',
                    hintStyle: TextStyle(color: ColorApp.black),
                    icon: Icon(Icons.email_outlined,
                        color: ColorApp.blue, size: 24),
                    alignLabelWithHint: true,
                    border: InputBorder.none,
                  ),
                  validator: (val) {
                    if (val!.isEmpty || !val.contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.black54),
                    icon: Icon(Icons.lock_rounded,
                        color: ColorApp.blue, size: 24),
                    alignLabelWithHint: true,
                    border: InputBorder.none,
                  ),
                  validator: (val) {
                    if (val!.isEmpty || val.length < 5) {
                      return 'Invalid password as too short';
                    }
                    return null;
                  },
                ),
                if (type == Status.signup)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.black54),
                        icon: Icon(Icons.lock_rounded,
                            color: ColorApp.blue, size: 24),
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                      ),
                      validator: type == Status.signup
                          ? (val) {
                              if (val != _password.text) {
                                return 'Invalid password as too short';
                              }
                              return null;
                            }
                          : null,
                    ),
                  ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  child: _isLoading1
                      ? const Center(child: CircularProgressIndicator())
                      : MaterialButton(
                          onPressed: _onPressedFunction,
                          child: Text(
                            type == Status.login ? 'Login' : 'Signup',
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .fontSize,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: ColorApp.green,
                          textColor: ColorApp.white,
                          minWidth: 200.3,
                          height: 40,
                        ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(type == Status.login
                        ? 'Don\'t have an account'
                        : 'Already have an account?'),
                    TextButton(
                      onPressed: () {
                        _switchType();
                      },
                      child: Text(
                        type == Status.login ? 'Sign Now' : 'Login',
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

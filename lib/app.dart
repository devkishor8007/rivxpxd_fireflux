import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rivxpxd_fireflux/riverpod/auth_riverpod.dart';
import 'package:rivxpxd_fireflux/screen/auth_screen/login_register_authscreen.dart';
import 'package:rivxpxd_fireflux/screen/view_screen/home_screen.dart';
import 'package:rivxpxd_fireflux/utilis/widget/error_widget_screen.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authState = watch(authStateProvider);
    return authState.when(
      data: (data) {
        if (data != null) return const HomeScreen();
        return const LoginScreen();
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, stackTrace) => ErrorScreen(e, stackTrace),
    );
  }
}

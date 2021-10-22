import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rivxpxd_fireflux/riverpod/auth_riverpod.dart';
import 'package:rivxpxd_fireflux/riverpod/sample_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // to get the data of authenticated user
    final data = watch(firebaseAuthProvider);

    // to access logout
    final _auth = watch(authenticationProvider);

    // to access sample riverpod
    // to show welcome msg
    final msg = watch(welcomemsg);

    final appName = watch(appname);

    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.red,
                child: Text(
                  '<^>',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Theme.of(context).textTheme.headline3!.fontSize,
                  ),
                ),
              ),
              accountName: Text(
                appName,
              ),
              accountEmail: Text(
                data.currentUser!.email.toString(),
              ),
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () async {
                await _auth.logout();
              },
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          Text(
            msg,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline6!.fontSize,
            ),
          ),
        ],
      ),
    );
  }
}

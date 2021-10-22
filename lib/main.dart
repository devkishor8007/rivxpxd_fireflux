import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rivxpxd_fireflux/app.dart';
import 'package:rivxpxd_fireflux/utilis/widget/error_widget_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

// check firebase is initialized or not
final firebaseinitializeProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp();
});

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final initialize = watch(firebaseinitializeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        primarySwatch: Colors.indigo,
      ),
      home: initialize.when(
        data: (data) {
          return const AuthChecker();
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, stackTrace) => ErrorScreen(e, stackTrace),
      ),
    );
  }
}

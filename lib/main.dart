import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/crud/presentation/provider/todos_provider.dart';
import 'package:todo_app/features/check_auth.dart';
import 'core/routes/routes.dart';
import 'service_locator.dart';
import 'firebase_options.dart';
import 'package:todo_app/features/auth/presentation/provider/authentication_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthenticationProvider>(
        create: (_) => ServiceLocator.getIt<AuthenticationProvider>(),
      ),
      ChangeNotifierProvider<TodosProvider>(
        create: (_) {
          return ServiceLocator.getIt<TodosProvider>();
        },
      ),
    ],
    builder: (context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TO Do App',
        onGenerateRoute: AppRouters().generateRoute,
        theme: ThemeData(
          primarySwatch: Colors.pink,
          scaffoldBackgroundColor: Color(0xFFf6f5ee),
        ),
        home: CheckAuth(),
      );
    },
  );
}

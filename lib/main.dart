import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/services/service_locator.dart';
import 'package:notes/modules/auth/presentation/controller/bloc/auth_bloc.dart';
import 'package:notes/modules/auth/presentation/screens/login_screen.dart';
import 'package:notes/modules/todo/presintaion/screens/home_screen.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'core/services/local_notifcation.dart';
import 'modules/todo/presintaion/controller/todo_bloc.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
   tz.initializeTimeZones();

   ServicesLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
        ),
        BlocProvider<TodoBloc>(
          create: (_) => sl<TodoBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        ),
        home: const LoginScreen(),
      ),
    );
  }
}
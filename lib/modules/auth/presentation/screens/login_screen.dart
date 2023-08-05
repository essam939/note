import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/services/service_locator.dart';
import 'package:notes/core/utilis/enums.dart';
import 'package:notes/modules/auth/presentation/controller/bloc/auth_bloc.dart';
import 'package:notes/modules/auth/presentation/controller/bloc/auth_state.dart';
import 'package:notes/modules/todo/presintaion/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController email;
  late TextEditingController password;
  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    email = TextEditingController(text: "flutter-task@test.com");
    password = TextEditingController(text: "12345678");
    authBloc = AuthBloc(sl());
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Form(
            child: Column(children: [
          Text("Login"),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      labelText: 'Email *',
                    ),
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                      labelText: 'password *',
                    ),
                    validator: (String? value) {
                      return (value != null && value.length > 7)
                          ? 'enter valid password'
                          : null;
                    },
                  ),
                  SizedBox(
                    height: 29,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    bloc: authBloc,
                    listener: (context, state) {
                      print("hhhhh ${state}");
                      if (state.loginState == RequestState.loaded) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => HomeScreen()));
                      } else if (state.loginState == RequestState.error) {
                        var snackBar = SnackBar(
                          content: Text("${state.message}"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    builder: (context, state) {
                      if(state.loginState ==RequestState.loading){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      else{
                        return Container(
                          height: 60.0,
                          width: 300.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(colors: [
                                Color(0xff030091),
                                Color(0xff00FFFF),
                              ])),
                          child: ElevatedButton(
                            onPressed: () {
                              authBloc.add(LoginUser(
                                  email: email.text.toLowerCase().trim(),
                                  password: password.text));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent),
                            child: Text(
                              'Sign in',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        );
                      }

                    },
                  ),
                ],
              ),
            ),
          ),
        ])),
      ),
    );
  }
}

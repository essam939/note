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
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
   // email = TextEditingController();
    email = TextEditingController(text: "flutter-task@test.com");
    password = TextEditingController(text: "12345678");
   // password = TextEditingController();
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Form(
          key: _formKey,
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 34,),
          const Text("Login",style: TextStyle(color: Color(0xff181743),fontSize: 32),),
                    SizedBox(height: 50,),
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30) ),
                boxShadow: [
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.16),offset: Offset(0,-3))
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        enabledBorder:InputBorder.none,
                        helperText: 'Enter your email',
                        helperStyle: TextStyle(color: Colors.grey),
                        labelText: 'Email *',
                      ),
                      validator: (String? value) {
                        return (value != null && value.contains('@'))
                            ? null
                            : 'Do not use the @ char.';
                      },
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        helperText: 'Enter your password',
                        helperStyle: TextStyle(color: Colors.grey),
                        enabledBorder:InputBorder.none,
                        labelText: 'password *',
                      ),
                      validator: (String? value) {
                        return (value != null && value.length > 7)
                            ? null
                            : 'enter valid password';
                      },
                    ),
                    const SizedBox(
                      height: 29,
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      bloc: authBloc,
                      listener: (context, state) {
                        if (state.loginState == RequestState.loaded) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const HomeScreen()));
                        } else if (state.loginState == RequestState.error) {
                          var snackBar = SnackBar(
                            content: Text("${state.message}"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      builder: (context, state) {
                        if(state.loginState ==RequestState.loading){
                          return const Center(child: CircularProgressIndicator(),);
                        }
                        else{
                          return Container(
                            height: 60.0,
                            width: 300.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(colors: [
                                  Color(0xff030091),
                                  Color(0xff00FFFF),
                                ])),
                            child: ElevatedButton(
                              onPressed: () {
                                if(!_formKey.currentState!.validate()){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please Enter Valid Email and Password')),
                                  );
                                }else{
                                  authBloc.add(LoginUser(
                                      email: email.text.toLowerCase().trim(),
                                      password: password.text));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent),
                              child: const Text(
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
        ]),
            )),
      ),
    );
  }
}

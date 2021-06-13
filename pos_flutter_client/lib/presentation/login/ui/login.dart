import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_client/generated/locale_keys.g.dart';
import 'package:pos_flutter_client/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:pos_flutter_client/presentation/login/bloc/login_bloc.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  bool? isSee;

  @override
  void initState() {
    super.initState();
    isSee = true;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.btn_login).tr(),
        ),
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (ctx, state) {
            return BlocListener<LoginBloc, LoginState>(
              listener: (ctx, state) {
                BlocProvider.of<AuthenticationBloc>(ctx)
                    .add(LoginAuthenticationEvent());
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (ctx, state) => Form(
                  key: _keyForm,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Visibility(
                          visible: state is LoginError ? true : false,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              state is LoginError ? state.errorMess : "",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(hintText: 'Email'),
                          validator: (email) {
                            if (email != null) {
                              if (!EmailValidator.validate(email)) {
                                return "Please enter email";
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          validator: (password) {
                            if (password != null) {
                              if (password.length < 6) {
                                return "Please enter at least 6 characters";
                              }
                            }
                            return null;
                          },
                          controller: _passController,
                          obscureText: isSee ?? true,
                          decoration: InputDecoration(
                            hintText: LocaleKeys.password.tr(),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.visibility_off_outlined),
                              onPressed: () {
                                setState(() {
                                  isSee = !(isSee ?? false);
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 130,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: MaterialButton(
                            color: Color(0xff7CB342),
                            onPressed: () {
                              if (_keyForm.currentState != null &&
                                  _keyForm.currentState!.validate()) {
                                BlocProvider.of<LoginBloc>(ctx).add(
                                    LoggingEvent(
                                        email: _emailController.text,
                                        password: _passController.text));
                              }
                            },
                            textColor: Colors.white,
                            child: Text(LocaleKeys.btn_login.tr()),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

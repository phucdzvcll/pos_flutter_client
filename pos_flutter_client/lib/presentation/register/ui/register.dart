import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_client/generated/locale_keys.g.dart';
import 'package:pos_flutter_client/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:pos_flutter_client/presentation/register/bloc/register_bloc.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  bool? _isSee;
  bool? _isEmail = true;
  bool? _isPassword = true;

  @override
  void initState() {
    super.initState();
    _isSee = true;
    _focusNodeEmail.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _focusNodeEmail.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.btn_register).tr(),
        ),
        body: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (ctx, state) {
            return BlocListener<RegisterBloc, RegisterState>(
              listener: (ctx, state) {
                BlocProvider.of<AuthenticationBloc>(ctx)
                    .add(LoginAuthenticationEvent());
              },
              child: BlocBuilder<RegisterBloc, RegisterState>(
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
                          visible: state is RegisterError ? true : false,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              state is RegisterError ? state.errorMess : "",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          focusNode: _focusNodeEmail,
                          autofocus: true,
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              errorText: !(_isEmail!)
                                  ? LocaleKeys.warning_email.tr()
                                  : null),
                          onChanged: (email) {
                            if (!EmailValidator.validate(email)) {
                              setState(() {
                                _isEmail = false;
                              });
                            } else {
                              setState(() {
                                _isEmail = true;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          focusNode: _focusNodePassword,
                          onChanged: (password) {
                            if (password.length < 6) {
                              setState(() {
                                _isPassword = false;
                              });
                            } else {
                              setState(() {
                                _isPassword = true;
                              });
                            }
                          },
                          controller: _passController,
                          obscureText: _isSee ?? true,
                          onFieldSubmitted: (v) => _submitForm(ctx),
                          decoration: InputDecoration(
                            hintText: LocaleKeys.password.tr(),
                            errorText: !(_isPassword!)
                                ? LocaleKeys.warning_password.tr()
                                : null,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.visibility_off_outlined),
                              onPressed: () {
                                setState(() {
                                  _isSee = !(_isSee ?? false);
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
                              _submitForm(ctx);
                            },
                            textColor: Colors.white,
                            child: Text(LocaleKeys.btn_register.tr()),
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

  void _submitForm(BuildContext ctx) {
    if (_keyForm.currentState != null && _keyForm.currentState!.validate()) {
      BlocProvider.of<RegisterBloc>(ctx).add(RegisteringEvent(
          email: _emailController.text, password: _passController.text));
    }
  }
}

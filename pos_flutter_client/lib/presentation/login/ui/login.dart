import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_client/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:pos_flutter_client/presentation/login/bloc/login_bloc.dart';

class Login extends StatelessWidget {
  final String? email;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  Login({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (ctx, state) {
            return BlocListener<LoginBloc, LoginState>(
              listener: (ctx, state) {
                BlocProvider.of<AuthenticationBloc>(ctx)
                    .add(LoginAuthenticationEvent());
              },
              child: _body(ctx, state),
            );
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext ctx, LoginState state) {
    return Form(
      key: _keyForm,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: ListView(
          children: [
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
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _emailController,
              // initialValue: email != null ? email : null,
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
            SizedBox(height: 30),
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
              // obscureText: loginController.obscureTextRx.value.isObscureText,
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility_off_outlined),
                  onPressed: () {
                    // loginController.changeObscureText();
                  },
                ),
              ),
            ),
            SizedBox(
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
                    BlocProvider.of<LoginBloc>(ctx).add(LoggingEvent(
                        email: _emailController.text,
                        password: _passController.text));
                  }
                },
                textColor: Colors.white,
                child: Text("NEXT"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

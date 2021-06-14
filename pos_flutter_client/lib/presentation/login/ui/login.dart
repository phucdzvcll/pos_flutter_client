import 'package:flutter/material.dart';
import 'package:pos_flutter_client/common/common.dart';
import 'package:pos_flutter_client/presentation/login/controller/login_controller.dart';

class Login extends StatelessWidget {
  final FocusNode _focusNodeEmail = FocusNode()..requestFocus();
  final FocusNode _focusNodePassword = FocusNode();
  final String? email;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  final LoginController loginController = LoginController();

  Login({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return Form(
      key: _keyForm,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: ListView(
          children: [
            GetXWrapBuilder<LoginController>(
                builder: (_) => Visibility(
                      visible:
                          loginController.errorMessageRx.value.errorMessage ==
                                  ""
                              ? false
                              : true,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          loginController.errorMessageRx.value.errorMessage,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                    ),
                initController: loginController),
            SizedBox(
              height: 20,
            ),
            GetXWrapBuilder<LoginController>(
              initController: loginController,
              builder: (_) => TextFormField(
                focusNode: _focusNodeEmail,
                onFieldSubmitted: (v) {
                  _focusNodePassword.requestFocus();
                },
                onChanged: (v) {
                  loginController.warningEmail(v);
                },
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: 'Email',
                    errorText: loginController.warningEmailRx.value.isEmail
                        ? null
                        : "Please enter email"),
              ),
            ),
            SizedBox(height: 30),
            GetXWrapBuilder<LoginController>(
                builder: (_) => TextFormField(
                      focusNode: _focusNodePassword,
                      controller: _passController,
                      onChanged: (v) {
                        loginController.warningPassword(v);
                      },
                      onFieldSubmitted: (v) {
                        _submitForm();
                      },
                      obscureText:
                          loginController.obscureTextRx.value.isObscureText,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        errorText:
                            loginController.warningPasswordRx.value.isPassword
                                ? null
                                : "Please enter at least 6 characters",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility_off_outlined),
                          onPressed: () {
                            loginController.changeObscureText();
                          },
                        ),
                      ),
                    ),
                initController: loginController),
            SizedBox(
              height: 130,
            ),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: MaterialButton(
                color: Color(0xff7CB342),
                onPressed: () {
                  _submitForm();
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

  void _submitForm() {
    if (_keyForm.currentState != null && _keyForm.currentState!.validate()) {
      loginController.login(_emailController.text, _passController.text);
    }
  }
}

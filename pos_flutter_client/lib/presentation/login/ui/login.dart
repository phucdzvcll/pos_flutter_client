import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_flutter_client/common/common.dart';
import 'package:pos_flutter_client/presentation/login/controller/login_controller.dart';
import 'package:pos_flutter_client/presentation/order/ui/order.dart';

class Login extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  final LoginController loginController = LoginController();

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
        child: Column(
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
            SizedBox(height: 30),
            GetXWrapBuilder<LoginController>(
                builder: (_) => TextFormField(
                      validator: (password) {
                        if (password != null) {
                          if (password.length < 6) {
                            return "Please enter at least 6 characters";
                          }
                        }
                        return null;
                      },
                      controller: _passController,
                      obscureText:
                          loginController.obscureTextRx.value.isObscureText,
                      decoration: InputDecoration(
                        hintText: 'Password',
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
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: MaterialButton(
                color: Color(0xff7CB342),
                onPressed: () {
                  if (_keyForm.currentState != null &&
                      _keyForm.currentState!.validate()) {
                    loginController
                        .login(_emailController.text, _passController.text)
                        .then((value) {
                      if (value != null) {
                        print(value);
                        Get.to(Order());
                      }
                    });
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

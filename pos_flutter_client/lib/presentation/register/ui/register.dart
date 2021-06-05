import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pos_flutter_client/common/common.dart';
import 'package:pos_flutter_client/presentation/register/controller/register_controller.dart';

class Register extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  final RegisterController registerController = RegisterController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create Account"),
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
            GetXWrapBuilder<RegisterController>(
                builder: (_) => Visibility(
                      visible: registerController
                                  .errorMessageRx.value.errorMessage ==
                              ""
                          ? false
                          : true,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          registerController.errorMessageRx.value.errorMessage,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                    ),
                initController: registerController),
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
            GetXWrapBuilder<RegisterController>(
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
                          registerController.obscureTextRx.value.isObscureText,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility_off_outlined),
                          onPressed: () {
                            registerController.changeObscureText();
                          },
                        ),
                      ),
                    ),
                initController: registerController),
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
                    registerController.register(
                        _emailController.text, _passController.text);
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

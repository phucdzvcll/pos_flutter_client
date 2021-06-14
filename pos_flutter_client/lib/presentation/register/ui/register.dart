import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_flutter_client/common/common.dart';
import 'package:pos_flutter_client/presentation/register/controller/register_controller.dart';

class Register extends StatelessWidget {
  final FocusNode _focusNodeEmail = FocusNode()..requestFocus();
  final FocusNode _focusNodePassword = FocusNode();
  final _keyForm = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final RegisterController registerController = RegisterController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("btn_register".tr),
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
            GetXWrapBuilder<RegisterController>(
              initController: registerController,
              builder: (_) => TextFormField(
                focusNode: _focusNodeEmail,
                onFieldSubmitted: (v) {
                  _focusNodePassword.requestFocus();
                },
                onChanged: (v) {
                  registerController.warningEmail(v);
                },
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: 'Email',
                    errorText: registerController.warningEmailRx.value.isEmail
                        ? null
                        : "warning_email".tr),
              ),
            ),
            SizedBox(height: 30),
            GetXWrapBuilder<RegisterController>(
                builder: (_) => TextFormField(
                      focusNode: _focusNodePassword,
                      controller: _passController,
                      onChanged: (v) {
                        registerController.warningPassword(v);
                      },
                      onFieldSubmitted: (v) {
                        _submitForm();
                      },
                      obscureText:
                          registerController.obscureTextRx.value.isObscureText,
                      decoration: InputDecoration(
                        hintText: 'password'.tr,
                        errorText: registerController
                                .warningPasswordRx.value.isPassword
                            ? null
                            : "warning_password".tr,
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
                child: Text("btn_register".tr),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_keyForm.currentState != null && _keyForm.currentState!.validate()) {
      registerController.register(_emailController.text, _passController.text);
    }
  }
}

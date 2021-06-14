import 'package:easy_localization/easy_localization.dart' as easyLocalization;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_flutter_client/common/switch_change_locale.dart';
import 'package:pos_flutter_client/generated/locale_keys.g.dart';
import 'package:pos_flutter_client/presentation/login/ui/login.dart';
import 'package:pos_flutter_client/presentation/register/ui/register.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(color: Colors.green),
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 0,
                      child: SwitchWidget(),
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: MaterialButton(
                            onPressed: () {
                              Get.to(Register());
                            },
                            child: Text(
                                easyLocalization.tr(LocaleKeys.btn_register)),
                            color: Color(0xff74b83d),
                            elevation: 0,
                            textColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: MaterialButton(
                            onPressed: () {
                              Get.to(Login());
                            },
                            child:
                                Text(easyLocalization.tr(LocaleKeys.btn_login)),
                            color: Colors.white,
                            shape: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xff74b83d))),
                            elevation: 0,
                            textColor: Color(0xff74b83d),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

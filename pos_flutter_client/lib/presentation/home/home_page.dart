import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_client/common/switch_change_language.dart';
import 'package:pos_flutter_client/generated/locale_keys.g.dart';
import 'package:pos_flutter_client/presentation/login/bloc/login_bloc.dart';
import 'package:pos_flutter_client/presentation/login/ui/login.dart';
import 'package:pos_flutter_client/presentation/register/bloc/register_bloc.dart';
import 'package:pos_flutter_client/presentation/register/ui/register.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.green),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width,
                  child: Stack(children: [
                    Image.asset('assets/images/logo.png'),
                    Positioned(
                      right: 10,
                      child: Builder(
                        builder: (ctx) => SwitchWidget(),
                      ),
                    )
                  ]),
                ),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider<RegisterBloc>(
                                  create: (_) {
                                    return RegisterBloc();
                                  },
                                  child: Register(),
                                ),
                              ),
                            );
                          },
                          child: Text(LocaleKeys.btn_register.tr()),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider<LoginBloc>(
                                  create: (_) {
                                    return LoginBloc();
                                  },
                                  child: Login(),
                                ),
                              ),
                            );
                          },
                          child: Text(LocaleKeys.btn_login.tr()),
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
    );
  }
}

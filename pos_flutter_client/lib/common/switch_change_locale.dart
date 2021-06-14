import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwitchWidget extends StatelessWidget {
  final String sharedLanguageCodeKey = "language_key";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: SizedBox(
            width: 25,
            height: 15,
            child: SvgPicture.asset(
              'icons/flags/svg/vn.svg',
              package: 'country_icons',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Switch(
          onChanged: (value) {
            if (Get.locale!.languageCode == 'en') {
              Get.updateLocale(Locale('vi'));
            } else {
              Get.updateLocale(Locale('en'));
            }
            _saveLanguageCode(value);
          },
          value: Get.locale!.languageCode == 'en',
          activeColor: Colors.blue[300],
          activeTrackColor: Colors.white,
          inactiveThumbColor: Colors.red[300],
          inactiveTrackColor: Colors.white,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: SizedBox(
            width: 25,
            height: 15,
            child: SvgPicture.asset(
              'icons/flags/svg/au.svg',
              package: 'country_icons',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }

  _saveLanguageCode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(sharedLanguageCodeKey, value);
  }
}

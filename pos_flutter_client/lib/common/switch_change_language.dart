import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SwitchWidget extends StatefulWidget {
  @override
  _SwitchWidgetState createState() => new _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool? state = false;

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
            setState(() {
              // state = !(state!);
              if (value) {
                context.setLocale(Locale("en"));
              } else {
                context.setLocale(Locale("vi"));
              }
            });
          },
          value: context.locale.languageCode == "en",
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
}

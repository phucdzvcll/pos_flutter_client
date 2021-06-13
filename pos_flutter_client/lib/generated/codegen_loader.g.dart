// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "btn_login": "LOGIN",
  "btn_register": "REGISTER",
  "password": "Password",
  "user_not_found": "No user found for that email.",
  "wrong_password": "Wrong password provided for that user.",
  "email_already_in_use": "The account already exists for that email.",
  "password_weak": "The password provided is too weak.",
  "warning_password": "Please enter at least 6 characters",
  "warning_email": "Please enter email",
  "btn_save": "SAVE",
  "btn_charge": "CHARGE",
  "btn_ticket": "Ticket",
  "search": "Search",
  "sale": "Sale",
  "receipts": "Receipts",
  "items": "Items",
  "setting": "Setting",
  "black_office": "Black office",
  "app": "App",
  "help": "Help",
  "logout": "Logout",
  "tax": "Tax",
  "total": "Total",
  "dine_in": "Dine in",
  "take_away": "Take away",
  "quantity_label": "Quantity",
  "comment_label": "Comment",
  "comment": "Enter your comment"
};
static const Map<String,dynamic> vi = {
  "btn_login": "ĐĂNG NHẬP",
  "btn_register": "ĐĂNG KÝ",
  "password": "Mật khẩu",
  "user_not_found": "Email chưa được đăng kí.",
  "wrong_password": "Sai mật khẩu.",
  "email_already_in_use": "Email đã tồn tại.",
  "password_weak": "Mật khẩu yếu.",
  "warning_password": "Vui lòng nhập ít nhất 6 kí tự.",
  "warning_email": "Vui lòng nhập email hợp lệ.",
  "btn_save": "LƯU",
  "btn_charge": "THANH TOÁN",
  "btn_ticket": "SẢN PHẨM",
  "search": "Tìm kiếm",
  "sale": "Mua hàng",
  "receipts": "Hóa đơn",
  "items": "Sản phẩm",
  "setting": "Cài đặt",
  "black_office": "Văn phòng",
  "app": "Ưng dụng",
  "help": "Trợ giúp",
  "logout": "Đăng xuất",
  "tax": "Thuế",
  "total": "Tổng cộng",
  "dine_in": "Dùng tại quán",
  "take_away": "Mang về",
  "quantity_label": "Số lượng",
  "comment_label": "Chú thích",
  "comment": "Nhập chú thích"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "vi": vi};
}

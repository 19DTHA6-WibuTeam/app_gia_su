import 'dart:convert';
import 'package:gia_su_trung_tam_mobile/manager/shared_preferences.dart';
import 'package:gia_su_trung_tam_mobile/models/user.dart';
import 'package:gia_su_trung_tam_mobile/theme/dimens.dart';
import 'package:http/http.dart' as http;

Future<User?> fetchLogin(String email, String password) async {
  var map = new Map<String, dynamic>();
  map['Email'] = email;
  map['MatKhau'] = password;
  final response = await http.post(
    Uri.parse('${Dimens.API_URL}NguoiDung/login'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: map,
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final data = jsonDecode(response.body);

    if (data['success'] == false) return null;
    return User.fromJson(data['data']);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load info');
  }
}

Future<bool> saveLogin(User user) async {
  await BaseSharedPreferences.setString('MaNguoiDung', user.user_id.toString());
  await BaseSharedPreferences.setString('HoTen', user.user_fullname ?? '');
  await BaseSharedPreferences.setString('Email', user.user_email ?? '');
  await BaseSharedPreferences.setString('token', user.user_token ?? '');
  return true;
}

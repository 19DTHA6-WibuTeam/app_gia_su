import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:gia_su_trung_tam_mobile/manager/shared_preferences.dart';
import 'package:gia_su_trung_tam_mobile/models/user.dart';
import 'package:gia_su_trung_tam_mobile/theme/dimens.dart';
import 'package:http/http.dart' as http;

Future<User?> getUser(Future<String> _userId, Future<String> _token) async {
  String userId = await _userId;
  String token = await _token;

  final response = await http.get(
      Uri.parse('${Dimens.API_URL}NguoiDung/$userId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      });

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['success'] == false) return null;
    return User.fromJson(data['data']);
  } else
    return null;
}

Future<bool> changePassword(
    Future<String> _token, String oldPass, String newPass) async {
  String token = await _token;
  var map = new Map<String, dynamic>();
  map['MatKhauCu'] = oldPass;
  map['MatKhauMoi'] = newPass;
  final response = await http.post(
    Uri.parse('${Dimens.API_URL}NguoiDung/DoiMatKhau'),
    headers: <String, String>{
      'Authorization': 'Bearer $token',
    },
    body: map,
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['success'];
  } else {
    return false;
  }
}

Future<bool?> changeInfo(
  Future<String> _userId,
  Future<String> _token,
  String name,
  String address,
  String birthday,
  String gender,
  String phoneNumber,
) async {
  String userId = await _userId;
  String token = await _token;

  var map = new Map<String, dynamic>();
  map['HoTen'] = name;
  map['NgaySinh'] = birthday;
  map['GioiTinh'] = gender;
  map['DiaChi'] = address;
  map['SDT'] = phoneNumber;

  final response = await http.patch(
    Uri.parse('${Dimens.API_URL}NguoiDung/$userId'),
    headers: <String, String>{
      'Authorization': 'Bearer $token',
    },
    body: map,
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['success'];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return null;
    // throw Exception('Failed to load info');
  }
}

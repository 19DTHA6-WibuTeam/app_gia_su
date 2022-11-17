import 'dart:convert';

import 'package:gia_su_trung_tam_mobile/models/session.dart';
import 'package:gia_su_trung_tam_mobile/theme/dimens.dart';
import 'package:http/http.dart' as http;

Future<List<Datum>?> getSession1List(Future<String> _token) async {
  String token = await _token;
  final response = await http.get(
      Uri.parse("${Dimens.API_URL}KhoaHoc?k=TinhTrang&v=1"),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      });

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['success'] == false) return null;
    List<Datum> sessionList = [];
    for (var item in data['data']) {
      sessionList.add(Datum.fromJson(item));
    }
    return sessionList;
  } else {
    throw Exception('Failed to load subject list');
  }
}

Future<bool> applySession(Future<String> _token, int sessionId) async {
  String token = await _token;
  final response = await http.post(
      Uri.parse("${Dimens.API_URL}KhoaHoc/GiangDay/$sessionId"),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      });

  if (response.statusCode == 200)
    return jsonDecode(response.body)['success'];
  else
    return false;
}

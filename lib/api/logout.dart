import 'package:gia_su_trung_tam_mobile/manager/shared_preferences.dart';

Future<bool> logout() async {
  await BaseSharedPreferences.remove('MaNguoiDung');
  await BaseSharedPreferences.remove('HoTen');
  await BaseSharedPreferences.remove('Email');
  await BaseSharedPreferences.remove('token');
  return true;
}

import 'dart:convert';

class User {
  final int user_id;
  final String? user_fullname;
  final String? user_email;
  final String? user_phone_number;
  final String? user_address;
  final String? user_token;
  final String? user_birthday;
  final int? user_gender;
  final int? is_tutor;
  final String? signIn_name;
  final String? created_day;
  final int? isDeleted;
  final String? avatar;

  User(
      this.user_id,
      this.user_fullname,
      this.user_email,
      this.user_phone_number,
      this.user_address,
      this.user_token,
      this.user_birthday,
      this.user_gender,
      this.is_tutor,
      this.signIn_name,
      this.created_day,
      this.isDeleted,
      this.avatar);
  User.fromJson(Map<String, dynamic> json)
      : user_id = json['MaNguoiDung'],
        user_fullname = json['HoTen'],
        user_email = json['Email'],
        user_phone_number = json['SDT'],
        user_address = json['DiaChi'],
        user_token = json['token'],
        user_birthday = json['NgaySinh'],
        user_gender = json['GioiTinh'],
        is_tutor = json['LaGiaSu'],
        signIn_name = json['TenDangNhap'],
        created_day = json['NgayTao'],
        isDeleted = json['KhongHoatDong'],
        avatar = json['Avatar'];
  Map<String, dynamic> toJson() => {
        'MaNguoiDung': user_id,
        'HoTen': user_fullname,
        'Email': user_email,
        'SDT': user_phone_number,
        'DiaChi': user_address,
        'token': user_token,
        'NgaySinh': user_birthday,
        'GioiTinh': user_gender,
        'LaGiaSu': is_tutor,
        'TenDangNhap': signIn_name,
        'NgayTao': created_day,
        'KhongHoatDong': isDeleted,
        'Avatar': avatar
      };
}

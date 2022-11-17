// To parse this JSON data, do
//
//     final session = sessionFromJson(jsonString);

import 'dart:convert';

Session sessionFromJson(String str) => Session.fromJson(json.decode(str));

String sessionToJson(Session data) => json.encode(data.toJson());

class Session {
  Session({
    this.success,
    this.data,
  });

  bool? success;
  List<Datum>? data;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.maKhoaHoc,
    this.maMonHoc,
    this.maHocSinh,
    this.maGiaSu,
    this.khoiLop,
    this.hoTen,
    this.diaChi,
    this.sdt,
    this.ngayDangKy,
    this.ngayBatDau,
    this.soTuan,
    this.soTien,
    this.tinhTrang,
    this.ghiChu,
    this.tenMonHoc,
    this.thoiKhoaBieu,
    this.thoiKhoaBieuTomTat,
  });

  int? maKhoaHoc;
  int? maMonHoc;
  int? maHocSinh;
  int? maGiaSu;
  int? khoiLop;
  String? hoTen;
  String? diaChi;
  String? sdt;
  DateTime? ngayDangKy;
  DateTime? ngayBatDau;
  int? soTuan;
  int? soTien;
  int? tinhTrang;
  String? ghiChu;
  String? tenMonHoc;
  List<ThoiKhoaBieu>? thoiKhoaBieu;
  ThoiKhoaBieuTomTat? thoiKhoaBieuTomTat;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        maKhoaHoc: json["MaKhoaHoc"],
        maMonHoc: json["MaMonHoc"],
        maHocSinh: json["MaHocSinh"],
        maGiaSu: json["MaGiaSu"] == null ? null : json["MaGiaSu"],
        khoiLop: json["KhoiLop"],
        hoTen: json["HoTen"],
        diaChi: json["DiaChi"],
        sdt: json["SDT"],
        ngayDangKy: DateTime.parse(json["NgayDangKy"]),
        ngayBatDau: json["NgayBatDau"] == null
            ? null
            : DateTime.parse(json["NgayBatDau"]),
        soTuan: json["SoTuan"],
        soTien: json["SoTien"],
        tinhTrang: json["TinhTrang"],
        ghiChu: json["GhiChu"] == null ? null : json["GhiChu"],
        tenMonHoc: json["TenMonHoc"],
        thoiKhoaBieu: List<ThoiKhoaBieu>.from(
            json["ThoiKhoaBieu"].map((x) => ThoiKhoaBieu.fromJson(x))),
        thoiKhoaBieuTomTat:
            ThoiKhoaBieuTomTat.fromJson(json["ThoiKhoaBieu_TomTat"]),
      );

  Map<String, dynamic> toJson() => {
        "MaKhoaHoc": maKhoaHoc,
        "MaMonHoc": maMonHoc,
        "MaHocSinh": maHocSinh,
        "MaGiaSu": maGiaSu == null ? null : maGiaSu,
        "KhoiLop": khoiLop,
        "HoTen": hoTen,
        "DiaChi": diaChi,
        "SDT": sdt,
        "NgayDangKy":
            "${ngayDangKy!.year.toString().padLeft(4, '0')}-${ngayDangKy!.month.toString().padLeft(2, '0')}-${ngayDangKy!.day.toString().padLeft(2, '0')}",
        "NgayBatDau": ngayBatDau == null
            ? null
            : "${ngayBatDau!.year.toString().padLeft(4, '0')}-${ngayBatDau!.month.toString().padLeft(2, '0')}-${ngayBatDau!.day.toString().padLeft(2, '0')}",
        "SoTuan": soTuan,
        "SoTien": soTien,
        "TinhTrang": tinhTrang,
        "GhiChu": ghiChu == null ? null : ghiChu,
        "TenMonHoc": tenMonHoc,
        "ThoiKhoaBieu":
            List<dynamic>.from(thoiKhoaBieu!.map((x) => x.toJson())),
        "ThoiKhoaBieu_TomTat": thoiKhoaBieuTomTat!.toJson(),
      };
}

class ThoiKhoaBieu {
  ThoiKhoaBieu({
    this.maCaHoc,
    this.gioBatDau,
    this.thoiGian,
    this.gioKetThuc,
    this.maThu,
    this.tenThu,
  });

  int? maCaHoc;
  String? gioBatDau;
  int? thoiGian;
  String? gioKetThuc;
  int? maThu;
  String? tenThu;

  factory ThoiKhoaBieu.fromJson(Map<String, dynamic> json) => ThoiKhoaBieu(
        maCaHoc: json["MaCaHoc"],
        gioBatDau: json["GioBatDau"],
        thoiGian: json["ThoiGian"],
        gioKetThuc: json["GioKetThuc"],
        maThu: json["MaThu"],
        tenThu: json["TenThu"],
      );

  Map<String, dynamic> toJson() => {
        "MaCaHoc": maCaHoc,
        "GioBatDau": gioBatDau,
        "ThoiGian": thoiGian,
        "GioKetThuc": gioKetThuc,
        "MaThu": maThu,
        "TenThu": tenThu,
      };
}

class ThoiKhoaBieuTomTat {
  ThoiKhoaBieuTomTat({
    this.maCaHoc,
    this.gioBatDau,
    this.gioKetThuc,
    this.maThu,
    this.tenThu,
  });

  int? maCaHoc;
  String? gioBatDau;
  String? gioKetThuc;
  String? maThu;
  String? tenThu;

  factory ThoiKhoaBieuTomTat.fromJson(Map<String, dynamic> json) =>
      ThoiKhoaBieuTomTat(
        maCaHoc: json["MaCaHoc"],
        gioBatDau: json["GioBatDau"],
        gioKetThuc: json["GioKetThuc"],
        maThu: json["MaThu"],
        tenThu: json["TenThu"],
      );

  Map<String, dynamic> toJson() => {
        "MaCaHoc": maCaHoc,
        "GioBatDau": gioBatDau,
        "GioKetThuc": gioKetThuc,
        "MaThu": maThu,
        "TenThu": tenThu,
      };
}

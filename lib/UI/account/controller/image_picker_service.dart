import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:gia_su_trung_tam_mobile/manager/shared_preferences.dart';
import 'package:gia_su_trung_tam_mobile/theme/dimens.dart';

class ImageService {
  static Future<dynamic> uploadFile(filePath) async {
    var authToken = await BaseSharedPreferences.getString('token');

    var userId = await BaseSharedPreferences.getString('MaNguoiDung');

    try {
      FormData formData = FormData.fromMap({
        "avatar": await MultipartFile.fromFile(filePath,
            contentType: MediaType.parse("image/jpeg")),
      });
      Response response = await Dio().patch(
          "${Dimens.API_URL}NguoiDung/$userId",
          data: formData,
          options: Options(headers: <String, String>{
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'multipart/form-data'
          }));
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response;
    } on UnsupportedError catch (e) {
      return e.message;
    } catch (e) {}
  }
}

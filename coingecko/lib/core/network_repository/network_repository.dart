import 'package:http/http.dart';

abstract class NetworkRepository {
  Future<Response> getRequest(
      {required String urlSuffix,
      Map<String, String>? headers,
      Map<String, String>? queries});
}

import 'package:http/http.dart';
import 'package:coingecko/core/constants/api_constants.dart';
import 'package:coingecko/core/network_repository/network_repository.dart';

class NetworkRepositoryImpl implements NetworkRepository {
  @override
  Future<Response> getRequest({
    required String urlSuffix,
    Map<String, String>? headers,
    Map<String, String>? queries,
  }) async {
    String apiEndpoint = ApiConstants.apiPrefix + urlSuffix;
    if (queries != null) {
      apiEndpoint += "?";
      queries.forEach((key, value) {
        apiEndpoint += "$key=$value&";
      });
    }
    final response = await get(
      Uri.parse(apiEndpoint),
      headers: headers ?? {"Accept": "application/json"},
    );
    return response;
  }
}

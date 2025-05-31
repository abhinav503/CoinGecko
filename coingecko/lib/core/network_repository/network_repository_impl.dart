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
    return handleResponse(response);
  }

  handleResponse(Response response) {
    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 429) {
      throw Exception("API rate limit exceeded");
    } else if (response.statusCode == 404) {
      throw Exception("Does not exist");
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else if (response.statusCode == 403) {
      throw Exception("Forbidden");
    } else {
      throw Exception("Something went wrong");
    }
  }
}

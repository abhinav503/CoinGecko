import 'dart:convert';
import 'package:coingecko/core/constants/string_constants.dart';
import 'package:coingecko/feature/home/data/models/dad_joke_model.dart';
import 'package:coingecko/core/models/no_param_model.dart';
import 'package:coingecko/core/network_repository/network_repository.dart';
import 'package:coingecko/feature/home/data/data_source/home_data_source_repository.dart';
import 'package:coingecko/feature/home/data/models/search_dad_joke_response_model.dart';
import 'package:http/http.dart';

class HomeDataSourceRepositoryImpl extends HomeDataSourceRepository {
  final NetworkRepository networkRepository;

  HomeDataSourceRepositoryImpl({required this.networkRepository});

  // @override
  // Future<DadJokeModel> getSingleJoke({required NoParamsModel params}) async {
  //   Response response = await networkRepository.getRequest(urlSuffix: "");
  //   return DadJokeModel.fromJson(jsonDecode(response.body));
  // }

  // @override
  // Future<SearchDadJokeReponseModel> getJokeSearchResults({
  //   required SearchDadJokeRequestModel params,
  // }) async {
  //   Response response = await networkRepository.getRequest(
  //     urlSuffix: search.toLowerCase(),
  //     queries: params.toJson(),
  //   );
  //   return SearchDadJokeReponseModel.fromJson(jsonDecode(response.body));
  // }
}

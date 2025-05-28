import 'package:dartz/dartz.dart';
import 'package:coingecko/core/base/base_exception_model.dart';
import 'package:coingecko/core/models/api_failure_model.dart';
import 'package:coingecko/feature/home/data/models/dad_joke_model.dart';
import 'package:coingecko/core/models/no_param_model.dart';
import 'package:coingecko/feature/home/data/data_source/home_data_source_repository.dart';
import 'package:coingecko/feature/home/data/models/search_dad_joke_response_model.dart';
import 'package:coingecko/feature/home/domain/repository/home_jokes_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSourceRepository homeDataSourceRepository;

  HomeRepositoryImpl({required this.homeDataSourceRepository});

  // @override
  // Future<Either<ApiFailureModel, DadJokeEntity>> getSingleJoke({
  //   required NoParamsModel params,
  // }) => baseMethodExceptions(() => getSingleJokeApi(params: params));

  // @override
  // Future<Either<ApiFailureModel, SearchDadJokeResultsEntity>>
  // getJokeSearchResults({required SearchDadJokeRequestModel params}) =>
  //     baseMethodExceptions(() => getJokeSearchResultsApi(params: params));

  // Future<Either<ApiFailureModel, DadJokeEntity>> getSingleJokeApi({
  //   required NoParamsModel params,
  // }) async {
  //   DadJokeEntity dadJokeEntity = DadJokeEntity();
  //   DadJokeModel dadJokeModel = await dadJokesDataSourceRepository
  //       .getSingleJoke(params: params);
  //   return Right(dadJokeEntity(dadJokeModel));
  // }

  // Future<Either<ApiFailureModel, SearchDadJokeResultsEntity>>
  // getJokeSearchResultsApi({required SearchDadJokeRequestModel params}) async {
  //   SearchDadJokeResultsEntity searchDadJokeResultsEntity =
  //       SearchDadJokeResultsEntity();
  //   SearchDadJokeReponseModel searchDadJokeReponseModel =
  //       await dadJokesDataSourceRepository.getJokeSearchResults(params: params);
  //   return Right(searchDadJokeResultsEntity(searchDadJokeReponseModel));
  // }
}

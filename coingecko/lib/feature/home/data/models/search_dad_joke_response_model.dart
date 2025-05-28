import 'package:coingecko/feature/home/data/models/dad_joke_model.dart';

class SearchDadJokeReponseModel {
  int? currentPage;
  int? limit;
  int? nextPage;
  int? previousPage;
  List<DadJokeModel>? results;
  String? searchTerm;
  int? status;
  int? totalJokes;
  int? totalPages;

  SearchDadJokeReponseModel({
    this.currentPage,
    this.limit,
    this.nextPage,
    this.previousPage,
    this.results,
    this.searchTerm,
    this.status,
    this.totalJokes,
    this.totalPages,
  });

  SearchDadJokeReponseModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    limit = json['limit'];
    nextPage = json['next_page'];
    previousPage = json['previous_page'];
    if (json['results'] != null) {
      results = <DadJokeModel>[];
      json['results'].forEach((v) {
        results!.add(DadJokeModel.fromJson(v));
      });
    }
    searchTerm = json['search_term'];
    status = json['status'];
    totalJokes = json['total_jokes'];
    totalPages = json['total_pages'];
  }
}

class DadJokeModel {
  String? id;
  String? joke;

  DadJokeModel.fromJson(Map mapData) {
    id = mapData["id"];
    joke = mapData["joke"];
  }
}

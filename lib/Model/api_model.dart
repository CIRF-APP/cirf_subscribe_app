// モデルリストの抽象クラス
abstract class APIModel {
  APIModel();

  void fromJson(dynamic json);

  dynamic toJson();
}

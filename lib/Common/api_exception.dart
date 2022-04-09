// APIのHttp通信失敗時(ステータスコードが200以外の時)に発生させる例外

class ApiException implements Exception {
  ApiException(this.httpStatus);

  final int httpStatus;
}
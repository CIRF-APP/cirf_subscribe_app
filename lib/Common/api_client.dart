import 'dart:convert';
import 'package:cirf_subscription_app/Common/api_exception.dart';
import 'package:cirf_subscription_app/Model/api_model.dart';
import 'package:http/http.dart' as http;

/* API接続関数(GET)
  * url：接続先APIのアドレス
  * lists：APIで取得したデータを格納するAPIModelListsを継承したモデル
  * status：ステータスを指定し、例外を発生させることができる(任意要素)
  */
Future<void> fetchApiResult(String url, APIModel model, [int? status]) async {
  final http.Response response = await http.get(Uri.parse(url));
  final String responseBody = utf8.decode(response.bodyBytes);

  status ??= response.statusCode;

  // ステータスが200の場合、データを格納
  if (status == 200) {
    model.fromJson(jsonDecode(responseBody));
  }
  // それ以外の場合ApiExceptionの引数にステータスコードを渡して例外を発生させる
  else {
    throw ApiException(status);
  }
}

/* API接続関数(POST・PUT)
  * url：接続先APIのアドレス
  * headers: ヘッダーデータを示したMap
  * postBody: APIに渡すデータを示したMap
  * lists：APIで取得したデータを格納するAPIModelListsを継承したモデル
  * isPut: postメソッドを使用 → 未指定 or false、putメソッドを使用 → true (任意要素)
  * status：ステータスを指定し、例外を発生させることができる(任意要素)
  */
Future<void> postApiData(String url, Map<String, String> headers, Map<String, dynamic> postBody, APIModel retModel, [bool isPut = false, int? status]) async {
  final Future<http.Response> Function(Uri uri, {Map<String, String>? headers, Object? body, Encoding? encoding}) httpFunc = isPut ? http.put : http.post;
  final http.Response response = await httpFunc(
    Uri.parse(url),
    headers: headers,
    // Content typeがjsonだった場合はbodyにjsonエンコードをした上でpost通信に渡す
    body: headers['Content-Type'] == 'application/json' ? jsonEncode(postBody) : postBody,
  );

  final String responseBody = utf8.decode(response.bodyBytes);
  status ??= response.statusCode;

  // ステータスが200と201の場合、データを格納
  if (status == 200 || status == 201) {
    retModel.fromJson(jsonDecode(responseBody));
  }
  // それ以外の場合ApiExceptionの引数にステータスコードを渡して例外を発生させる
  else {
    throw ApiException(status);
  }
}

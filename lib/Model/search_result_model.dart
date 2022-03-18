import 'package:cirf_subscription_app/Model/music_model.dart';

class SearchResultModel {
  SearchResultModel({
    required this.searchWord,
    required this.resultList,
  });
  final String searchWord;
  final List<MusicModel> resultList;
}
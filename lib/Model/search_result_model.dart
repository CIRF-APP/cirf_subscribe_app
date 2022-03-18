import 'package:cirf_subscription_app/Model/music_model.dart';

class SearchResultModel {
  SearchResultModel({
    required this.searchWord,
    required this.resultList,
  });

  factory SearchResultModel.emptyModel() {
    return SearchResultModel(
      searchWord: '',
      resultList: <MusicModel>[],
    );
  }

  final String searchWord;
  final List<MusicModel> resultList;
}

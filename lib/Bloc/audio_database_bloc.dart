import 'package:cirf_subscription_app/Common/global_instance.dart';
import 'package:cirf_subscription_app/Model/search_result_model.dart';
import 'package:rxdart/rxdart.dart';

class AudioDatabaseBloc {
  AudioDatabaseBloc() {
    _searchWordController.listen((String target) {
      _searchResultController.sink.add(SearchResultModel(
        searchWord: target,
        resultList: audioDatabaseService.searchMusic(target),
      ));
    });

    _pageController.listen((_) {
      _searchResultController.sink.add(SearchResultModel.emptyModel());
    });
  }

  // 入力(音楽カードタップ時)
  final BehaviorSubject<String> _playController = BehaviorSubject<String>();

  Sink<String> get playButton => _playController.sink;

  // 入力(検索ワード入力時)
  final BehaviorSubject<String> _searchWordController = BehaviorSubject<String>();

  Sink<String> get searchMusic => _searchWordController.sink;

  // 入力(ページ遷移時)
  final BehaviorSubject<void> _pageController = BehaviorSubject<void>();

  Sink<void> get pageTransition => _pageController.sink;

  // 出力(検索結果)
  final BehaviorSubject<SearchResultModel> _searchResultController = BehaviorSubject<SearchResultModel>();

  Stream<SearchResultModel> get searchResult => _searchResultController.stream;


  Future<void> fetchAudioData() async {
    await audioDatabaseService.loadAudioData();
  }

  void dispose() {
    _playController.close();
    _searchWordController.close();
    _searchResultController.close();

    audioDatabaseService.close();
  }
}

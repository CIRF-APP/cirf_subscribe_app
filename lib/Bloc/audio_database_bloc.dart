import 'package:cirf_subscription_app/Model/search_result_model.dart';
import 'package:cirf_subscription_app/Service/audio_database_service.dart';
import 'package:rxdart/rxdart.dart';

class AudioDatabaseBloc {
  AudioDatabaseBloc() {
    searchWordController.listen((String target) {
      searchResultController.sink.add(SearchResultModel(
        searchWord: target,
        resultList: service.searchMusic(target),
      ));
    });
  }

  // 入力(音楽カードタップ時)
  final BehaviorSubject<String> playController = BehaviorSubject<String>();

  Sink<String> get playButton => playController.sink;

  // 入力(検索ワード入力時)
  final BehaviorSubject<String> searchWordController = BehaviorSubject<String>();

  Sink<String> get searchMusic => searchWordController.sink;

  // 出力(検索結果)
  final BehaviorSubject<SearchResultModel> searchResultController = BehaviorSubject<SearchResultModel>();

  Stream<SearchResultModel> get searchResult => searchResultController.stream;

  final AudioDatabaseService service = AudioDatabaseService();

  Future<void> fetchAudioData() async {
    await service.loadAudioData();
  }

  Future<void> playAudio(String target) async {
    await service.playOneFile(target);
  }

  void dispose() {
    playController.close();
    searchWordController.close();
    searchResultController.close();
    service.close();
  }
}

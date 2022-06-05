import 'package:cirf_subscription_app/Bloc/api_rebuild_bloc.dart';
import 'package:cirf_subscription_app/Common/api_exception.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:cirf_subscription_app/Model/search_result_model.dart';
import 'package:cirf_subscription_app/Service/audio_database_service.dart';
import 'package:rxdart/rxdart.dart';

class AudioDatabaseBloc extends APIRebuildBloc {
  AudioDatabaseBloc() {
    _searchWordController.listen((String target) {
      _searchResultController.sink.add(SearchResultModel(
        searchWord: target,
        resultList: service.searchMusic(target),
      ));
    });

    _pageController.listen((_) {
      _searchResultController.sink.add(SearchResultModel.emptyModel());
    });

    listenRebuild();
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

  // 出力(全音楽)
  final BehaviorSubject<List<MusicModel>> _allMusicController = BehaviorSubject<List<MusicModel>>();

  Stream<List<MusicModel>> get allMusic => _allMusicController.stream;

  final AudioDatabaseService service = AudioDatabaseService();

  Future<int> fetchAudioData() async {
    int httpStatus = 200;
    try {
      await service.loadAudioData();
      _allMusicController.sink.add(service.getAllMusic());
    } on ApiException catch(e) {
      httpStatus = e.httpStatus;
    }
    return httpStatus;
  }

  void dispose() {
    _playController.close();
    _searchWordController.close();
    _searchResultController.close();
  }
}

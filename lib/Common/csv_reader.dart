import 'dart:io';
import 'dart:async';
import 'dart:convert';

void ReadCSVFile() {
  final File file = File('assets/audio_data.csv');

  final Stream<List<int>> fread = file.openRead();

  fread.transform(utf8.decoder).transform(const LineSplitter()).listen((String line) {
    final List<String> rows = line.split(',');

    // 1～3列目のデータを取得
    String row1 = rows[0];
    String row2 = rows[1];
    String row3 = rows[2];

    print('列1：$row1');
    print('列2：$row2');
    print('列3：$row3');
  }, onDone: () {
    print('File is now closed.');
  }, onError: (e) {
    print(e.toString());
  });
}


class SeekBarModel {
  SeekBarModel(Duration duration){
    hour = duration.inHours;
    minute = duration.inMinutes;
    second = duration.inSeconds;
    totalSecond = hour * 3600 + minute * 60 + second;
  }

  late int hour;
  late int minute;
  late int second;
  late int totalSecond;
}
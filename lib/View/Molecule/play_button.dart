import 'package:cigarandcoffee/Bloc/play_button_bloc.dart';
import 'package:cigarandcoffee/Common/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayButton extends StatelessWidget {
  PlayButton({required this.musicTitle});

  bool _isPlay = true;
  final String musicTitle;

  @override
  Widget build(BuildContext context) {
    final PlayButtonBloc bloc = Provider.of<PlayButtonBloc>(context);
    final AudioManager audioManager = Provider.of<AudioManager>(context);

    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
      ),
      onPressed: () async {
        _isPlay = _isPlay ? false : true;
        bloc.actionController.sink.add(_isPlay);
        await audioManager.playOneFile(musicTitle);
      },
      child: StreamBuilder<bool>(
        initialData: true,
        stream: bloc.writeController.stream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return CustomPaint(
            size: Size(50, 50),
            painter: snapshot.data! ? _PlayMark() : _PauseMark(),
          );
        },
      ),
    );
  }
}

class _PauseMark extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    paint.color = Colors.blue;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, paint);

    paint.color = Colors.purple;
    canvas.drawRect(Rect.fromLTWH(2 * size.width / 7, size.height / 4, 8, 25), paint);

    paint.color = Colors.purple;
    canvas.drawRect(Rect.fromLTWH(4 * size.width / 7, size.height / 4, 8, 25), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _PlayMark extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    paint.color = Colors.blue;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, paint);

    paint.color = Colors.purple;
    Path path = Path();
    path.moveTo(size.width - 10, size.height / 2);
    path.lineTo(15, size.height / 5);
    path.lineTo(15, 4 * size.height / 5);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

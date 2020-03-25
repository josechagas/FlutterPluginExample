import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class IndicatorSeekBar extends StatefulWidget {
  static final viewType = 'learning_flutter_plugin/indicator_seek_bar';

  IndicatorSeekBar(
      {Key key,
      this.min = 0,
      this.max = 100,
      this.progress = 0,
      this.tickCount = 1})
      : super(key: key);

  final double min;
  final double max;
  final double progress;
  final int tickCount;

  @override
  _IndicatorSeekBarState createState() => _IndicatorSeekBarState();
}

class _IndicatorSeekBarState extends State<IndicatorSeekBar> {
  @override
  Widget build(BuildContext context) {
    final args = {
      "min": widget.min,
      "max": widget.max,
      "progress": widget.progress,
      "tickCount": widget.tickCount
    };

    try {
      if (Platform.isAndroid) {
        return AndroidView(
          viewType: IndicatorSeekBar.viewType,
          creationParams: args,
          creationParamsCodec: StandardMessageCodec(),
        );
      } else if (Platform.isIOS) {
        return UiKitView(
          viewType: IndicatorSeekBar.viewType,
          creationParams: args,
          creationParamsCodec: StandardMessageCodec(),
        );
      }
    } catch (e) {
      print(e);
    }

    return Text(
        '$defaultTargetPlatform is not yet supported by the text_view plugin');
  }
}

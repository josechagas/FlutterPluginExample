import 'dart:async';

import 'package:flutter/services.dart';

class PlatformInfo {
  static const ChannelName = 'platform_info';

  static const MethodChannel _channel =
      const MethodChannel(ChannelName);

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

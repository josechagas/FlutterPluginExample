import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learningflutterplugin/platform_info.dart';

void main() {
  const MethodChannel platformInfoChannel = MethodChannel(PlatformInfo.ChannelName);

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    platformInfoChannel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    platformInfoChannel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await PlatformInfo.platformVersion, '42');
  });
}

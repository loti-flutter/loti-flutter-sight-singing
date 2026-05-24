import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loti_flutter_sight_singing_plugin/loti_flutter_sight_singing_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelLotiFlutterSightSingingPlugin platform = MethodChannelLotiFlutterSightSingingPlugin();
  const MethodChannel channel = MethodChannel('loti_flutter_sight_singing_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          return '42';
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}

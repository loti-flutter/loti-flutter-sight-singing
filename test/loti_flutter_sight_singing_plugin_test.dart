import 'package:flutter_test/flutter_test.dart';
import 'package:loti_flutter_sight_singing_plugin/loti_flutter_sight_singing_plugin.dart';
import 'package:loti_flutter_sight_singing_plugin/loti_flutter_sight_singing_plugin_platform_interface.dart';
import 'package:loti_flutter_sight_singing_plugin/loti_flutter_sight_singing_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLotiFlutterSightSingingPluginPlatform
    with MockPlatformInterfaceMixin
    implements LotiFlutterSightSingingPluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('MockPlatform');
}

void main() {
  test('default platform is MethodChannel', () {
    expect(
      LotiFlutterSightSingingPluginPlatform.instance,
      isA<MethodChannelLotiFlutterSightSingingPlugin>(),
    );
  });

  test('getStatus returns preview string', () async {
    final fakePlatform = MockLotiFlutterSightSingingPluginPlatform();
    LotiFlutterSightSingingPluginPlatform.instance = fakePlatform;
    final plugin = LotiSightSingingPlugin();
    final status = await plugin.getStatus();
    expect(status, contains('preview'));
    expect(status, contains('MockPlatform'));
  });
}

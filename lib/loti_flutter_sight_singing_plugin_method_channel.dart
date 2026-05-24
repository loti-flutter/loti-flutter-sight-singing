import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'loti_flutter_sight_singing_plugin_platform_interface.dart';

/// An implementation of [LotiFlutterSightSingingPluginPlatform] that uses method channels.
class MethodChannelLotiFlutterSightSingingPlugin extends LotiFlutterSightSingingPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('loti_flutter_sight_singing_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}

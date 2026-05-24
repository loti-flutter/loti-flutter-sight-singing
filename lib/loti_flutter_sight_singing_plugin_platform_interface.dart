import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'loti_flutter_sight_singing_plugin_method_channel.dart';

abstract class LotiFlutterSightSingingPluginPlatform extends PlatformInterface {
  /// Constructs a LotiFlutterSightSingingPluginPlatform.
  LotiFlutterSightSingingPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static LotiFlutterSightSingingPluginPlatform _instance = MethodChannelLotiFlutterSightSingingPlugin();

  /// The default instance of [LotiFlutterSightSingingPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelLotiFlutterSightSingingPlugin].
  static LotiFlutterSightSingingPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LotiFlutterSightSingingPluginPlatform] when
  /// they register themselves.
  static set instance(LotiFlutterSightSingingPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

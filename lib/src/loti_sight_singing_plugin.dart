import '../loti_flutter_sight_singing_plugin_platform_interface.dart';

/// 插件对外入口（占位实现）。
///
/// 购买授权后获取完整 SDK，接入方式见 [README](https://github.com/loti-edu/loti-flutter-sight-singing-plugin)。
class LotiSightSingingPlugin {
  LotiSightSingingPlugin();

  /// 当前插件包版本号。
  static const String packageVersion = '0.0.1-preview';

  /// 插件运行状态描述（占位）。
  Future<String> getStatus() async {
    final platform = await LotiFlutterSightSingingPluginPlatform.instance
        .getPlatformVersion();
    return 'Loti Sight Singing Plugin $packageVersion (preview) · $platform';
  }
}

/// 向后兼容的别名。
typedef LotiFlutterSightSingingPlugin = LotiSightSingingPlugin;

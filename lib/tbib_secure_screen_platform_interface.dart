import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tbib_secure_screen_method_channel.dart';

abstract class TbibSecureScreenPlatform extends PlatformInterface {
  static final Object _token = Object();

  static TbibSecureScreenPlatform _instance = MethodChannelTbibSecureScreen();

  /// The default instance of [TbibSecureScreenPlatform] to use.
  ///
  /// Defaults to [MethodChannelTbibSecureScreen].
  static TbibSecureScreenPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TbibSecureScreenPlatform] when
  /// they register themselves.
  static set instance(TbibSecureScreenPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Constructs a TbibSecureScreenPlatform.
  TbibSecureScreenPlatform() : super(token: _token);

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> setSecureScreen() {
    throw UnimplementedError('setSecureScreen() has not been implemented.');
  }

  Future<void> setUnsecureScreen() {
    throw UnimplementedError('setUnsecureScreen() has not been implemented.');
  }
}

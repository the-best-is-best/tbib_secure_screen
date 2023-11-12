import 'package:flutter/services.dart';

import 'tbib_secure_screen_platform_interface.dart';

/// An implementation of [TbibSecureScreenPlatform] that uses method channels.
class MethodChannelTbibSecureScreen extends TbibSecureScreenPlatform {
  /// The method channel used to interact with the native platform.
  final methodChannel = const MethodChannel('tbib_secure_screen');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> setSecureScreen() async {
    await methodChannel.invokeMethod<void>('setSecureScreen');
  }

  @override
  Future<void> setUnsecureScreen() async {
    await methodChannel.invokeMethod<void>('setUnSecureScreen');
  }
}

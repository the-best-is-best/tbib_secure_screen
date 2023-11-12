import 'tbib_secure_screen_platform_interface.dart';

class TBIBSecureScreen {
  Future<String?> getPlatformVersion() {
    return TbibSecureScreenPlatform.instance.getPlatformVersion();
  }

  Future<void> setSecureScreen() {
    return TbibSecureScreenPlatform.instance.setSecureScreen();
  }

  Future<void> setUnsecureScreen() {
    return TbibSecureScreenPlatform.instance.setUnsecureScreen();
  }
}

import 'package:shared_preferences/shared_preferences.dart';

abstract class IConfigurationService {
  Future<void> setMnemonic(String? value);
  Future<void> setupDone(bool value);
  Future<void> setPrivateKey(String? value);
  // Future<void> setLogin(bool value);
  Future<void> setUserName(String? username);
  String? getMnemonic();
  String? getPrivateKey();
  String? getUserName();
  bool didSetupWallet();
  bool didLogin();
}

class ConfigurationService implements IConfigurationService {
  const ConfigurationService(this._preferences);

  final SharedPreferences _preferences;

  @override
  Future<void> setMnemonic(String? value) async {
    await _preferences.setString('mnemonic', value ?? '');
  }

  @override
  Future<void> setPrivateKey(String? value) async {
    await _preferences.setString('privateKey', value ?? '');
  }

  @override
  Future<void> setUserName(String? username) async {
    // TODO: implement setLogin
    await _preferences.setString('UserName', username ?? '');
  }

  @override
  Future<void> setupDone(bool value) async {
    await _preferences.setBool('didSetupWallet', value);
  }

  // @override
  // Future<void> setLogin(bool value) async {
  //   // TODO: implement setLogin
  //   await _preferences.setBool('didLogin', value);
  // }

  // gets
  @override
  String? getMnemonic() {
    return _preferences.getString('mnemonic');
  }

  @override
  String? getPrivateKey() {
    return _preferences.getString('privateKey');
  }

  @override
  String? getUserName() {
    // TODO: implement didLogin
    return _preferences.getString('UserName');
  }

  @override
  bool didSetupWallet() {
    return _preferences.getBool('didSetupWallet') ?? false;
  }

  @override
  bool didLogin() {
    // TODO: implement didLogin
    return _preferences.getBool('didLogin') ?? false;
  }

}

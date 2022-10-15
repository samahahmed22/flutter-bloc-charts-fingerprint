import 'package:local_auth/local_auth.dart';

abstract class BiometricsHelper {
  Future<bool> isBiometricsEnabled();
  Future<bool> authenticate();
}

class BiometricsHelperImpl implements BiometricsHelper {
  final LocalAuthentication _localAuthentication;
  BiometricsHelperImpl(this._localAuthentication);

  @override
  Future<bool> isBiometricsEnabled() async {
    final List<BiometricType> availableBiometrics =
        await _localAuthentication.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> authenticate() async {
    final bool didAuthenticate = await _localAuthentication.authenticate(
        localizedReason: 'Please authenticate to proceed',
        options: AuthenticationOptions(biometricOnly: true));

    return didAuthenticate;
  }
}

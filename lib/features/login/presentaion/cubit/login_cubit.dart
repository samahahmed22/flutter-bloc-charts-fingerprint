import 'package:charts/core/helpers/biometrics_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  BiometricsHelper _biometricsHelper;

  LoginCubit(this._biometricsHelper) : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  void isBiometricsEnabled() async {
    if (await _biometricsHelper.isBiometricsEnabled() == true) {
      emit(BiometricsIsEnabled());
    }else{
      emit(NoBiometricFound());
    }
  }

  void isAuthenticated() async {
    if (await _biometricsHelper.authenticate() == true) {
      emit(Authenticated());
    }
  }
}

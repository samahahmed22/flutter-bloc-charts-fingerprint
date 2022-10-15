part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class BiometricsIsEnabled extends LoginState{}

class NoBiometricFound extends LoginState{}

class Authenticated extends LoginState{}


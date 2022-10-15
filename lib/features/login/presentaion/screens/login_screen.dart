import 'package:charts/features/login/presentaion/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/login_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushNamed(Routes.homeScreenRoute);
          }
        },
        builder: (context, state) {
          if (state is BiometricsIsEnabled) {
            return Center(
              child: LoginButton(
                  text: 'Authenticate',
                  onPress: () {
                    LoginCubit.get(context).isAuthenticated();
                  }),
            );
          } else if (state is NoBiometricFound) {
            return Center(
              child: Text(
                  'finger print or face id is required please enable one of them then retry'),
            );
          }
          return Container();
        },
      ),
    );
  }
}

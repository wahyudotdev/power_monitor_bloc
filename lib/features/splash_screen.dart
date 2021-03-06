import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/auth/presentation/bloc/auth_bloc.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  void sharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final String? notification = prefs.getString('notification');
    print(notification);
  }

  @override
  void initState() {
    super.initState();
    sharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          BlocProvider.of<AuthBloc>(context).add(GetUserEvent());
        }
        if (state is UserAuthenticated) {
          SharedPreferences.getInstance().then((value) {
            print(value.getString('notification'));
            if (value.getString('notification') != null) {
              Future.delayed(
                  Duration(seconds: 2),
                  () => Navigator.of(context)
                      .pushNamedAndRemoveUntil('/detail', (route) => false));
            } else {
              Future.delayed(
                  Duration(seconds: 2),
                  () => Navigator.of(context)
                      .pushNamedAndRemoveUntil('/menu', (route) => false));
            }
          });
        }
        if (state is AuthenticationFail) {
          Future.delayed(
              Duration(seconds: 2),
              () => Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false));
        }
        // message(context);
        View().init(context);
        return Scaffold(
          backgroundColor: AppColors.primary,
          body: Center(
            child: SvgPicture.asset('assets/logo.svg'),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:power_monitor_app/core/auth/presentation/bloc/auth_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/view.dart';
import '../../../../injection_container.dart';

class LoginPage extends StatelessWidget {
  final _authBloc = sl<AuthBloc>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  Widget _title() {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            color: AppColors.primary,
            padding: EdgeInsets.all(View.x * 10),
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset('assets/logo.svg'),
          )
        ],
      ),
    );
  }

  Widget _loginTitle() {
    return Container(
      margin: EdgeInsets.only(left: View.x * 5, top: View.y * 3),
      width: double.infinity,
      alignment: Alignment.topLeft,
      child: Text(
        'Masuk',
        style: TextStyle(
          color: Colors.black,
          fontSize: View.x * 5,
        ),
      ),
    );
  }

  Widget _emailField() {
    return Container(
      margin: EdgeInsets.only(
        left: View.x * 5,
        top: View.y * 3,
        right: View.x * 5,
      ),
      width: double.infinity,
      alignment: Alignment.topLeft,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Email',
          labelText: 'Email',
        ),
        controller: _email,
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      margin: EdgeInsets.only(
        left: View.x * 5,
        top: View.y * 3,
        right: View.x * 5,
      ),
      width: double.infinity,
      alignment: Alignment.topLeft,
      child: TextField(
        decoration:
            InputDecoration(hintText: 'Password', labelText: 'Password'),
        obscureText: true,
        controller: _password,
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          EasyLoading.show();
        }
        if (state is UserAuthenticated) {
          EasyLoading.dismiss();
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/menu', (route) => false);
        }
        if (state is AuthenticationFail) {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: View.x * 10,
              left: View.x * 5,
              right: View.x * 5,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.button,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(
                View.x * 2,
              ),
            ),
            child: TextButton(
              onPressed: () => _authBloc.add(
                SignInEvent(
                  email: _email.text,
                  password: _password.text,
                ),
              ),
              child: Text('MASUK'),
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.padded,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _registerButton(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: View.x * 2,
        left: View.x * 5,
        right: View.x * 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.button,
          width: 1,
        ),
        color: AppColors.button,
        borderRadius: BorderRadius.circular(
          View.x * 2,
        ),
      ),
      child: TextButton(
        onPressed: () => Navigator.of(context).pushNamed('/register'),
        child: Text(
          'DAFTAR',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: TextButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.padded,
        ),
      ),
    );
  }

  Widget _forgotPassword() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        left: View.x * 5,
        top: View.x * 5,
        bottom: View.y * 10,
      ),
      child: Text('Lupa password?'),
    );
  }

  Widget _form(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: View.y * 20,
            color: AppColors.primary,
            child: SvgPicture.asset(
              'assets/form_decoration.svg',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: View.y * 10),
            width: double.infinity,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(View.x * 5),
                  topRight: Radius.circular(View.x * 5),
                ),
              ),
              child: Column(
                children: [
                  _loginTitle(),
                  _emailField(),
                  _passwordField(),
                  _loginButton(context),
                  _registerButton(context),
                  _forgotPassword(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    View().init(context);
    return BlocProvider(
      create: (context) => _authBloc,
      child: Container(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: [
                _title(),
                _form(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

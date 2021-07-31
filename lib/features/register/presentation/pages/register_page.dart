import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:power_monitor_app/core/utils/app_colors.dart';
import 'package:power_monitor_app/core/utils/view.dart';

class RegisterPage extends StatelessWidget {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  Widget _title() {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            color: AppColors.primary,
            padding: EdgeInsets.all(View.x * 5),
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
        'Daftar',
        style: TextStyle(
          color: Colors.black,
          fontSize: View.x * 5,
        ),
      ),
    );
  }

  Widget _nameField() {
    return Container(
      margin: EdgeInsets.only(
        left: View.x * 5,
        top: View.y * 1,
        right: View.x * 5,
      ),
      width: double.infinity,
      alignment: Alignment.topLeft,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Nama lengkap',
          labelText: 'Nama lengkap',
        ),
        controller: _name,
      ),
    );
  }

  Widget _emailField() {
    return Container(
      margin: EdgeInsets.only(
        left: View.x * 5,
        top: View.y * 1,
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
        top: View.y * 1,
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

  Widget _confirmPasswordField() {
    return Container(
      margin: EdgeInsets.only(
        left: View.x * 5,
        top: View.y * 1,
        right: View.x * 5,
      ),
      width: double.infinity,
      alignment: Alignment.topLeft,
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Konfirmasi password', labelText: 'Konfirmasi password'),
        obscureText: true,
        controller: _confirmPassword,
      ),
    );
  }

  Widget _registerButton(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: View.x * 5,
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
        onPressed: () => print(_email.text),
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

  Widget _loginButton(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        left: View.x * 5,
        top: View.x * 5,
        bottom: View.y * 10,
      ),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: 'Sudah punya akun?',
          ),
          TextSpan(
              text: ' Login',
              style: TextStyle(
                color: AppColors.secondary,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap =
                    () => Navigator.of(context).pushReplacementNamed('/login'))
        ]),
      ),
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
                  _nameField(),
                  _emailField(),
                  _passwordField(),
                  _confirmPasswordField(),
                  _registerButton(context),
                  _loginButton(context),
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
    return Container(
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
    );
  }
}

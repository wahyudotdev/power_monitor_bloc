import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/view.dart';
import '../bloc/form_validation/form_validation_bloc.dart';
import '../bloc/register/register_bloc.dart';
import '../../../../injection_container.dart';

class RegisterPage extends StatelessWidget {
  final _registerBloc = sl<RegisterBloc>();
  final _formValidationBloc = sl<FormValidationBloc>();
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
    return BlocBuilder<FormValidationBloc, FormValidationState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(
            left: View.x * 5,
            top: View.y * 1,
            right: View.x * 5,
          ),
          width: double.infinity,
          alignment: Alignment.topLeft,
          child: Focus(
            onFocusChange: (_) => _formValidationBloc.add(ValidateForm()),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Nama lengkap',
                labelText: state is NameValidationState ? state.message : null,
              ),
              controller: _name,
              onChanged: (name) =>
                  _formValidationBloc.add(ValidateName(name: name)),
            ),
          ),
        );
      },
    );
  }

  Widget _emailField() {
    return BlocBuilder<FormValidationBloc, FormValidationState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(
            left: View.x * 5,
            top: View.y * 1,
            right: View.x * 5,
          ),
          width: double.infinity,
          alignment: Alignment.topLeft,
          child: Focus(
            onFocusChange: (_) => _formValidationBloc.add(ValidateForm()),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Email',
                labelText: state is EmailValidationState ? state.message : null,
              ),
              controller: _email,
              onChanged: (email) =>
                  _formValidationBloc.add(ValidateEmail(email: email)),
            ),
          ),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<FormValidationBloc, FormValidationState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(
            left: View.x * 5,
            top: View.y * 1,
            right: View.x * 5,
          ),
          width: double.infinity,
          alignment: Alignment.topLeft,
          child: Focus(
            onFocusChange: (_) => _formValidationBloc.add(ValidateForm()),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Password',
                  labelText:
                      state is PasswordValidationState ? state.message : null),
              obscureText: true,
              controller: _password,
              onChanged: (pass) => _formValidationBloc.add(
                ValidatePassword(
                  password: pass,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _confirmPasswordField() {
    return BlocBuilder<FormValidationBloc, FormValidationState>(
      builder: (context, state) {
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
                hintText: 'Konfirmasi password',
                labelText:
                    state is PasswordValidationState ? state.message : null),
            obscureText: true,
            controller: _confirmPassword,
            onChanged: (pass) => _formValidationBloc.add(
              ValidateConfirmPassword(
                  password: _password.text, confirmPassword: pass),
            ),
            onSubmitted: (_) => _formValidationBloc.add(ValidateForm()),
          ),
        );
      },
    );
  }

  void _register() {
    _registerBloc.add(
      RegisterUserEvent(
        displayName: _name.text,
        password: _password.text,
        confirmPassword: _confirmPassword.text,
        email: _email.text,
      ),
    );
  }

  Widget _registerButton(BuildContext context) {
    return BlocBuilder<FormValidationBloc, FormValidationState>(
      builder: (context, state) {
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
            color: state is SubmitState
                ? state.isReady
                    ? AppColors.button
                    : Colors.grey
                : Colors.grey,
            borderRadius: BorderRadius.circular(
              View.x * 2,
            ),
          ),
          child: TextButton(
            onPressed: () => state is SubmitState
                ? state.isReady
                    ? _register()
                    : print('belum ready')
                : null,
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
      },
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
              style: TextStyle(color: AppColors.text)),
          TextSpan(
            text: ' Login',
            style: TextStyle(
              color: AppColors.secondary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap =
                  () => Navigator.of(context).pushReplacementNamed('/login'),
          )
        ]),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          EasyLoading.show();
        }
        if (state is RegisterSuccess) {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.of(context).pop();
        }
        if (state is RegisterFail) {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: BlocProvider(
        create: (context) => _formValidationBloc,
        child: SliverToBoxAdapter(
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
                    borderRadius: BorderRadius.circular(View.x * 5),
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    View().init(context);
    return BlocProvider<RegisterBloc>(
      create: (context) => _registerBloc,
      child: Container(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.primary,
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

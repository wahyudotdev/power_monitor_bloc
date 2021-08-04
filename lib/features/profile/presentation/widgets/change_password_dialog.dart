import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_monitor_app/core/auth/presentation/bloc/auth_bloc.dart';
import 'package:power_monitor_app/core/utils/app_colors.dart';
import 'package:power_monitor_app/core/utils/view.dart';

class ChangePasswordDialog extends StatelessWidget {
  Widget _changePasswordDialog(BuildContext context) {
    final password = TextEditingController();
    final confirmPassword = TextEditingController();
    return AlertDialog(
      content: Container(
        width: double.infinity,
        height: View.y * 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(View.x * 10),
        ),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Masukkan password',
              ),
              controller: password,
              obscureText: true,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Konfirmasi password',
              ),
              controller: confirmPassword,
              obscureText: true,
            ),
            Container(
              margin: EdgeInsets.only(top: View.y * 3),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(View.x * 2),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.button,
                        borderRadius: BorderRadius.circular(View.x * 2),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (password.text == confirmPassword.text) {
                            BlocProvider.of<AuthBloc>(context).add(
                                ChangePasswordEvent(password: password.text));
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Password harus sama')));
                          }
                        },
                        child: Text(
                          'Simpan',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(View.x * 2),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(View.x * 2),
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Batal',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _changePasswordDialog(context);
  }
}

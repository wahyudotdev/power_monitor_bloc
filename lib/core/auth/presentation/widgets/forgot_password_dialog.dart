import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/view.dart';

class ForgotPasswordDialog extends StatelessWidget {
  const ForgotPasswordDialog({Key? key}) : super(key: key);
  Widget _setMaxDialog(BuildContext context) {
    final email = TextEditingController();
    return AlertDialog(
      content: Container(
        width: double.infinity,
        height: View.y * 23,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Masukkan email',
              ),
              controller: email,
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
                          BlocProvider.of<AuthBloc>(context)
                              .add(ForgotPasswordEvent(email: email.text));
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'OK',
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
    return _setMaxDialog(context);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/view.dart';
import '../bloc/realtime_bloc.dart';
import '../../../../injection_container.dart';

class SetMaxDialog extends StatelessWidget {
  final String path;

  const SetMaxDialog({Key? key, required this.path}) : super(key: key);
  Widget _setMaxDialog(BuildContext context) {
    final value = TextEditingController();
    return AlertDialog(
      content: Container(
        width: double.infinity,
        height: View.y * 23,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Masukkan nilai $path max',
              ),
              keyboardType: TextInputType.number,
              controller: value,
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
                          print(value.text);
                          sl<RealtimeBloc>().add(SetMaxValueEvent(
                              path: path, value: double.parse(value.text)));
                          Navigator.of(context).pop();
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
    return _setMaxDialog(context);
  }
}

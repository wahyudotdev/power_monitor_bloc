import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/view.dart';

class HistoryItem extends StatelessWidget {
  final VoidCallback? action;

  const HistoryItem({Key? key, this.action}) : super(key: key);

  void pr() {
    print('tes');
  }

  Widget _historyItem(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        margin: EdgeInsets.only(
          left: View.x * 5,
          right: View.x * 5,
          top: View.x * 5,
        ),
        height: View.y * 15,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.notification,
            borderRadius: BorderRadius.circular(
              View.x * 2,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 3,
                offset: Offset(3, 3),
              ),
            ]),
        child: Row(
          children: [
            _dateTime(),
            _dataBox(),
          ],
        ),
      ),
    );
  }

  Widget _dateTime() {
    return Expanded(
      flex: 1,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: View.x * 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '12.48',
              style: TextStyle(
                fontSize: View.x * 7,
                color: Colors.white,
              ),
            ),
            Text(
              '31 Jul 2021',
              style: TextStyle(
                fontSize: View.x * 3.5,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dataBoxItem({required String notation, required String value}) {
    return Expanded(
      flex: 1,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: View.x * 9,
              height: View.x * 9,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withOpacity(0.5),
              ),
              child: Center(
                child: Text(
                  notation,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: View.x * 1,
              ),
              child: Text(
                value,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _dataBox() {
    return Expanded(
      flex: 3,
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            _dataBoxItem(notation: 'V', value: '220'),
            _dataBoxItem(notation: 'I', value: '0.5'),
            _dataBoxItem(notation: 'P', value: '110'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _historyItem(context);
  }
}

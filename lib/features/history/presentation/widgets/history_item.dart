import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/history.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/view.dart';
import 'package:intl/intl.dart';

class HistoryItem extends StatelessWidget {
  final VoidCallback? action;
  final History history;
  const HistoryItem({Key? key, this.action, required this.history})
      : super(key: key);

  String formattedDate(DateTime dateTime) {
    final f = DateFormat('dd MMM yyyy');
    return f.format(dateTime);
  }

  String formattedTime(DateTime time) {
    final f = DateFormat('hh:mm');
    return f.format(time);
  }

  Widget _historyItem(BuildContext context) {
    return InkWell(
      onTap: null,
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
              formattedTime(history.time),
              style: TextStyle(
                fontSize: View.x * 6,
                color: Colors.white,
              ),
            ),
            Text(
              formattedDate(history.time),
              style: TextStyle(
                fontSize: View.x * 3,
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
            _dataBoxItem(notation: 'V', value: history.volt.toStringAsFixed(2)),
            _dataBoxItem(
                notation: 'I', value: history.current.toStringAsFixed(2)),
            _dataBoxItem(
                notation: 'P', value: history.power.toStringAsFixed(2)),
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

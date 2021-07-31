import 'package:flutter/material.dart';
import 'package:power_monitor_app/core/utils/app_colors.dart';

class Toggle extends StatelessWidget {
  final String hint;
  final bool enabled;

  const Toggle({Key? key, required this.hint, required this.enabled})
      : super(key: key);
  Widget _toggleItem({required bool enabled, required String hint}) {
    return Container(
      child: Row(
        children: [
          Switch(
            value: enabled,
            activeColor: AppColors.secondary,
            inactiveTrackColor: Colors.white,
            inactiveThumbColor: AppColors.primary,
            onChanged: (_) => print(_),
          ),
          Text(
            hint,
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _toggleItem(enabled: enabled, hint: hint);
  }
}

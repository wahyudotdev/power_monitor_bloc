import 'package:flutter/material.dart';
import '../../features/home/presentation/bloc/realtime_bloc.dart';
import '../../injection_container.dart';
import '../utils/app_colors.dart';

class Toggle extends StatelessWidget {
  final String hint;
  final bool enabled;
  final String path;
  const Toggle(
      {Key? key, required this.hint, required this.enabled, required this.path})
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
            onChanged: (_) =>
                sl<RealtimeBloc>().add(ToggleLoadEvent(load: path)),
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

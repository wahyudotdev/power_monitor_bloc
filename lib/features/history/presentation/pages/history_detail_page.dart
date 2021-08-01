import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/view.dart';
import '../../../../core/widgets/gauge.dart';
import '../../../../core/widgets/toggle.dart';
import '../widgets/history_item.dart';

class HistoryDetailPage extends StatelessWidget {
  Widget _decoration() {
    return Container(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.topRight,
            child: SvgPicture.asset('assets/bubble.svg'),
          ),
          Container(
            margin: EdgeInsets.only(
              left: View.x * 5,
              top: View.y * 10,
            ),
            child: Text(
              'Status',
              style: TextStyle(
                color: Colors.white,
                fontSize: View.x * 6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return SliverAppBar(
      expandedHeight: View.y * 20,
      floating: true,
      pinned: true,
      snap: true,
      elevation: 50,
      backgroundColor: AppColors.primary,
      flexibleSpace: _decoration(),
      stretchTriggerOffset: 15,
    );
  }

  Widget _historyItem() {
    return SliverToBoxAdapter(
      child: HistoryItem(),
    );
  }

  Widget _gauge() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        height: View.x * 60,
        margin: EdgeInsets.only(left: View.x * 10, right: View.x * 10),
        child: Gauge(
          maxValue: 600,
          notation: 'w',
          value: 400,
          hint: 'Batas 600w',
        ),
      ),
    );
  }

  Widget _lampToggle() {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(
                left: View.x * 5,
              ),
              child: Column(
                children: [
                  Toggle(enabled: false, hint: 'Beban 1'),
                  Toggle(enabled: true, hint: 'Beban 2'),
                  Toggle(enabled: true, hint: 'Beban 3'),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: View.y * 20,
              margin: EdgeInsets.all(View.x * 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: AppColors.secondaryDark.withOpacity(0.3),
                    offset: Offset(3, 3),
                    spreadRadius: 3,
                  )
                ],
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.secondary, AppColors.secondaryDark]),
              ),
              child: Icon(
                Icons.settings_power,
                color: Colors.white,
                size: View.x * 20,
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
      color: AppColors.primary,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primary,
          body: CustomScrollView(
            slivers: [
              _title(),
              _historyItem(),
              _gauge(),
              _lampToggle(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/view.dart';
import '../widgets/history_item.dart';

class HistoryPage extends StatelessWidget {
  Widget _title() {
    return SliverToBoxAdapter(
      child: Container(
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
                top: View.y * 5,
              ),
              child: Text(
                'Riwayat',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: View.x * 6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _history() {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return HistoryItem(
              action: () => Navigator.of(context).pushNamed('/detail'));
        },
        childCount: 10,
      ),
      itemExtent: View.y * 18,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: CustomScrollView(
        slivers: [
          _title(),
          _history(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/view.dart';
import '../../../../core/widgets/gauge.dart';
import '../../../../core/widgets/toggle.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final stateClicked = 0;

  Widget _welcomeMessage() {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hai, Febryna',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: View.x * 6,
                    ),
                  ),
                  Text(
                    'Selamat datang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: View.x * 4,
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

  Widget _statusBoxItem({
    required bool isSelected,
    required String symbol,
    required String hint,
  }) {
    List<Color> boxSelected = [AppColors.secondary, AppColors.secondaryDark];
    List<Color> boxNotSelected = [
      AppColors.box,
      AppColors.box,
    ];
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(View.x * 2),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isSelected ? boxSelected : boxNotSelected,
            ),
            borderRadius: BorderRadius.circular(View.x * 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 3,
                spreadRadius: 3,
                offset: Offset(3, 3),
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              symbol,
              style: TextStyle(
                color: Colors.white,
                fontSize: View.x * 10,
              ),
            ),
            Text(
              hint,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusBox() {
    return SliverToBoxAdapter(
      child: Container(
        height: View.y * 20,
        margin: EdgeInsets.only(
          top: View.x * 5,
          left: View.x * 3,
          right: View.x * 3,
        ),
        width: double.infinity,
        child: Row(
          children: [
            _statusBoxItem(
              isSelected: true,
              symbol: 'V',
              hint: 'Tegangan',
            ),
            _statusBoxItem(
              isSelected: false,
              symbol: 'I',
              hint: 'Arus',
            ),
            _statusBoxItem(
              isSelected: false,
              symbol: 'P',
              hint: 'Daya',
            ),
          ],
        ),
      ),
    );
  }

  Widget _gauge() {
    return Expanded(
      flex: 3,
      child: Container(
        child: Gauge(
          value: 220,
          maxValue: 240,
          hint: 'Batas 240V',
          notation: 'V',
        ),
      ),
    );
  }

  Widget _lampToggle() {
    return Expanded(
      flex: 2,
      child: Container(
        child: Column(
          children: [
            Toggle(enabled: false, hint: 'Lampu 1'),
            Toggle(enabled: true, hint: 'Lampu 2'),
            Toggle(enabled: true, hint: 'Lampu 3'),
          ],
        ),
      ),
    );
  }

  Widget _mainStatus() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(
          View.x * 5,
        ),
        child: Row(
          children: [
            _gauge(),
            _lampToggle(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: CustomScrollView(
        slivers: [
          _welcomeMessage(),
          _statusBox(),
          _mainStatus(),
        ],
      ),
    );
  }
}

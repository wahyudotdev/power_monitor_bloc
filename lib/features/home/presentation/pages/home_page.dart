import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:power_monitor_app/features/home/presentation/bloc/latest_bloc.dart';
import '../../../../core/auth/presentation/bloc/auth_bloc.dart';
import '../../../../injection_container.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/view.dart';
import '../../../../core/widgets/gauge.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedBox = 'CM';

  Widget _welcomeMessage() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UpdatedProfile) {
          EasyLoading.dismiss();
        }
        if (state is UpdateFailure) {
          EasyLoading.dismiss();
        }
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
                        state is UserAuthenticated
                            ? state.userAuthInfo.displayName
                            : state is UpdatedProfile
                                ? state.authInfo.displayName
                                : BlocProvider.of<AuthBloc>(context)
                                    .currentUser!
                                    .displayName,
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
      },
    );
  }

  Widget _statusBoxItem({
    required BuildContext context,
    required String symbol,
    required String hint,
    required String path,
  }) {
    List<Color> boxSelected = [AppColors.secondary, AppColors.secondaryDark];
    List<Color> boxNotSelected = [
      AppColors.box,
      AppColors.box,
    ];
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedBox = symbol;
          });
        },
        child: Container(
          margin: EdgeInsets.all(View.x * 2),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: selectedBox == symbol ? boxSelected : boxNotSelected,
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
              context: context,
              symbol: 'CM',
              hint: 'Tinggi Air',
              path: 'voltTh',
            ),
            _statusBoxItem(
              context: context,
              symbol: 'Pa',
              hint: 'Tekanan Air',
              path: 'currentTh',
            ),
          ],
        ),
      ),
    );
  }

  Widget _gaugeWidget({
    double? value,
    double? maxValue,
    String? hint,
    String? notation,
  }) {
    return Expanded(
      flex: 3,
      child: Container(
        child: Gauge(
          value: value ?? 1,
          maxValue: maxValue ?? 1,
          hint: hint ?? 'Loading',
          notation: notation ?? '',
        ),
      ),
    );
  }

  Widget _gauge() {
    return BlocBuilder<LatestBloc, LatestState>(
      builder: (context, state) {
        if (state is LatestInitial) {
          BlocProvider.of<LatestBloc>(context).add(LoadLatestDataEvent());
        }
        if (state is LoadedLatestData) {
          print(state.data);
          switch (selectedBox) {
            case 'CM':
              return _gaugeWidget(
                  hint: 'Tinggi Air',
                  value: state.data.tinggiAir,
                  maxValue: 100,
                  notation: 'CM');
            case 'Pa':
              return _gaugeWidget(
                  hint: 'Tekanan Air',
                  value: state.data.tekananAir,
                  maxValue: 10,
                  notation: 'Pa');
          }
        }
        return _gaugeWidget();
      },
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LatestBloc>(),
      child: BlocBuilder<LatestBloc, LatestState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async =>
                BlocProvider.of<LatestBloc>(context).add(LoadLatestDataEvent()),
            child: Container(
              color: AppColors.primary,
              child: CustomScrollView(
                slivers: [
                  _welcomeMessage(),
                  _statusBox(),
                  _mainStatus(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:power_monitor_app/core/auth/presentation/bloc/auth_bloc.dart';
import 'package:power_monitor_app/features/home/presentation/bloc/realtime_bloc.dart';
import 'package:power_monitor_app/injection_container.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/view.dart';
import '../../../../core/widgets/gauge.dart';
import '../../../../core/widgets/toggle.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedBox = 'V';

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
                                : '',
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
  }) {
    List<Color> boxSelected = [AppColors.secondary, AppColors.secondaryDark];
    List<Color> boxNotSelected = [
      AppColors.box,
      AppColors.box,
    ];
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          setState(() {
            selectedBox = symbol;
            BlocProvider.of<RealtimeBloc>(context)
                .add(RefreshRealtimeDataEvent());
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
    return BlocBuilder<RealtimeBloc, RealtimeState>(
      builder: (context, state) {
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
                  symbol: 'V',
                  hint: 'Tegangan',
                ),
                _statusBoxItem(
                  context: context,
                  symbol: 'I',
                  hint: 'Arus',
                ),
                _statusBoxItem(
                  context: context,
                  symbol: 'P',
                  hint: 'Daya',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _gaugeWidget(
      {double? value, double? maxValue, String? hint, String? notation}) {
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
    return BlocBuilder<RealtimeBloc, RealtimeState>(
      builder: (context, state) {
        print(state);
        if (state is RealtimeInitial) {
          BlocProvider.of<RealtimeBloc>(context).add(ListenRealtimeData());
        }

        if (state is RealtimeDataLoaded) {
          switch (selectedBox) {
            case 'V':
              return _gaugeWidget(
                  hint: 'Tegangan',
                  value: state.data.volt,
                  maxValue: state.data.voltTh,
                  notation: 'V');
            case 'I':
              return _gaugeWidget(
                  hint: 'Arus',
                  value: state.data.current,
                  maxValue: state.data.currentTh,
                  notation: 'A');
            case 'P':
              return _gaugeWidget(
                  hint: 'Daya',
                  value: state.data.power,
                  maxValue: state.data.powerTh,
                  notation: 'w');
          }
        }
        return _gaugeWidget();
      },
    );
  }

  Widget _lampToggle() {
    return BlocBuilder<RealtimeBloc, RealtimeState>(
      builder: (context, state) {
        return Expanded(
          flex: 2,
          child: Container(
            child: Column(
              children: [
                Toggle(
                    enabled:
                        state is RealtimeDataLoaded ? state.data.load1 : false,
                    hint: 'Beban 1'),
                Toggle(
                    enabled:
                        state is RealtimeDataLoaded ? state.data.load2 : false,
                    hint: 'Beban 2'),
                Toggle(
                    enabled:
                        state is RealtimeDataLoaded ? state.data.load3 : false,
                    hint: 'Beban 3'),
              ],
            ),
          ),
        );
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
            _lampToggle(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RealtimeBloc>(),
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
  }
}

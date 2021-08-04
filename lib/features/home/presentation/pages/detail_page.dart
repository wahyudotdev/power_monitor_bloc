import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:power_monitor_app/features/home/presentation/bloc/realtime_bloc.dart';
import 'package:power_monitor_app/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/view.dart';
import '../../../../core/widgets/gauge.dart';
import '../../../../core/widgets/toggle.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var selectedBox = 'V';

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
              top: View.y * 5,
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
      expandedHeight: View.y * 10,
      floating: true,
      pinned: true,
      snap: true,
      elevation: 50,
      backgroundColor: AppColors.primary,
      flexibleSpace: _decoration(),
      stretchTriggerOffset: 15,
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
            BlocProvider.of<RealtimeBloc>(context)
                .add(RefreshRealtimeDataEvent());
          });
        },
        onLongPress: null,
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
                  path: 'voltTh',
                ),
                _statusBoxItem(
                  context: context,
                  symbol: 'I',
                  hint: 'Arus',
                  path: 'currentTh',
                ),
                _statusBoxItem(
                  context: context,
                  symbol: 'P',
                  hint: 'Daya',
                  path: 'powerTh',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _gaugeWidget({
    double? value,
    double? maxValue,
    String? hint,
    String? notation,
  }) {
    return Container(
      child: Gauge(
        value: value ?? 1,
        maxValue: maxValue ?? 1,
        hint: hint ?? 'Loading',
        notation: notation ?? '',
      ),
    );
  }

  Widget _gauge() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        height: View.y * 40,
        child: BlocBuilder<RealtimeBloc, RealtimeState>(
          builder: (context, state) {
            if (state is RealtimeInitial) {
              BlocProvider.of<RealtimeBloc>(context).add(ListenRealtimeData());
            }

            if (state is RealtimeDataLoaded) {
              switch (selectedBox) {
                case 'V':
                  return _gaugeWidget(
                    hint: 'Batas maks ${state.data.voltTh} V',
                    value: state.data.volt,
                    maxValue: state.data.voltTh,
                    notation: 'V',
                  );
                case 'I':
                  return _gaugeWidget(
                    hint: 'Batas maks ${state.data.currentTh} A',
                    value: state.data.current,
                    maxValue: state.data.currentTh,
                    notation: 'A',
                  );
                case 'P':
                  return _gaugeWidget(
                    hint: 'Batas maks ${state.data.power} w',
                    value: state.data.power,
                    maxValue: state.data.powerTh,
                    notation: ' w',
                  );
              }
            }
            return _gaugeWidget();
          },
        ),
      ),
    );
  }

  Widget _lampToggle() {
    return BlocBuilder<RealtimeBloc, RealtimeState>(
      builder: (context, state) {
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
                      Toggle(
                        enabled: state is RealtimeDataLoaded
                            ? state.data.load1
                            : false,
                        hint: 'Beban 1',
                        path: 'load1',
                      ),
                      Toggle(
                        enabled: state is RealtimeDataLoaded
                            ? state.data.load2
                            : false,
                        hint: 'Beban 2',
                        path: 'load2',
                      ),
                      Toggle(
                        enabled: state is RealtimeDataLoaded
                            ? state.data.load3
                            : false,
                        hint: 'Beban 3',
                        path: 'load3',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () => BlocProvider.of<RealtimeBloc>(context)
                      .add(TurnOffAllEvent()),
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
                          colors: [
                            AppColors.secondary,
                            AppColors.secondaryDark
                          ]),
                    ),
                    child: Icon(
                      Icons.settings_power,
                      color: Colors.white,
                      size: View.x * 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    View().init(context);
    SharedPreferences.getInstance()
        .then((value) => value.remove('notification'));
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/menu', (route) => false);
        return true;
      },
      child: BlocProvider(
        create: (context) => sl<RealtimeBloc>(),
        child: Container(
          color: AppColors.primary,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.primary,
              body: CustomScrollView(
                slivers: [
                  _title(),
                  _statusBox(),
                  _gauge(),
                  _lampToggle(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/view.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Gauge extends StatelessWidget {
  final double maxValue;
  final double value;
  final String notation;
  final String hint;

  const Gauge(
      {Key? key,
      required this.maxValue,
      required this.value,
      required this.notation,
      required this.hint})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      enableLoadingAnimation: true,
      axes: <RadialAxis>[
        RadialAxis(
            showLabels: false,
            showTicks: false,
            radiusFactor: 0.8,
            minimum: 0,
            maximum: maxValue,
            axisLineStyle: AxisLineStyle(
              cornerStyle: CornerStyle.startCurve,
              thickness: 2,
              color: AppColors.box,
            ),
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                angle: 90,
                positionFactor: 0,
                widget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$value $notation',
                      style: TextStyle(
                        fontSize: View.x * 8,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: Text(
                        '$hint',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
            pointers: <GaugePointer>[
              RangePointer(
                value: value >= maxValue ? maxValue - 3 : value,
                width: View.x * 1.5,
                pointerOffset: -6,
                cornerStyle: CornerStyle.bothCurve,
                color: Color(0xFFF67280),
                gradient: SweepGradient(colors: <Color>[
                  AppColors.secondary,
                  AppColors.secondary,
                ], stops: <double>[
                  0.25,
                  0.75
                ]),
              ),
              MarkerPointer(
                value: value >= maxValue ? maxValue : value,
                borderColor: Colors.white,
                markerWidth: View.x * 4,
                markerHeight: View.x * 4,
                borderWidth: View.x * 0.5,
                color: Colors.transparent,
                markerType: MarkerType.circle,
              ),
            ]),
      ],
    );
  }
}

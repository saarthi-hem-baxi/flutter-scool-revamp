import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/helpers/firebase/dynamic_link.service.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class LearnOMeterComponent extends StatelessWidget {
  const LearnOMeterComponent({
    Key? key,
    required this.progress,
  }) : super(key: key);

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shadowColor: Colors.black.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Padding(
        padding:
            EdgeInsets.only(top: 12.h, bottom: 12.h, left: 10.w, right: 10.w),
        child: Row(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.3,
                child: LearnOMeterWidget(
                  progress: progress,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Concept Cleared',
                    style: AppTextStyle.poppinsTextStyle12Regular().copyWith(
                      color: AppColors.blueDarkLight,
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    '${progress.toInt()}%',
                    style: AppTextStyle.poppinsTextStyle24Regular().copyWith(
                      color: AppColors.greenLight,
                      fontWeight: FontWeight.w600,
                      fontSize: 26.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 9.w, vertical: 7.h),
                    decoration: BoxDecoration(
                      color: AppColors.colorFA9D66,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Check Dashboard',
                      style: AppTextStyle.poppinsTextStyle12Regular().copyWith(
                        color: AppColors.navyBlueDark,
                        fontWeight: FontWeight.w400,
                        fontSize: 11.sp,
                      ),
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
}

class LearnOMeterWidget extends StatelessWidget {
  const LearnOMeterWidget({
    Key? key,
    required this.progress,
  }) : super(key: key);

  final double progress;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          canScaleToFit: true,
          startAngle: 150,
          endAngle: 30,
          minimum: 0,
          maximum: 100,
          tickOffset: 10,
          labelOffset: 9,
          showLastLabel: true,
          majorTickStyle: const MajorTickStyle(
            color: AppColors.color586579,
            length: 3,
            lengthUnit: GaugeSizeUnit.logicalPixel,
            thickness: 2,
          ),
          minorTickStyle: const MinorTickStyle(
            color: AppColors.colorDFE4E9,
            length: 3,
            lengthUnit: GaugeSizeUnit.logicalPixel,
            thickness: 0.5,
          ),
          minorTicksPerInterval: 9,
          interval: 10,
          axisLineStyle: const AxisLineStyle(
            thickness: 0.1,
            thicknessUnit: GaugeSizeUnit.factor,
            color: Colors.transparent,
          ),
          axisLabelStyle: GaugeTextStyle(
            color: AppColors.color98A2B3,
            fontSize: 7.sp,
            fontWeight: FontWeight.normal,
            fontFamily: GoogleFonts.poppins().fontFamily ?? '',
          ),
          pointers: <GaugePointer>[
            NeedlePointer(
              needleLength: 0.87,
              needleColor: const Color.fromRGBO(16, 24, 40, 1),
              value: progress,
              enableAnimation: true,
              animationType: AnimationType.linear,
              animationDuration: 4000,
              needleEndWidth: 3,
              needleStartWidth: 0,
              knobStyle: const KnobStyle(
                  color: Color.fromRGBO(102, 112, 133, 1),
                  knobRadius: 5,
                  sizeUnit: GaugeSizeUnit.logicalPixel),
            ),
            const RangePointer(
                value: 100,
                width: 0.12,
                sizeUnit: GaugeSizeUnit.factor,
                cornerStyle: CornerStyle.bothCurve,
                gradient: SweepGradient(
                  colors: <Color>[
                    Color(0xFFF24D38),
                    Color(0xFFFFFE60),
                    Color(0xFFFEFF5B),
                    Color(0xFF0DBC72),
                  ],
                  stops: <double>[
                    0.0,
                    0.40,
                    0.60,
                    1.0,
                  ],
                ),
                enableAnimation: false)
          ],
        )
      ],
    );
  }
}

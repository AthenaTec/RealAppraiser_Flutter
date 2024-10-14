import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';
import 'package:real_appraiser/features/ra/domain/entities/daily_conveyance_report_entity.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/conveyance_report_cubit.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/conveyance_report_state.dart';
import 'package:real_appraiser/features/ra/presentation/widgets/conveyance_custom_report.dart';
import 'package:real_appraiser/features/ra/presentation/widgets/conveyance_daily_report.dart';

class ConveyanceReport extends StatefulWidget {
  const ConveyanceReport({super.key});

  @override
  State<ConveyanceReport> createState() => _ConveyanceReportState();
}

class _ConveyanceReportState extends State<ConveyanceReport> {
  DailyConveyanceReportEntity? dailyConveyanceReportEntity;

  @override
  void initState() {
    BlocProvider.of<ConveyanceReportCubit>(context).getDailyReport();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConveyanceReportCubit, ConveyanceReportState>(
        listener: (context, state) {
      if (state is CrDailyReportSuccessState) {
        dailyConveyanceReportEntity = state.dailyConveyanceReportEntity;
      }
      if (state is CrCustomReportSuccessState) {
        Fluttertoast.showToast(msg: "Pdf downloaded successfully");
      }
    }, buildWhen: (previous, current) {
      if (current is CrDailyReportSuccessState ||
          current is CrDailyReportInitialState) {
        return true;
      } else {
        return false;
      }
    }, builder: (context, state) {
      if (state is CrDailyReportInitialState) {
        return Center(
            child: CircularProgressIndicator(
          color: RAColors.colorM,
        ));
      }

      return DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: RAColors.white,
                    border: Border.all(width: 1, color: RAColors.white)),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: RAColors.colorM,
                  ),
                  indicatorPadding:
                      const EdgeInsets.symmetric(horizontal: -75, vertical: 0),
                  dividerColor: Colors.transparent,
                  labelStyle: TextStyle(
                      fontSize: 12,
                      fontFamily: "AldrichRegular",
                      color: RAColors.white),
                  unselectedLabelStyle: TextStyle(
                      fontSize: 12,
                      fontFamily: "AldrichRegular",
                      color: RAColors.textBlack),
                  tabs: const [
                    Tab(text: ' Daily '),
                    Tab(text: 'Custom'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  if (dailyConveyanceReportEntity != null)
                    ConveyanceDailyReport(
                      dailyConveyanceReportEntity: dailyConveyanceReportEntity!,
                    )
                  else
                    Center(child: Text("No report available")),
                  DateRangePickerWidget()
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

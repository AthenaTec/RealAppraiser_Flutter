import 'package:flutter/material.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/features/ra/domain/entities/daily_conveyance_report_entity.dart';

class ConveyanceDailyReport extends StatefulWidget {
  final DailyConveyanceReportEntity dailyConveyanceReportEntity;

  const ConveyanceDailyReport(
      {super.key, required this.dailyConveyanceReportEntity});

  @override
  State<ConveyanceDailyReport> createState() => _ConveyanceDailyReportState();
}

class _ConveyanceDailyReportState extends State<ConveyanceDailyReport> {
  @override
  Widget build(BuildContext context) {
    if (widget.dailyConveyanceReportEntity.dataEntity.activities.isNotEmpty){
      return     Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Text(
                "Total Distance Travelled: ${widget.dailyConveyanceReportEntity.dataEntity.totalDistance}",
                style: TextStyle(fontSize: 14, fontFamily: "AldrichRegular")),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Text(
                "Total Activity count: ${widget.dailyConveyanceReportEntity.dataEntity.noOfActivities}",
                style: TextStyle(fontSize: 14, fontFamily: "AldrichRegular")),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.dailyConveyanceReportEntity.dataEntity.activities.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Time : ${widget.dailyConveyanceReportEntity.dataEntity.activities[index].time}",
                                      style: TextStyle(
                                          color: RAColors.txtBlue,
                                          fontSize: 14,
                                          fontFamily: "AldrichRegular")),

                                  Text(
                                      "Case id : ${widget.dailyConveyanceReportEntity.dataEntity.activities[index].caseId}",
                                      style: TextStyle(
                                          color: RAColors.txtBlue,
                                          fontSize: 14,
                                          fontFamily: "AldrichRegular"))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Activity Type :",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "AldrichRegular")),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      widget.dailyConveyanceReportEntity
                                          .dataEntity.activities[index].activity,
                                      style: TextStyle(
                                          color: RAColors.black,
                                          fontSize: 14,
                                          fontFamily: "AldrichRegular"))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Latitude     :",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "AldrichRegular")),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      widget.dailyConveyanceReportEntity
                                          .dataEntity.activities[index].latitude
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "AldrichRegular"))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Longtitude :",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "AldrichRegular")),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      widget.dailyConveyanceReportEntity
                                          .dataEntity.activities[index].longitude
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "AldrichRegular"))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Address      :",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "AldrichRegular")),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                        widget.dailyConveyanceReportEntity
                                            .dataEntity.activities[index].address,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "AldrichRegular")),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      );

    }else {
      return Center(child: Text(
        "No Data in Today's Activity",style: TextStyle(fontSize: 14, fontFamily: "AldrichRegular") ,
      ),);
    }
  }
}

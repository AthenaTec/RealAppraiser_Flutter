import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/features/ra/domain/entities/getcase_byemp_id_entity.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/homepage_cubit.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/homepage_state.dart';
import 'package:real_appraiser/features/ra/presentation/widgets/highlighted_widget.dart';
import 'package:real_appraiser/features/ra/presentation/widgets/ra_button.dart';

class InfoCard extends StatefulWidget {
  final GetCaseByEmployeeIdEntity getCaseByEmployeeIdEntity;

  const InfoCard({super.key, required this.getCaseByEmployeeIdEntity});

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.getCaseByEmployeeIdEntity.data.open.length,
      padding: EdgeInsets.all(10),
      itemBuilder: (BuildContext context, int index) {
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
                      Text(
                        "Fin id : ${widget.getCaseByEmployeeIdEntity.data.open[index].bankReferenceNo}",
                        style: TextStyle(
                            color: RAColors.txtBlue,
                            fontSize: 12,
                            fontFamily: "AldrichRegular"),
                      ),
                      Text(
                          "Case id : ${widget.getCaseByEmployeeIdEntity.data.open[index].caseId}",
                          style: TextStyle(
                              color: RAColors.txtBlue,
                              fontSize: 12,
                              fontFamily: "AldrichRegular"))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HighlightedTag(
                        dateTime: widget.getCaseByEmployeeIdEntity.data
                            .open[index].assignedAt,
                        status: "Active",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                widget.getCaseByEmployeeIdEntity.data
                                    .open[index].applicantName,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "InterRegular",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: SizedBox(
                                width: 200,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset("assets/png/location.png"),
                                    Expanded(
                                      child: Text(
                                        widget.getCaseByEmployeeIdEntity.data
                                            .open[index].propertyAddress,
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 13,
                                            fontFamily: "InterRegular"),
                                        maxLines: 1,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset("assets/png/call.png"),
                                  Text(
                                      widget.getCaseByEmployeeIdEntity.data
                                          .open[index].contactPersonNumber,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: "InterRegular"))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Text(
                                  widget.getCaseByEmployeeIdEntity.data
                                      .open[index].bankName,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "InterRegular")),
                            ),
                            SizedBox(
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Text(
                                  "Property - ${widget.getCaseByEmployeeIdEntity.data.open[index].propertyType}",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13,
                                      fontFamily: "InterRegular"),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text("Property exists",
                      style:
                          TextStyle(fontSize: 13, fontFamily: "InterRegular")),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // Ensures spacing between left and right content
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      // Ensures the row will only take up the necessary space
                      children: [
                        SvgPicture.asset("assets/svg/property.svg"),
                        SvgPicture.asset("assets/svg/property.svg"),
                        SvgPicture.asset("assets/svg/switch.svg"),
                      ],
                    ),
                    BlocBuilder<HomepageCubit, HomepageState>(
                        buildWhen: (previous, current) {
                      if (current is UpdateStatusIdSuccessState) {
                        return true;
                      } else {
                        return false;
                      }
                    }, builder: (context, state) {
                      if (state is UpdateStatusIdSuccessState &&
                          state.index == index) {
                        return _buildActionButtonRow(index,
                            updatedStatusId: state
                                .updateCaseStatusByIdEntity.data.status
                                .toString());
                      } else {
                        return _buildActionButtonRow(index);
                      }
                    })
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtonRow(int index, {String? updatedStatusId}) {
    int statusId = updatedStatusId != null
        ? int.parse(updatedStatusId)
        : widget.getCaseByEmployeeIdEntity.data.open[index].statusId;

    if (statusId == 13) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: RAColors.colorM,
        ),
        onPressed: () {
          _showConfirmationDialog(context, index);

          // Modular.to.pushNamed('/${RoutingString.editDetailsSScreen}');
        },
        child: Text(
          "Start Inspection",
          style: TextStyle(
            fontSize: 12,
            fontFamily: "InterRegular",
            color: RAColors.white,
          ),
        ),
      );
    } else if (statusId == 2) {
      return Wrap(
        spacing: 8.0,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: RAColors.button,
            ),
            onPressed: () {},
            child: Text(
              "Send",
              style: TextStyle(
                fontSize: 13,
                fontFamily: "InterRegular",
                color: Colors.black,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: RAColors.colorM,
            ),
            onPressed: () {
              Modular.to.pushNamed('/${RoutingString.editDetailsSScreen}');
            },
            child: Text(
              "Edit",
              style: TextStyle(
                fontSize: 13,
                fontFamily: "InterRegular",
                color: RAColors.white,
              ),
            ),
          ),
        ],
      );
    } else if (statusId == 12) {
      return Wrap(
        spacing: 8.0,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: RAColors.button,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {},
            child: Text(
              "Reject",
              style: TextStyle(
                fontSize: 13,
                fontFamily: "InterRegular",
                color: Colors.black,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: RAColors.colorM,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              String caseId = widget
                  .getCaseByEmployeeIdEntity.data.open[index].caseId
                  .toString();
              BlocProvider.of<HomepageCubit>(context)
                  .updateStatusByCaseId(caseId, "13", index);
              // Handle Accept
            },
            child: Text(
              "Accept",
              style: TextStyle(
                fontSize: 13,
                fontFamily: "InterRegular",
                color: RAColors.white,
              ),
            ),
          ),
        ],
      );
    } else {
      return SizedBox.shrink(); // Return empty widget if no actions are needed
    }
  }

  void _showConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20),
          content: Text(
            "Do you want to start inspection for ${widget.getCaseByEmployeeIdEntity.data.open[index].propertyType} case?",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "InterRegular", fontSize: 15),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10.0), // Change this value to adjust the corner radius
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(5.0), // Adjust radius here
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    backgroundColor: RAColors.colorM, // Button background color
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('No', style: TextStyle(color: RAColors.white)),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(5.0), // Adjust radius here
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    backgroundColor: RAColors.colorM, // Button background color
                  ),
                  onPressed: () {
                    // Handle "Yes" action here
                    Navigator.of(context).pop(); // Close the dialog
                    // You can perform your action here, e.g., delete an item, etc.
                     Modular.to.pushNamed('/${RoutingString.editDetailsSScreen}');

                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: RAColors.white),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

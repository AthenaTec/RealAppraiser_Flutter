import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/common_utilis/location_utilis.dart';
import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';
import 'package:real_appraiser/features/ra/domain/usecases/non_case_activity_usecases.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/non_case_activity_cubit.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/non_case_activity_state.dart';

class NonCaseActivityScreen extends StatefulWidget {
  const NonCaseActivityScreen({super.key});

  @override
  State<NonCaseActivityScreen> createState() => _NonCaseActivityScreenState();
}

class _NonCaseActivityScreenState extends State<NonCaseActivityScreen> {
  int selectedValue = -1;
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<NonCaseActivityCubit>(context).loadNonCaseActivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: RAColors.colorM,
        iconTheme: IconThemeData(color: RAColors.white),
        title: Text(
          'Non Case Activity',
          style: TextStyle(fontFamily: "AldrichRegular", color: RAColors.white),
        ),
      ),
      body: BlocConsumer<NonCaseActivityCubit, NonCaseActivityState>(
        buildWhen: (previous, current) {
          if (current is LoadNonCaseActivitySuccessState) {
            return true;
          } else {
            return false;
          }
        },
        listener: (context, state) {
          if (state is FSTrackerDetailsInitialState) {
            RAUtilis.showLoader(context);
          }
          if (state is FSTrackerDetailsSuccessState) {
            RAUtilis.hideLoader(context);
            Fluttertoast.showToast(msg: state.fsTrackerEntity.data);
            Modular.to.pop();

          }
          if (state is FSTrackerDetailsErrorState) {
            RAUtilis.hideLoader(context);
            Fluttertoast.showToast(msg: state.message);
          }
        },
        builder: (context, state) {
          if (state is LoadNonCaseActivitySuccessState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20),
                  child: Text(
                    "Please Select the Visit Type",
                    style: TextStyle(
                        fontFamily: "AldrichRegular",
                        fontSize: 18,
                        color: RAColors.colorM,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio(
                              activeColor: RAColors.colorM,
                              value: index,
                              groupValue: selectedValue,
                              onChanged: (int? value) {
                                setState(() {
                                  selectedValue = value!;
                                });
                              },
                            ),
                            SizedBox(width: 1),
                            // Adjust this value to reduce/increase space
                            Text(
                              state
                                  .loadNonCaseActivitiesEntity.data[index].name,
                              style: TextStyle(
                                fontFamily: "AldrichRegular",
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: TextField(
                    controller: commentController,
                    maxLines: 5, // Allows multiple lines
                    decoration: InputDecoration(
                      hintText: 'Write your comment here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (selectedValue.isNegative) {
                          Fluttertoast.showToast(
                              msg: "Please select the Visit Type");
                        } else {
                          // Show the loader before starting the async operation
                          RAUtilis.showLoader(context);

                          // Fetch location and address asynchronously
                          Map<String, dynamic>? locationData =
                              await LocationUtils
                                  .getCurrentLocationAndAddress();

                          // Check if the widget is still mounted
                          RAUtilis.hideLoader(context);
                          if (locationData != null) {
                            double latitude = locationData['latitude'];
                            double longitude = locationData['longitude'];
                            String address = locationData['address'];

                            print("Latitude: $latitude, Longitude: $longitude");
                            print("Address: $address");

                            // Prepare data for submission
                            String comment = commentController.text;
                            int visitType = selectedValue;
                            String nonCaseName = state
                                .loadNonCaseActivitiesEntity
                                .data[visitType]
                                .name;
                            print("NONCASE $nonCaseName");

                            DateTime now = DateTime.now();
                            String formattedDateTime =
                                DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

                            if (nonCaseName.isNotEmpty && address.isNotEmpty) {
                              NonCaseActivityInput data = NonCaseActivityInput(
                                  address: address,
                                  activityType: "2",
                                  agencyBranchId: RAUtilis.getStorage(
                                      StorageString.branchId),
                                  comments: comment,
                                  fieldStaffId: RAUtilis.getStorage(
                                      StorageString.loginId),
                                  caseId: "",
                                  latitude: latitude.toString(),
                                  longitude: longitude.toString(),
                                  trackerTime: formattedDateTime,
                                  type: nonCaseName);

                              // Submit data through the cubit
                              BlocProvider.of<NonCaseActivityCubit>(context)
                                  .fsTrackerDetails(data);
                            }
                          } else {
                            print("Failed to get location and address");
                          }
                        }
                        // Hide the loader after the async operation
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: RAColors.colorM,
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          fontFamily: "AldrichRegular",
                          fontSize: 16,
                          color: RAColors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

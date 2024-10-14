import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/conveyance_report_cubit.dart';

class DateRangePickerWidget extends StatefulWidget {
   const DateRangePickerWidget({super.key});

  @override
  DateRangePickerWidgetState createState() => DateRangePickerWidgetState();
}

class DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        controller.text =
            "${picked.toLocal()}".split(' ')[0]; // Format the date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(fontSize: 14, fontFamily: "AldrichRegular"),
                  controller: startDateController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 14, fontFamily: "AldrichRegular"),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: 'Start Date',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        color: RAColors.colorM,
                      ),
                      onPressed: () {
                        _selectDate(context, startDateController);
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(fontSize: 14, fontFamily: "AldrichRegular"),
                  controller: endDateController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 14, fontFamily: "AldrichRegular"),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: 'End Date',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        color: RAColors.colorM,
                      ),
                      onPressed: () {
                        _selectDate(context, endDateController);
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 10),
          child: Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
                onPressed: () {
                  print(startDateController.text);
                  print(endDateController.text);
                  BlocProvider.of<ConveyanceReportCubit>(context).getCustomReport(startDateController.text, endDateController.text);

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: RAColors.colorM,
                ),
                child: Text("Download",style: TextStyle(fontSize: 14,color: RAColors.white, fontFamily: "AldrichRegular"),)),
          ),
        )
      ],
    );
  }
}

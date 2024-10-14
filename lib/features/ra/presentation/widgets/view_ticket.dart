import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_filter_status_entity.dart';
import 'package:real_appraiser/features/ra/domain/usecases/view_ticket_usecases.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/view_ticket_cubit.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/view_ticket_state.dart';

class ViewTicket extends StatefulWidget {
  const ViewTicket({super.key});

  @override
  State<ViewTicket> createState() => _ViewTicketState();
}

class _ViewTicketState extends State<ViewTicket> {
  @override
  void initState() {
    String empId = RAUtilis.getStorage(StorageString.empId);

    DateTime fromDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
    DateTime toDate = DateTime.now();

    String formattedFromDate = DateFormat('yyyy-MM-dd').format(fromDate);
    String formattedToDate = DateFormat('yyyy-MM-dd').format(toDate);
    TicketFilterInput filterInput = TicketFilterInput(
      empId: empId,
      fromDate: formattedFromDate,
      toDate: formattedToDate,
    );
    BlocProvider.of<ViewTicketCubit>(context).getTicketDetails(filterInput);

    super.initState();
  }

  // Helper function to format date and time
  String formatDate(String dateTime) {
    // Parse the incoming date-time string
    DateTime parsedDate = DateTime.parse(dateTime);
    // Format the date as "07-Oct-2024"
    String formattedDate = DateFormat('dd-MMM-yyyy').format(parsedDate);
    return formattedDate;
  }

  String formatTime(String dateTime) {
    // Parse the incoming date-time string
    DateTime parsedDate = DateTime.parse(dateTime);
    // Format the time as "10:27 AM"
    String formattedTime = DateFormat('hh:mm a').format(parsedDate);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ViewTicketCubit, ViewTicketState>(
      listener: (context, state) {
        if (state is GetTicketDetailsErrorState) {
          Fluttertoast.showToast(msg: state.message);
        }
        if (state is GetFilterStatusSuccessState) {
          RAUtilis.hideLoader(context);
          openTicketIdBottomSheet(state.ticketFilterStatusEntity);
        }
        if (state is GetFilterStatusInitialState) {
          RAUtilis.showLoader(context);
        }
      },
      buildWhen: (previous, current) {
        if (current is GetTicketDetailsSuccessState ||
            current is GetTicketDetailsInitialState) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is GetTicketDetailsInitialState) {
          return const Center(
              child: CircularProgressIndicator(
            color: RAColors.colorM,
          ));
        }
        if (state is GetTicketDetailsSuccessState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      BlocProvider.of<ViewTicketCubit>(context)
                          .getFilterStatus();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.filter_alt,
                        color: RAColors.colorM,
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.getTicketDetailsEntity.data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Modular.to.pushNamed(
                            '/${RoutingString.viewTicketDetailScreen}',
                            arguments: state
                                .getTicketDetailsEntity.data[index].ticketId);
                      },
                      child: Card(
                        color: Colors.grey.shade300,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Expanded for the Column to take 50% of the space
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ticket id #${state.getTicketDetailsEntity.data[index].ticketId}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "AldrichRegular",
                                      ),
                                    ),
                                    Text(
                                      state.getTicketDetailsEntity.data[index]
                                          .query,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: "AldrichRegular",
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow
                                          .ellipsis, // Ellipsis for long text
                                    ),
                                    Text(
                                      "Date: ${formatDate(state.getTicketDetailsEntity.data[index].date)}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: "AldrichRegular",
                                      ),
                                    ),
                                    Text(
                                      "Time: ${formatTime(state.getTicketDetailsEntity.data[index].date)}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: "AldrichRegular",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Space between column and status text

                              // Expanded for the status text to occupy the remaining 50% of the space
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  // Aligns "Open" to the right
                                  child: Text(
                                    state.getTicketDetailsEntity.data[index]
                                        .status,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: "AldrichRegular",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  void openTicketIdBottomSheet(TicketFilterStatusEntity ticketFilterEntity) {
    TextEditingController ticketIdController = TextEditingController();
    TextEditingController startDateController = TextEditingController();
    TextEditingController endDateController = TextEditingController();

    String selectedFilter = "Ticket ID"; // Default selection
    List<String> filters = ["Ticket ID", "Status"];

    // Modify selectedStatus to hold DatumEntity initially.
    DatumEntity? selectedStatus; // Default to null
    List<DatumEntity> statusList =
        ticketFilterEntity.data; // Status list from entity

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Filter By",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Full-width Dropdown for "Ticket ID" or "Status"
                    Container(
                      width: double.infinity, // Full width of the screen
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButtonFormField<String>(
                        value: selectedFilter,
                        isExpanded: true, // Make the dropdown full width
                        items: filters.map((String filter) {
                          return DropdownMenuItem<String>(
                            value: filter,
                            child: Text(filter),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedFilter = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Conditional input fields based on selection
                    if (selectedFilter == "Ticket ID") ...[
                      TextField(
                        controller: ticketIdController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: 'Enter Ticket ID',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ] else if (selectedFilter == "Status") ...[
                      Container(
                        width: double.infinity, // Full width of the screen
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButtonFormField<DatumEntity>(
                          value: selectedStatus,
                          // Initially, this can be null
                          isExpanded: true,
                          // Make the dropdown full width
                          items: statusList.map((DatumEntity status) {
                            return DropdownMenuItem<DatumEntity>(
                              value: status,
                              child: Text(status.name), // Display status name
                            );
                          }).toList(),
                          onChanged: (DatumEntity? newValue) {
                            setState(() {
                              selectedStatus =
                                  newValue; // Set the selected DatumEntity
                            });
                          },
                          hint: const Text("Select Status"), // Placeholder hint
                        ),
                      ),
                    ],

                    const SizedBox(height: 16),

                    // Start Date and End Date in a single line (Row)
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: startDateController,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.calendar_month,
                                color: RAColors.colorM,
                              ),
                              labelText: 'Start Date',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  startDateController.text =
                                      pickedDate.toString().split(' ')[0];
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Spacing between the two fields
                        Expanded(
                          child: TextField(
                            controller: endDateController,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.calendar_month,
                                color: RAColors.colorM,
                              ),
                              labelText: 'End Date',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  endDateController.text =
                                      pickedDate.toString().split(' ')[0];
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: RAColors.colorM),
                      onPressed: () {
                        String filterType = selectedFilter;
                        String startDate = startDateController.text;
                        String endDate = endDateController.text;
                        String empId = RAUtilis.getStorage(StorageString.empId);

                        if (filterType == "Ticket ID") {
                          String enteredTicketId = ticketIdController.text;
                          if (startDate.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please select start Date");
                          } else if (endDate.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please select end Date");
                          } else if (enteredTicketId.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Kindly enter ticket Id");
                          } else {
                            TicketFilterInput filterInput = TicketFilterInput(
                                empId: empId,
                                fromDate: startDate,
                                toDate: endDate,
                                filterBy: "ticketid",
                                ticketId: enteredTicketId);
                            BlocProvider.of<ViewTicketCubit>(context)
                                .getTicketDetails(filterInput);
                            Navigator.pop(context); // Close the bottom sheet

                          }
                        } else if (filterType == "Status" &&
                            selectedStatus != null) {
                          if (startDate.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please select start Date");
                          } else if (endDate.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please select end Date");
                          } else {
                            TicketFilterInput filterInput = TicketFilterInput(
                                empId: empId,
                                fromDate: startDate,
                                toDate: endDate,
                                filterBy: "status",
                                status: selectedStatus!.name);
                            BlocProvider.of<ViewTicketCubit>(context)
                                .getTicketDetails(filterInput);
                            Navigator.pop(context); // Close the bottom sheet

                          }
                        }

                      },
                      child: const Text(
                        'Search',
                        style: TextStyle(
                            color: RAColors.white,
                            fontFamily: "AldrichRegular"),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

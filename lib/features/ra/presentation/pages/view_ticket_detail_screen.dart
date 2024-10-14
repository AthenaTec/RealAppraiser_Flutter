import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/common_utilis/singleton_utilis.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_image_by_ticket_id_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_ticket_query_entity.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/view_ticket_detail_state.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/view_ticket_details_cubit.dart';

class ViewTicketDetailScreen extends StatefulWidget {
  const ViewTicketDetailScreen({super.key});

  @override
  State<ViewTicketDetailScreen> createState() => _ViewTicketDetailScreenState();
}

class _ViewTicketDetailScreenState extends State<ViewTicketDetailScreen> {
  int ticketId = 0;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController contactNumController = TextEditingController();
  TextEditingController queryController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();

  int? selectedQueryId;
  bool isOthersSelected = false; // Track if "Others" is selected
  TextEditingController otherQueryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ticketId = Modular.args.data;
    BlocProvider.of<ViewTicketDetailsCubit>(context)
        .getTicketDetailsById(ticketId.toString());
    BlocProvider.of<ViewTicketDetailsCubit>(context)
        .getImagesByTicketId(ticketId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: RAColors.colorM,
        iconTheme: const IconThemeData(color: RAColors.white),
        title: Text(
          "Ticket No #$ticketId",
          style: const TextStyle(
              fontFamily: "AldrichRegular", color: RAColors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: BlocBuilder<ViewTicketDetailsCubit, ViewTicketDetailState>(
            buildWhen: (previous, current) {
              if (current is ViewTicketDetailsByIdInitialState ||
                  current is ViewTicketDetailsByIdSuccessState) {
                return true;
              } else {
                return false;
              }
            },
            builder: (context, state) {
              if (state is ViewTicketDetailsByIdInitialState) {
                return const Center(
                  child: CircularProgressIndicator(color: RAColors.colorM),
                );
              }

              if (state is ViewTicketDetailsByIdSuccessState) {
                print(state.ticketDetailsbyIdEntity.dataEntity.contactNumber);
                // Get stored ticket queries
                GetTicketQueriesEntity? getTicketQueriesEntity =
                    DataManager.instance.getTicketQueries();

                // Assuming you get the query ID from the success state
                // For demonstration, I'm using a mock query ID.
                selectedQueryId = state.ticketDetailsbyIdEntity.dataEntity
                    .queryType; // Make sure to replace with the actual property from state
                String? selectedQueryName;

                // Find the query name from the stored queries
                if (getTicketQueriesEntity != null) {
                  selectedQueryName = getTicketQueriesEntity.data
                      .firstWhere(
                        (query) =>
                            query.id.toString() == selectedQueryId.toString(),
                        // Return null if no matching entity is found
                      )
                      .name;

                  // Check if the selected query name is "Others"
                  isOthersSelected = selectedQueryName == "Others";
                }

                // Set the query name in the text controller
                queryController.text = selectedQueryName ?? '';
                if (isOthersSelected == true) {
                  otherQueryController.text =
                      state.ticketDetailsbyIdEntity.dataEntity.otherQueries;
                }
                descriptionController.text =
                    state.ticketDetailsbyIdEntity.dataEntity.description;
                contactNumController.text =
                    state.ticketDetailsbyIdEntity.dataEntity.contactNumber;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Query:',
                      style: TextStyle(
                          fontFamily: "AldrichRegular",
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: queryController,
                      readOnly: true, // Make it read-only
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 12.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    // Conditionally show "Other Query" field if "Others" is selected
                    if (isOthersSelected) ...[
                      const SizedBox(height: 16.0),
                      const Text(
                        'Other Query:',
                        style: TextStyle(
                            fontFamily: "AldrichRegular",
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: otherQueryController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 12.0,
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 20.0),
                    const Text(
                      'Description:',
                      style: TextStyle(
                          fontFamily: "AldrichRegular",
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      maxLines: 4,
                      controller: descriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Contact Number:',
                        style: TextStyle(
                            fontFamily: "AldrichRegular",
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    TextField(
                      controller: contactNumController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 12.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Sample Screen shot:',
                        style: TextStyle(
                            fontFamily: "AldrichRegular",
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),

                    BlocBuilder<ViewTicketDetailsCubit, ViewTicketDetailState>(
                      buildWhen: (previous, current) {
                        if (current is GetImageByIdSuccessState) {
                          return true;
                        } else {
                          return false;
                        }
                      },
                      builder: (context, state) {
                        if (state is GetImageByIdSuccessState) {
                          List<Datum> images = state.getImageByTicketIdEntity
                              .data; // Assuming you store images in a field named images

                          return GridView.builder(
                              shrinkWrap: true,
                              itemCount: images.length,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of images per row
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                              ),
                              itemBuilder: (context, index) {
                                final imageItem = images[index];
                                final imageBytes =
                                    base64Decode(imageItem.image);
                                return Column(
                                  children: [
                                    Expanded(
                                      child: Image.memory(
                                        imageBytes,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    // Display the filename
                                    Text(
                                      imageItem.fileName,
                                      style: const TextStyle(
                                        fontFamily: "AldrichRegular",
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              });
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

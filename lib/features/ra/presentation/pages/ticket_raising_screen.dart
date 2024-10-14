import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/common_utilis/image_utilis.dart';
import 'package:real_appraiser/common_utilis/singleton_utilis.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_ticket_query_entity.dart';
import 'package:real_appraiser/features/ra/domain/usecases/raise_a_ticket_usecases.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/raise_a_ticket_cubit.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/raise_a_ticket_state.dart';

class TicketRaisingScreen extends StatefulWidget {
  const TicketRaisingScreen({super.key});

  @override
  State<TicketRaisingScreen> createState() => _TicketRaisingScreenState();
}

class _TicketRaisingScreenState extends State<TicketRaisingScreen> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController contactNumController = TextEditingController();
  TextEditingController sapIdController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();

  String? selectedQueryId;
  GetTicketQueriesEntity? getTicketQueriesEntity;

  List<Map<String, String>> selectedImages = [];
  List<TextEditingController> titleControllers = [];
  bool isOthersSelected = false;
  TextEditingController otherQueryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RaiseATicketCubit>(context).getTicketQuery();
  }

  // Function to handle image selection from the camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    Map<String, String>? imageData =
        await ImageUtils.pickAndCompressImage(source: source);

    if (imageData != null) {
      setState(() {
        // Add the base64 and filename to a list
        selectedImages.add(imageData);
        // Add a new TextEditingController for the title of the new image
        titleControllers.add(TextEditingController());
      });
    } else {
      print("Failed to pick or compress image!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RaiseATicketCubit, RaiseATicketState>(
      listener: (context, state) {
        if (state is CreateTicketInitialState) {
          RAUtilis.showLoader(context);
        }
        if (state is CreateTicketSuccessState) {
          RAUtilis.hideLoader(context);
          Fluttertoast.showToast(
              msg:
                  "Ticket Created: ${state.insertTicketEntity.data.ticketIdVal.toString()}");
          Modular.to.pop();
        }
        if (state is CreateTicketErrorState) {
          RAUtilis.hideLoader(context);
          Fluttertoast.showToast(msg: state.message);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: RAColors.colorM,
            iconTheme: const IconThemeData(color: RAColors.white),
            title: const Text(
              'Raise Ticket',
              style: TextStyle(
                  fontFamily: "AldrichRegular", color: RAColors.white),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
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
                  const SizedBox(height: 8.0),

                  // Using BlocBuilder to listen to state changes
                  BlocBuilder<RaiseATicketCubit, RaiseATicketState>(
                    buildWhen: (previous, current) {
                      if (current is GetTicketQuerySuccessState) {
                        return true;
                      } else {
                        return false;
                      }
                    },
                    builder: (context, state) {
                      if (state is GetTicketQuerySuccessState) {
                        getTicketQueriesEntity = state.getTicketQueriesEntity;
                        DataManager.instance.storeTicketQueries(state.getTicketQueriesEntity);
                      }
                      return DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 6.0),
                        ),
                        value: selectedQueryId,
                        items: getTicketQueriesEntity?.data
                            .map(
                                (DatumEntity query) => DropdownMenuItem<String>(
                                      value: query.id.toString(),
                                      // Display the query name
                                      child: Text(
                                        query.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontFamily: "AldrichRegular",
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedQueryId = value;
                            print("Selected value $value");
                            if(value == '10'){
                              isOthersSelected = true;
                            }else{
                              isOthersSelected = false;
                            }
                          });
                        },
                        hint: const Text(
                          'Select Ticket Query',
                          style: TextStyle(
                              fontFamily: "AldrichRegular",
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      );
                    },
                  ),
                  if (isOthersSelected) ...[
                    const SizedBox(height: 16.0),
                    const Text(
                      'Please specify your query:',
                      style: TextStyle(
                          fontFamily: "AldrichRegular",
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: otherQueryController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                      ),
                    ),
                  ],
                  // Other form fields remain the same
                  const SizedBox(height: 20.0),
                  const Text(
                    'Description:',
                    style: TextStyle(
                        fontFamily: "AldrichRegular",
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    maxLines: 4,
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Contact Number:',
                                style: TextStyle(
                                    fontFamily: "AldrichRegular",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8.0),
                            TextField(
                              controller: contactNumController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('SAP ID:',
                                style: TextStyle(
                                    fontFamily: "AldrichRegular",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8.0),
                            TextField(
                              controller: sapIdController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  const Text('Email ID:',
                      style: TextStyle(
                          fontFamily: "AldrichRegular",
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: emailIdController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    ),
                  ),

                  const SizedBox(height: 16.0),
                  const Text('Sample Screen Shot',
                      style: TextStyle(
                          fontFamily: "AldrichRegular",
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => _pickImage(ImageSource.camera),
                        child: Chip(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: RAColors.colorM,
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                          avatar: const Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Add Image',
                            style: TextStyle(
                              fontFamily: "AldrichRegular",
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => _pickImage(ImageSource.gallery),
                        child: Chip(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: RAColors.colorM,
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                          avatar: const Icon(
                            Icons.photo_library,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Add Image',
                            style: TextStyle(
                              fontFamily: "AldrichRegular",
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16.0),
                  // Display the selected images in a GridView
                  if (selectedImages.isNotEmpty)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: selectedImages.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Number of columns
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio:
                            0.75, // Adjust aspect ratio for image and text field
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            // Display the image
                            Image.memory(
                              base64Decode(selectedImages[index]['base64']!),
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            ),

                            const SizedBox(height: 8),
                            // Add spacing between image and text field

                            // Add TextFormField for the image title
                            Expanded(
                              child: TextFormField(
                                controller: titleControllers[index],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  const SizedBox(height: 24.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _submitTicket();
                        // Submit the form with all data
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 12.0),
                        backgroundColor: RAColors.colorM,
                      ),
                      child: const Text(
                        'CREATE TICKET',
                        style: TextStyle(
                          fontFamily: "AldrichRegular",
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }

  bool _validateFields() {
    if (selectedQueryId == null) {
      _showError('Please select a query.');
      return false;
    }

    if (isOthersSelected && otherQueryController.text.isEmpty) {
      _showError('Please specify your query.');
      return false;
    }

    if (descriptionController.text.isEmpty) {
      _showError('Please provide a description.');
      return false;
    }
    if (contactNumController.text.isEmpty) {
      _showError('Please enter a contact number.');
      return false;
    }
    if (sapIdController.text.isEmpty) {
      _showError('Please enter your SAP ID.');
      return false;
    }
    if (emailIdController.text.isEmpty) {
      _showError('Please enter your email ID.');
      return false;
    }
    if (selectedImages.isEmpty) {
      _showError('Please upload at least one image.');
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _submitTicket() {
    if (!_validateFields()) return; // Validate before proceeding

    String otherQueries = isOthersSelected ? otherQueryController.text : "";

    List<TicketImage> ticketImages = selectedImages
        .asMap()
        .entries
        .map((entry) => TicketImage(
              id: 0,
              image: entry.value['base64']!,
              title: titleControllers[entry.key].text.toString(),
              fileName: entry.value['fileName']!,
            ))
        .toList();

    InsertTicketInputData ticketData = InsertTicketInputData(
      otherQueries: otherQueries,
      queryType: int.parse(selectedQueryId!),
      description: descriptionController.text,
      emailId: emailIdController.text,
      sapId: sapIdController.text,
      contactNumber: contactNumController.text,
      ticketStatus: '1',
      ticketImages: ticketImages,
    );

    BlocProvider.of<RaiseATicketCubit>(context).createTicket(ticketData);
  }
}

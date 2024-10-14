import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';
import 'package:real_appraiser/features/ra/domain/entities/bank_name_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/fresh_case_entity.dart';
import 'package:real_appraiser/features/ra/domain/usecases/dashboard_usercases.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/dashboard_cubit.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/dashboard_state.dart';
import 'package:real_appraiser/features/ra/presentation/pages/conveyance_report.dart';

import 'package:real_appraiser/features/ra/presentation/pages/homepage.dart';
import 'package:real_appraiser/features/ra/presentation/widgets/custom_appbar.dart';
import 'package:real_appraiser/features/ra/presentation/widgets/custom_drawer.dart';
import 'package:real_appraiser/features/ra/presentation/widgets/highlighted_widget.dart';
import 'package:real_appraiser/features/ra/presentation/widgets/search_dropdowns.dart';
import 'package:real_appraiser/features/ra/presentation/widgets/view_ticket.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  List<DatumEntity> bankName = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController finnoneController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSelectedWidget() {
    switch (_selectedIndex) {
      case 0:
        return Homepage();
      case 1:
        return ConveyanceReport();
      case 2:
        return ViewTicket();
      case 3:
        return TicketsWidget();
      default:
        return Homepage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
        listener: (context, state) {
      if (state is GetFreshCaseSuccessState) {
        showCreateCaseDialog(context, state, []);
      }
      if (state is CreateCaseSuccessState) {
        Fluttertoast.showToast(
            msg: "Case created successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        Modular.to.popAndPushNamed('/${RoutingString.dashBoardScreen}');
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: RAColors.homepageBgColor,
        appBar: const CustomAppbar(title: "Harikrishnan"),
        drawer: const CustomDrawer(),
        body: _getSelectedWidget(),
        bottomNavigationBar: RoundedContainer(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<DashboardCubit>(context).getFreshCase();
                },
                backgroundColor: RAColors.colorM,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30.0), // Set a high border radius to make it rounded
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/cc.svg",
                      color: RAColors.white,
                    ),
                    Text(
                      "Create",
                      style: TextStyle(
                          color: RAColors.white,
                          fontSize: 10,
                          fontFamily: "InterRegular"),
                    ),
                    Text("Case",
                        style: TextStyle(
                            color: RAColors.white,
                            fontSize: 10,
                            fontFamily: "InterRegular"))
                  ],
                ),
              )
            : null,
      );
    });
  }

//working dropdown
  void showCreateCaseDialog(BuildContext context,
      GetFreshCaseSuccessState caseState, List<DatumEntity> bankName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            DatumEntity? selectedBank;
            PropertyTypeEntity? selectedPropertyType;
            CaseAdminEntity? selectedCaseAdmin;
            CaseAdminEntity? selectedReportMaker;

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              title: Center(
                child: Text(
                  'Create Case',
                  style: TextStyle(
                      color: RAColors.colorM,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "AldrichRegular"),
                ),
              ),
              content: BlocConsumer<DashboardCubit, DashboardState>(
                listener: (context, state) {
                  if (state is GetBankNameSuccessState) {
                    setState(() {
                      bankName = state.bankNameEntity
                          .data; // Update bank list in the dialog
                    });
                  }
                },
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildTextField('Applicant Name', ""),
                          _buildDropdownField(
                            context,
                            'Property Type',
                            caseState.getFreshCaseEntity.data.propertyType,
                            'Select Property Type',
                            (PropertyTypeEntity? newValue) {
                              setState(() {
                                if (newValue != null) {
                                  selectedPropertyType = newValue;
                                  RAUtilis.setStorage(StorageString.pId,
                                      newValue.typeOfPropertyId.toString());
                                  // Fetch bank names based on property type
                                  BlocProvider.of<DashboardCubit>(context)
                                      .getBankName(
                                          newValue.typeOfPropertyId.toString());
                                }
                                // Request new bank names
                              });
                            },
                          ),
                          _buildDropdownFieldBank(
                            context,
                            'Bank Name',
                            bankName, // updated bank name from the state
                            'Select Bank Name',
                            (DatumEntity? newValue) {
                              setState(() {
                                if (newValue != null) {
                                  selectedBank = newValue;
                                  RAUtilis.setStorage(StorageString.bankId,
                                      newValue.bankId.toString());
                                }
                              });
                            },
                          ),
                          _buildTextFieldFin('Finnone ID', ''),
                          _buildDropdownFieldCaseAdmin(
                            'Case Admin',
                            caseState.getFreshCaseEntity.data.caseAdmin,
                            'Select Case Admin',
                            (CaseAdminEntity? newValue) {
                              setState(() {
                                if (newValue != null) {
                                  selectedCaseAdmin = newValue;
                                  RAUtilis.setStorage(StorageString.caId,
                                      newValue.employeeId.toString());
                                  RAUtilis.setStorage(StorageString.caAgencyId,
                                      newValue.agencyBranchId.toString());
                                }
                              });
                            },
                          ),
                          _buildDropdownFieldReportMaker(
                            'Report Maker',
                            caseState.getFreshCaseEntity.data.reportMaker,
                            'Select Report Maker',
                            (CaseAdminEntity? newValue) {
                              setState(() {
                                if (newValue != null) {
                                  selectedReportMaker = newValue;
                                  RAUtilis.setStorage(StorageString.rmId,
                                      newValue.employeeId.toString());
                                  RAUtilis.setStorage(StorageString.rmAgencyId,
                                      newValue.agencyBranchId.toString());
                                }
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: RAColors.colorM,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text('CANCEL',
                                    style: TextStyle(
                                        color: RAColors.white,
                                        fontSize: 12,
                                        fontFamily: "InterRegular")),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  CreateCaseData c = CreateCaseData(
                                      applicantName: nameController.text,
                                      propertyType: RAUtilis.getStorage(
                                          StorageString.pId),
                                      bankId: RAUtilis.getStorage(
                                          StorageString.bankId),
                                      createdBy: RAUtilis.getStorage(
                                          StorageString.loginId),
                                      caseAdminId: RAUtilis.getStorage(
                                          StorageString.caId),
                                      reportMakerId: RAUtilis.getStorage(
                                          StorageString.rmId),
                                      agencyBranchId: RAUtilis.getStorage(
                                          StorageString.branchId),
                                      assignedBranchId: RAUtilis.getStorage(
                                          StorageString.branchId),
                                      fsAgencyBranchId: RAUtilis.getStorage(
                                          StorageString.branchId),
                                      bankReferenceNo: finnoneController.text,
                                      caAgencyBranchId: RAUtilis.getStorage(
                                          StorageString.caAgencyId),
                                      rmAgencyBranchId: RAUtilis.getStorage(StorageString.rmAgencyId));
                                  BlocProvider.of<DashboardCubit>(context)
                                      .createCase(c);
                                  Navigator.of(context).pop();
                                  // Implement Create functionality here
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: RAColors.colorM,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text('CREATE',
                                    style: TextStyle(
                                        color: RAColors.white,
                                        fontSize: 12,
                                        fontFamily: "InterRegular")),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: TextField(
        controller: nameController,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldFin(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: TextField(
        controller: finnoneController,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}

Widget _buildDropdownField(
  BuildContext c,
  String label,
  List<PropertyTypeEntity> items,
  String hint,
  Function(PropertyTypeEntity?) onChanged,
) {
  // Create a variable to store the selected value
  PropertyTypeEntity? selectedValue;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: DropdownButtonFormField<PropertyTypeEntity>(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      // Convert items to DropdownMenuItem<PropertyTypeEntity>
      items: items.map((PropertyTypeEntity value) {
        return DropdownMenuItem<PropertyTypeEntity>(
          value: value,
          child: Text(
            style: TextStyle(fontSize: 18),
            value.name,
            overflow: TextOverflow.ellipsis,
            maxLines:
                1, // Replace 'name' with the appropriate field in PropertyTypeEntity
          ),
        );
      }).toList(),
      onChanged: onChanged,
      hint: Text(hint),
    ),
  );
}

Widget _buildDropdownFieldBank(
  BuildContext c,
  String label,
  List<DatumEntity> items,
  String hint,
  Function(DatumEntity?) onChanged,
) {
  // Create a variable to store the selected value
  DatumEntity? selectedValue;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: DropdownButtonFormField<DatumEntity>(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      // Convert items to DropdownMenuItem<PropertyTypeEntity>
      items: items.map((DatumEntity value) {
        return DropdownMenuItem<DatumEntity>(
          value: value,
          child: Text(
            style: TextStyle(fontSize: 18),
            value.name,
            overflow: TextOverflow.ellipsis,
            maxLines:
                1, // Replace 'name' with the appropriate field in PropertyTypeEntity
          ),
        );
      }).toList(),
      onChanged: onChanged,
      hint: Text(hint),
    ),
  );
}

Widget _buildDropdownFieldCaseAdmin(
  String label,
  List<CaseAdminEntity> items,
  String hint,
  Function(CaseAdminEntity?) onChanged,
) {
  // Create a variable to store the selected value
  CaseAdminEntity? selectedValue;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: DropdownButtonFormField<CaseAdminEntity>(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      // Convert items to DropdownMenuItem<PropertyTypeEntity>
      items: items.map((CaseAdminEntity value) {
        return DropdownMenuItem<CaseAdminEntity>(
          value: value,
          child: Text(
            style: TextStyle(fontSize: 18),
            value.fullName,
            overflow: TextOverflow.ellipsis,
            maxLines:
                1, // Replace 'name' with the appropriate field in PropertyTypeEntity
          ),
        );
      }).toList(),
      onChanged: onChanged,
      hint: Text(hint),
    ),
  );
}

Widget _buildDropdownFieldReportMaker(
  String label,
  List<CaseAdminEntity> items,
  String hint,
  Function(CaseAdminEntity?) onChanged,
) {
  // Create a variable to store the selected value
  CaseAdminEntity? selectedValue;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: DropdownButtonFormField<CaseAdminEntity>(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      // Convert items to DropdownMenuItem<PropertyTypeEntity>
      items: items.map((CaseAdminEntity value) {
        return DropdownMenuItem<CaseAdminEntity>(
          value: value,
          child: Text(
            style: TextStyle(fontSize: 18),
            value.fullName,
            overflow: TextOverflow.ellipsis,
            maxLines:
                1, // Replace 'name' with the appropriate field in PropertyTypeEntity
          ),
        );
      }).toList(),
      onChanged: onChanged,
      hint: Text(hint),
    ),
  );
}

class RoundedContainer extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const RoundedContainer({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  RoundedContainerState createState() => RoundedContainerState();
}

class RoundedContainerState extends State<RoundedContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildIconColumn(
              selectedIconPath: "assets/png/house_fill.png",
              unselectedIconPath: "assets/png/house.png",
              label: 'Home',
              index: 0,
            ),
            _buildIconColumn(
              selectedIconPath: "assets/png/conveyance_fill.png",
              unselectedIconPath: "assets/png/conveyance.png",
              label: 'Conveyance',
              index: 1,
            ),
            _buildIconColumn(
              selectedIconPath: "assets/png/ticket_fill.png",
              unselectedIconPath: "assets/png/ticket.png",
              label: 'Tickets',
              index: 2,
            ),
            _buildIconColumn(
              selectedIconPath: "assets/png/activity_fill.png",
              unselectedIconPath: "assets/png/activity.png",
              label: 'Activity',
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconColumn({
    required String selectedIconPath,
    required String unselectedIconPath,
    required String label,
    required int index,
  }) {
    bool isSelected = widget.selectedIndex == index;
    String iconPath = isSelected ? selectedIconPath : unselectedIconPath;

    return GestureDetector(
      onTap: () {
        widget.onItemTapped(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            width: 20,
            height: index == 3 ? 20 : 20, // Adjust height if needed
            color: isSelected
                ? RAColors.colorM
                : RAColors.textBlack, // Change color when selected
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? RAColors.colorM : RAColors.textBlack,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// Define your widgets here
class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Home Content'));
  }
}

class ConveyanceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Conveyance Content'));
  }
}

class TicketsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Tickets Content'));
  }
}

class ActivityWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Activity Content'));
  }
}

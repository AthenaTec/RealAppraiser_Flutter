import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/features/ra/presentation/widgets/arrow.dart'; // Assuming this is where your ArrowChipButton is located

class FsDetailPage extends StatefulWidget {
  const FsDetailPage({super.key});

  @override
  State<FsDetailPage> createState() => _FsDetailPageState();
}

class _FsDetailPageState extends State<FsDetailPage> {
  // Map to track which section is expanded or collapsed
  Map<String, bool> sectionVisibility = {
    "General section": true,
    "Locality": false,
    "Property": false,
    "Details of the property": false,
    "NDMA parameters": false,
    "Fair market valuation": false,
  };

  // Callback to toggle visibility based on the label
  void toggleSectionVisibility(String label) {
    setState(() {
      sectionVisibility[label] = !sectionVisibility[label]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArrowChipButton(
              label: "General section",
              isExpanded: sectionVisibility["General section"]!,
              onToggle: () => toggleSectionVisibility("General section"),
            ),
            if (sectionVisibility["General section"]!) buildGeneralSection(),
            ArrowChipButton(
              label: "Locality",
              isExpanded: sectionVisibility["Locality"]!,
              onToggle: () => toggleSectionVisibility("Locality"),
            ),
            if (sectionVisibility["Locality"]!) buildLocalitySection(),
            ArrowChipButton(
              label: "Property",
              isExpanded: sectionVisibility["Property"]!,
              onToggle: () => toggleSectionVisibility("Property"),
            ),
            if (sectionVisibility["Property"]!) buildPropertySection(),
            ArrowChipButton(
              label: "Details of the property",
              isExpanded: sectionVisibility["Details of the property"]!,
              onToggle: () =>
                  toggleSectionVisibility("Details of the property"),
            ),
            if (sectionVisibility["Details of the property"]!)
              buildDetailsSection(),
            ArrowChipButton(
              label: "NDMA parameters",
              isExpanded: sectionVisibility["NDMA parameters"]!,
              onToggle: () => toggleSectionVisibility("NDMA parameters"),
            ),
            if (sectionVisibility["NDMA parameters"]!)
              buildNdmaParametersSection(),
            ArrowChipButton(
              label: "Fair market valuation",
              isExpanded: sectionVisibility["Fair market valuation"]!,
              onToggle: () => toggleSectionVisibility("Fair market valuation"),
            ),
            if (sectionVisibility["Fair market valuation"]!)
              buildFairMarketValuationSection(),
          ],
        ),
      ],
    );
  }

  // These are example placeholder methods for building the sections
  Widget buildGeneralSection() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Purpose",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Type of Loan",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Name of Borrower",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Name of Owner",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Name of Seller",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Owner/Seller Type",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Property Contact Person Name",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Property Contact Person Mobile Number",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Valuation reference no.MRHFL APS NO.*",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.calendar_month,
                    color: RAColors.colorM,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  labelText: "Property Visit Date",
                  border: OutlineInputBorder()),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLocalitySection() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Complete Property Address",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Plot No./House No./Property No.",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Unit No(Flat/Office/Shop No.)",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Survey No/Khasra No./Gut No.",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Village/Post",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Taluka",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "District",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Landmark",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Pin Code",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "GPS Co-ordinates",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      labelText: "Latitude",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      labelText: "Longitude",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Specification of Property Boundaries",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "As per Document",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: "North",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: "South",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: "East",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: "West",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "As per Site - Building/House",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: "North",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: "South",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: "East",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: "West",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "As per Site - For Flat",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: "North",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: "South",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: "East",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: "West",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Type of locality/neighborhood",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText:
                      "Surrounding Development Percentage with respect to basic amenities & habitation",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Adverse feature nearby",
                  border: OutlineInputBorder()),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPropertySection() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Type of Ownership",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Type of Property",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Property Contact Person Name",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Property Contact Person Mobile Number",
                  border: OutlineInputBorder()),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Checkbox(
                    value: false,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    onChanged: (bool? newValue) {}),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Is the construction as per sanctioned plan?",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Ground Coverage",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Plan prepared by",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Architect/Engineer License No.",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Approved Plan No.",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Approved Plan Date",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Authority",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Zoning as per Development Plan",
                  border: OutlineInputBorder()),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Checkbox(
                    value: false,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    onChanged: (bool? newValue) {}),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Is there any demolition risk on property?",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDetailsSection() {
    return  Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Checkbox(
                    value: false,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    onChanged: (bool? newValue) {}),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Lift In Building",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Recommendation Percentage",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Stage of Construction with description of work completed for proposed structure",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Describe the Type of Construction",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "What is the Type of Flooring used?",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Level of maintenance of the property",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "What is the occupancy status of the property",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "What is the name of the Occupant",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Number of Multiple kitchens",
                  border: OutlineInputBorder()),
            ),
          ),

        ],
      ),
    );
  }

  Widget buildNdmaParametersSection() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text("NDMA parameters section content here..."),
    );
  }

  Widget buildFairMarketValuationSection() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text("Fair market valuation content here..."),
    );
  }
}

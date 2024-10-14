import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: RAColors.homepageBgColor,
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  GestureDetector(
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          AssetImage("assets/png/profile_appbar.png"),
                    ),
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        RAUtilis.getStorage(StorageString.name),
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "Welcome",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        _showCustomMenu(context, details.globalPosition);
                      },
                      child: Image.asset(
                        "assets/png/menubar.png",
                        width: 24,
                        height: 24,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomMenu(BuildContext context, Offset position) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    // Add an offset to the position to make the menu appear below the icon
    final double yOffset = 5; // Adjust this value based on the icon size
    final Offset adjustedPosition = Offset(position.dx, position.dy + yOffset);

    showMenu(
      elevation: 4,
      color: RAColors.white,
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromPoints(adjustedPosition, adjustedPosition),
        // Position where the menu will pop up
        Offset.zero & overlay.size, // Boundaries for the menu
      ),
      items: [
        PopupMenuItem<String>(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          value: 'Refresh',
          child: Row(
            children: [
              Icon(
                Icons.refresh,
                color: RAColors.colorM,
                size: 24,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  'Refresh',
                  style: TextStyle(fontFamily: "InterRegular", fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          value: 'Ticket Rise',
          child: Row(
            children: [
              Image.asset(
                "assets/png/ticketrise_m.png",
                width: 20,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  'Ticket Rise',
                  style: TextStyle(fontFamily: "InterRegular", fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          value: 'Non Case Activity',
          child: Row(
            children: [
              Image.asset(
                "assets/png/activity_fill.png",
                width: 20,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  'Non Case Activity',
                  style: TextStyle(fontFamily: "InterRegular", fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          value: 'About',
          child: Row(
            children: [
              Image.asset(
                "assets/png/about_m.png",
                width: 20,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text('About',
                    style: TextStyle(fontFamily: "InterRegular", fontSize: 14)),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          value: 'Logout',
          child: Row(
            children: [
              Image.asset(
                "assets/png/logout_m.png",
                width: 20,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text('Logout',
                    style: TextStyle(fontFamily: "InterRegular", fontSize: 14)),
              ),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        switch (value) {
          case 'Ticket Rise':
            Modular.to.pushNamed('/${RoutingString.raiseATicket}');

            break;

          case 'Non Case Activity':
            Modular.to.pushNamed('/${RoutingString.nonCaseActivityScreen}');

            break;
          case 'About':
            _showAboutDialog(context);
            print('About selected');
            break;
          case 'Logout':
            _showLogoutDialog(context);
            print('Logout selected');
            break;

          case 'Refresh':
            Modular.to.popAndPushNamed('/${RoutingString.dashBoardScreen}');
            break;
        }
      }
    });
  }

  // About dialog
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              SvgPicture.asset(
                "assets/svg/ra_logo.svg",
                width: 50,
                height: 50,
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                  Text("RealAppraiser",style: TextStyle(fontFamily: "AldrichRegular", fontSize: 20,color: RAColors.colorM),),
                  Text("appraisal made easy",style:TextStyle(fontFamily: "AldrichRegular", fontSize: 12 ))

                ],
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'App Version:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text('3.2.0'), // Replace with your app version
              const SizedBox(height: 10),
              const Text(
                'Release Date:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text('October 13, 2024'), // Replace with your release date
              const SizedBox(height: 10),
              const Text(
                'About our application:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
               "Real Appraiser, a mobile app which is designed to help individual agencies, banks, NBFCs in India, to complete their property valuation process in real-time."
              ),
            ],
          ),
          actions: <Widget>[
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
              child: Text(
                'Ok',
                style: TextStyle(fontFamily: "AldrichRegular", fontSize: 15,color: RAColors.white),
              ),
            ),

            // TextButton(
            //   child: const Text('OK',style:TextStyle(fontFamily: "AldrichRegular", fontSize: 16,color: RAColors.colorM )),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
          ],
        );
      },
    );
  }

  // Logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Are you sure want to Logout?",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "AldrichRegular", fontSize: 18),
            ),
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
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    backgroundColor: RAColors.colorM, // Button background color
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('No',  style: TextStyle(fontFamily: "AldrichRegular", fontSize: 15,color: RAColors.white)),
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
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    backgroundColor: RAColors.colorM, // Button background color
                  ),
                  onPressed: () {
                    // Handle "Yes" action here
                    Navigator.of(context).pop(); // Close the dialog
                    // You can perform your action here, e.g., delete an item, etc.
                    Modular.to.popAndPushNamed('/${RoutingString.loginScreen}');
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(fontFamily: "AldrichRegular", fontSize: 15,color: RAColors.white),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.0);
}

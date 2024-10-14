import 'package:flutter/material.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Container(
            width: double.infinity,
            color: RAColors.colorM,
            padding: EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 30,left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile image
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/png/profile_drawer.png"), // Replace with actual image URL
                  ),
                  SizedBox(height: 16.0),
                  // User name and ID
                  Text(
                    RAUtilis.getStorage(StorageString.name),
                    style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold,fontFamily: "AldrichRegular"),
                  ),
                  Text(
                    "Branch : ${RAUtilis.getStorage(StorageString.branchName)}",
                    style: TextStyle(color: Colors.white,fontFamily: "AldrichRegular"),
                  ),
                  SizedBox(height: 8.0),
                  // Edit icon

                ],
              ),
            ),
          ),
          // Email section
          ListTile(
            leading: Icon(Icons.email,size: 20, color: RAColors.colorM),
            title: Text(RAUtilis.getStorage(StorageString.email),style: TextStyle(fontSize: 14,fontFamily: "InterRegular"),),
            onTap: () {
              // Handle email edit
            },
          ),
          // Change Password section
          ListTile(
            leading: Icon(Icons.lock,size: 20, color: RAColors.colorM),
            title: Text('Change Password',style: TextStyle(fontSize: 14,fontFamily: "InterRegular"),),
            trailing: Icon(Icons.edit, color: RAColors.textBlack,size: 20,),
            onTap: () {
              // Handle password change
            },
          ),
        ],
      ),
    );
  }
}

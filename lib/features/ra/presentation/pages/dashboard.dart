import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/dashboard_cubit.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<String> branches = ['Branch 1', 'Branch 2', 'Branch 3'];

  @override
  void initState() {
    BlocProvider.of<DashboardCubit>(context).getEmployeeBranches();
    super.initState();
  }

  List<String> image = [
    'https://cdn.pixabay.com/photo/2021/06/01/07/03/sparrow-6300790_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/10/20/10/58/elephant-2870777_960_720.jpg',
    'https://cdn.pixabay.com/photo/2014/09/08/17/32/humming-bird-439364_960_720.jpg',
    'https://cdn.pixabay.com/photo/2018/05/03/22/34/lion-3372720_960_720.jpg'
  ];
  List<String> title = ['Sparrow', 'Elephant', 'Humming Bird', 'Lion'];

  void showBranchBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 200,
            child: ListView.builder(
                itemCount: branches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(branches[index]),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  );
                }),
          );
        });
  }

  Widget card(String image, String title, BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: ExpansionTileCard(
          leading: CircleAvatar(
            backgroundColor: RAColors.white,
            child: Icon(
              Icons.person,
              color: RAColors.colorPrimaryDark,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Harikrishnan"),
              Text("Case Id: 1234"),
            ],
          ),
          elevation: 2,
          children: [
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.place,
                    color: RAColors.colorPrimaryDark,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Chennai,TamilNadu")
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.call,
                    color: RAColors.colorPrimaryDark,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("7904316384")
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance,
                    color: RAColors.colorPrimaryDark,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("HDFC Bank")
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.location_city,
                    color: RAColors.colorPrimaryDark,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Property Type")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget swipeRight() {
    return ColoredBox(
        color: Colors.green,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "ACCEPT",
              style: TextStyle(color: RAColors.white, fontSize: 21),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }

  Widget swipeLeft() {
    return ColoredBox(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "REJECT",
              style: TextStyle(color: RAColors.white, fontSize: 21),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: RAColors.colorPrimaryDark,
        title: const Text("Hi Krishna"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(onTap: () {}, child: Icon(Icons.logout)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(onTap: () {}, child: Icon(Icons.more_vert)),
          )
        ],
      ),
      backgroundColor: RAColors.white,
      bottomNavigationBar: CurvedNavigationBar(
        color: RAColors.colorPrimaryDark,
        backgroundColor: RAColors.white,
        items: const <Widget>[
          Icon(
            Icons.open_in_browser,
            size: 30,
          ),
          Icon(
            Icons.close_fullscreen_rounded,
            size: 30,
          ),
          Icon(Icons.offline_bolt, size: 30)
        ],
        onTap: (index) {},
      ),
      body: ListView.builder(
          itemCount: image.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(image[index]),
                background: swipeRight(),
                secondaryBackground: swipeLeft(),
                child: card(image[index], title[index], context));
          }),
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       const Text("Welcome to the Dashboard"),
      //       ElevatedButton(
      //           onPressed: () {
      //             showBranchBottomSheet();
      //           },
      //           child: const Text("Choose Branch"))
      //     ],
      //   ),
      // ),
    );
  }
}

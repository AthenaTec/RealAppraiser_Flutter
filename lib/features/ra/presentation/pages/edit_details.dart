import 'package:flutter/material.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/features/ra/presentation/pages/fs_detail_page.dart';
import 'package:real_appraiser/features/ra/presentation/widgets/custom_appbar.dart';
import 'package:real_appraiser/features/ra/presentation/widgets/map_widget.dart';

class EditDetails extends StatefulWidget {
  const EditDetails({super.key});

  @override
  State<EditDetails> createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: '',),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: RAColors.white,
                    border: Border.all(width: 1, color: RAColors.white)
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),

                    color: RAColors.colorM,
                  ),
                  indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: -30, vertical: 0),
                  dividerColor: Colors.transparent,
                  labelStyle: TextStyle(fontSize: 12,
                      fontFamily: "AldrichRegular",
                      color: RAColors.white),
                  unselectedLabelStyle: TextStyle(fontSize: 12,
                      fontFamily: "AldrichRegular",
                      color: RAColors.textBlack),
                  tabs: const [
                    Tab(text: 'Photo/LatLongDetails'),
                    Tab(text: 'Other Details'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(child: MapWidget()),
                  Center(child: FsDetailPage()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

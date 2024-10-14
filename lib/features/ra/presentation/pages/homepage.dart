import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';
import 'package:real_appraiser/features/ra/domain/entities/getcase_byemp_id_entity.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/homepage_cubit.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/homepage_state.dart';
import 'package:real_appraiser/features/ra/presentation/widgets/info_card.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    BlocProvider.of<HomepageCubit>(context).getCaseByEmpId(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomepageCubit, HomepageState>(
        listener: (context, state) {
          if(state is UpdateStatusIdInitialState){
            RAUtilis.showLoader(context);
          }if(state is UpdateStatusIdSuccessState){
            RAUtilis.hideLoader(context);
          }
        },
        buildWhen: (previous, current) {
          if (current is GetCaseByEmpIdSuccessState || current is GetCaseByEmpIdInitialState ) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is GetCaseByEmpIdInitialState ) {
            return const Center(
                child: CircularProgressIndicator(color: RAColors.colorM));
          }
          if (state is GetCaseByEmpIdSuccessState) {
            return DefaultTabController(
              length: 3,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: RAColors.white,
                          border: Border.all(width: 1, color: RAColors.white)),
                      child: TabBar(
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: RAColors.colorM,
                        ),
                        indicatorPadding: const EdgeInsets.symmetric(
                            horizontal: -35, vertical: 0),
                        dividerColor: Colors.transparent,
                        labelStyle: const TextStyle(
                            fontSize: 14,
                            fontFamily: "AldrichRegular",
                            color: RAColors.white),
                        unselectedLabelStyle: const TextStyle(
                            fontSize: 14,
                            fontFamily: "AldrichRegular",
                            color: RAColors.textBlack),
                        tabs: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Tab(text: ' Open '),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Tab(text: 'Closed'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Tab(text: 'Offline'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Center(
                            child: InfoCard(
                          getCaseByEmployeeIdEntity:
                              state.getCaseByEmployeeIdEntity,
                        )),
                        const Center(child: Text('Closed Tab Content')),
                        const Center(child: Text('Offline Tab Content')),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        });
  }
}

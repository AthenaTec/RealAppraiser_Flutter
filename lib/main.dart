import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_storage/get_storage.dart';
import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/features/ra/data/datasources/conveyance_report_datasource.dart';
import 'package:real_appraiser/features/ra/data/datasources/dashboard_datasource.dart';
import 'package:real_appraiser/features/ra/data/datasources/homepage_datasource.dart';
import 'package:real_appraiser/features/ra/data/datasources/login_datasource.dart';
import 'package:real_appraiser/features/ra/data/datasources/non_case_activity_datasource.dart';
import 'package:real_appraiser/features/ra/data/datasources/raise_a_ticket_datasource.dart';
import 'package:real_appraiser/features/ra/data/datasources/view_ticket_datasource.dart';
import 'package:real_appraiser/features/ra/data/datasources/view_ticket_details_datasource.dart';
import 'package:real_appraiser/features/ra/data/repositories/dashboard_repository_impl.dart';
import 'package:real_appraiser/features/ra/data/repositories/homepage_repository_impl.dart';
import 'package:real_appraiser/features/ra/data/repositories/login_repository_impl.dart';
import 'package:real_appraiser/features/ra/data/repositories/non_case_activity_repository_impl.dart';
import 'package:real_appraiser/features/ra/data/repositories/raise_a_ticket_repository_impl.dart';
import 'package:real_appraiser/features/ra/data/repositories/view_ticket_details_repository_impl.dart';
import 'package:real_appraiser/features/ra/data/repositories/view_ticket_repository_impl.dart';
import 'package:real_appraiser/features/ra/domain/repositories/conveyance_report_repository.dart';
import 'package:real_appraiser/features/ra/domain/usecases/conveyance_report_usecases.dart';
import 'package:real_appraiser/features/ra/domain/usecases/dashboard_usercases.dart';
import 'package:real_appraiser/features/ra/domain/usecases/homepage_usecases.dart';
import 'package:real_appraiser/features/ra/domain/usecases/login_usecases.dart';
import 'package:real_appraiser/features/ra/domain/usecases/non_case_activity_usecases.dart';
import 'package:real_appraiser/features/ra/domain/usecases/raise_a_ticket_usecases.dart';
import 'package:real_appraiser/features/ra/domain/usecases/view_ticket_details_usecases.dart';
import 'package:real_appraiser/features/ra/domain/usecases/view_ticket_usecases.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/conveyance_report_cubit.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/dashboard_cubit.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/homepage_cubit.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/login_cubit.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/non_case_activity_cubit.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/view_ticket_cubit.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/view_ticket_details_cubit.dart';
import 'package:real_appraiser/features/ra/presentation/pages/dashboard.dart';
import 'package:real_appraiser/features/ra/presentation/pages/edit_details.dart';
import 'package:real_appraiser/features/ra/presentation/pages/fs_detail_page.dart';
import 'package:real_appraiser/features/ra/presentation/pages/homepage.dart';
import 'package:real_appraiser/features/ra/presentation/pages/loginscreen.dart';
import 'package:real_appraiser/features/ra/presentation/pages/non_case_activity.dart';
import 'package:real_appraiser/features/ra/presentation/pages/test.dart';
import 'package:real_appraiser/features/ra/presentation/pages/ticket_raising_screen.dart';

import 'common_utilis/colors.dart';
import 'features/ra/data/repositories/conveyance_report_impl.dart';
import 'features/ra/presentation/cubit/raise_a_ticket_cubit.dart';
import 'features/ra/presentation/pages/login.dart';
import 'features/ra/presentation/pages/splashscreen.dart';
import 'features/ra/presentation/pages/view_ticket_detail_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(statusBarColor: RAColors.new1));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);

  GetStorage.init();
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (context) => const SplashScreen(),
        transition: TransitionType.noTransition);
    r.child('/${RoutingString.loginScreen}',
        child: (context) => const Login(),
        transition: TransitionType.noTransition);
    r.child('/${RoutingString.dashBoardScreen}',
        child: (context) => const DashboardScreen(),
        transition: TransitionType.noTransition);
    r.child('/${RoutingString.homePageScreen}',
        child: (context) => const Homepage(),
        transition: TransitionType.noTransition);
    r.child('/${RoutingString.editDetailsSScreen}',
        child: (context) => const EditDetails(),
        transition: TransitionType.noTransition);
    r.child('/${RoutingString.nonCaseActivityScreen}',
        child: (context) => const NonCaseActivityScreen(),
        transition: TransitionType.noTransition);
    r.child('/${RoutingString.raiseATicket}',
        child: (context) => const TicketRaisingScreen(),
        transition: TransitionType.noTransition);
    r.child('/${RoutingString.viewTicketDetailScreen}',
        child: (context) => const ViewTicketDetailScreen(),
        transition: TransitionType.noTransition);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(
                loginUseCases: LoginUseCases(
                    loginRepository: LoginRepositoryImpl(
                        loginDataSource: LoginDataSourceImpl())))),
        BlocProvider<DashboardCubit>(
            create: (context) => DashboardCubit(
                dashboardUseCases: DashboardUseCases(
                    dashBoardRepository: DashBoardRepositoryImpl(
                        dashBoardDataSource: DashBoardDataSourceImpl())))),
        BlocProvider<HomepageCubit>(
            create: (context) => HomepageCubit(
                homepageUsecases: HomepageUsecases(
                    homepageRepository: HomepageRepositoryImpl(
                        homepageDatasource: HomepageDatasourceImpl())))),
        BlocProvider<ConveyanceReportCubit>(
            create: (context) => ConveyanceReportCubit(
                conveyanceReportUseCases: ConveyanceReportUseCases(
                    conveyanceReportRepository: ConveyanceReportImpl(
                        conveyanceReportDatasource:
                            ConveyanceReportDataSourceImpl())))),
        BlocProvider<NonCaseActivityCubit>(
            create: (context) => NonCaseActivityCubit(
                nonCaseActivityUseCases: NonCaseActivityUseCases(
                    nonCaseActivityRepository: NonCaseActivityRepositoryImpl(
                        nonCaseActivityDatasource:
                            NonCaseActivityDataSourceImpl())))),
        BlocProvider<RaiseATicketCubit>(
            create: (context) => RaiseATicketCubit(
                raiseATicketUseCases: RaiseATicketUseCases(
                    raiseATicketRepository: RaiseATicketRepositoryImpl(
                        raiseATicketDatasource:
                            RaiseATicketDatasourceImpl())))),
        BlocProvider<ViewTicketCubit>(
            create: (context) => ViewTicketCubit(
                viewTicketUseCases: ViewTicketUseCases(
                    viewTicketRepository: ViewTicketRepositoryImpl(
                        viewTicketDatasource: ViewTicketDatasourceImpl())))),
        BlocProvider<ViewTicketDetailsCubit>(
            create: (context) => ViewTicketDetailsCubit(
                viewTicketDetailsUseCases: ViewTicketDetailsUseCases(
                    viewTicketDetailsRepository:
                        ViewTicketDetailsRepositoryImpl(
                            viewTicketDetailsDatasource:
                                ViewTicketDetailsDatasourceImpl())))),
      ],
      child: MaterialApp.router(
        title: 'Real Appraiser',
        theme: ThemeData(
            fontFamily: "UbuntuRegular",
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        builder: (context, myChild) {
          final queryData = MediaQuery.of(context);
          myChild = EasyLoading.init()(context, myChild);
          myChild = MediaQuery(
            data: queryData.copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: myChild,
          );

          return myChild;
        },
        debugShowCheckedModeBanner: false,
        routerConfig: Modular.routerConfig,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

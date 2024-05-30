import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_storage/get_storage.dart';
import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/features/ra/data/datasources/dashboard_datasource.dart';
import 'package:real_appraiser/features/ra/data/datasources/login_datasource.dart';
import 'package:real_appraiser/features/ra/data/repositories/dashboard_repository_impl.dart';
import 'package:real_appraiser/features/ra/data/repositories/login_repository_impl.dart';
import 'package:real_appraiser/features/ra/domain/usecases/dashboard_usercases.dart';
import 'package:real_appraiser/features/ra/domain/usecases/login_usecases.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/dashboard_cubit.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/login_cubit.dart';
import 'package:real_appraiser/features/ra/presentation/pages/dashboard.dart';
import 'package:real_appraiser/features/ra/presentation/pages/loginscreen.dart';
import 'package:real_appraiser/features/ra/presentation/pages/test.dart';

import 'common_utilis/colors.dart';
import 'features/ra/presentation/pages/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: RAColors.colorPrimaryDark));
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
        child: (context) => const LoginScreen(),
        transition: TransitionType.noTransition);
    r.child('/${RoutingString.dashBoardScreen}',
        child: (context) => const DashboardScreen(),
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

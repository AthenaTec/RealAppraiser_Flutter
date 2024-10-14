import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/features/ra/presentation/widgets/ra_button.dart';
import 'package:real_appraiser/features/ra/presentation/widgets/ra_textfield.dart';

import '../../../../common_utilis/utilis.dart';
import '../../domain/entities/employee_branch_entity.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

bool isBranchSelected = false;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  bool isEmailValid = false;
  String emailErrorText = "";
  bool isPasswordVisible = false;
  bool isShowPassword = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
        if (state is GetStoreInitialState ||
            state is SecurityTokenInitialState ||
            state is EmployeeBranchInitialState ||
            state is AuthenticateUserInitialState) {
          RAUtilis.showLoader(context);
        }
        if (state is GetStoreSuccessState ||
            state is AuthenticateUserSuccessState ||
            state is AuthenticateUserErrorState ||
            state is EmployeeBranchSuccessState) {
          RAUtilis.hideLoader(context);
        }
        if (state is SecurityTokenSuccessState) {
          RAUtilis.hideLoader(context);
          if (isBranchSelected) {
            Modular.to.popAndPushNamed('/${RoutingString.dashBoardScreen}');
          } else {
            BlocProvider.of<LoginCubit>(context).getEmployeeBranches(context);
          }
        }
        if (state is EmployeeBranchSuccessState) {
          RAUtilis.hideLoader(context);
          List<EmployeeBranchDatumEntity> branchList =
              state.employeeBranchEntity.data;
          showMyBottomSheet(context, branchList);
        }
        if(state is AuthenticateUserErrorState){
          RAUtilis.hideLoader(context);
          Fluttertoast.showToast(msg: state.message);
        }
      }, builder: (context, state) {
        return Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: SvgPicture.asset(
                    "assets/svg/ra_logo.svg",
                    width: 112,
                    height: 93,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    LoginString.loginTitle,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: "AldrichRegular"),
                  ),
                ),
                Text(
                  LoginString.loginDescription,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: "InterRegular"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 40),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        LoginString.emailAddress,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: "InterRegular"),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: RATextField(
                    hintText: 'Enter email',
                    controller: emailController!,
                    keyboardType: TextInputType.emailAddress,
                    onSubmitted: (v) {},
                  ),
                ),

                // Padding(
                //   padding:
                //       const EdgeInsets.only(top: 30, left: 20, right: 20),
                //   child: RAButton(
                //       text: LoginString.validateEmail,
                //       onPressed: () {
                //         isEmailValid = RAUtilis.isValidEmail(
                //             emailController!.text.toString());
                //
                //         if (isEmailValid) {
                //           RAUtilis.setStorage(
                //               StorageString.email, emailController!.text);
                //           BlocProvider.of<LoginCubit>(context)
                //               .getStore(emailController!.text, "", context);
                //         } else {
                //           Fluttertoast.showToast(msg: "Enter a valid email");
                //         }
                //       }),
                // ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(LoginString.password,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: "InterRegular"))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: RATextField(
                    obscureText: !isShowPassword,
                    hintText: 'Enter password',
                    controller: passwordController!,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isShowPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                    ),
                    onSubmitted: (v) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: RAButton(
                      text: LoginString.loginBtn,
                      onPressed: () {
                        // showMyBottomSheet(context);
                        if (emailController!.text.isNotEmpty &&
                            passwordController!.text.isNotEmpty) {
                          isEmailValid = RAUtilis.isValidEmail(
                              emailController!.text.toString());

                          if (isEmailValid) {
                            print(passwordController!.text);
                            RAUtilis.setStorage(
                                StorageString.email, emailController!.text);
                            RAUtilis.setStorage(
                                StorageString.pKey, passwordController!.text);
                            BlocProvider.of<LoginCubit>(context)
                                .getStore(emailController!.text, "", context);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Kindly Enter Valid Email Address");
                          }
                        } else {
                          if (emailController!.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Kindly Enter Email Address");
                          } else {
                            Fluttertoast.showToast(
                                msg: "Kindly Enter  Password");
                          }
                        }
                      }),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/png/group.png",
                color: RAColors.colorM,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Version: ${RAUtilis.getStorage(StorageString.appVersion)}",
                        style: const TextStyle(
                            fontSize: 12,
                            color: RAColors.white,
                            fontFamily: "InterRegular"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("Date: ${RAString.versionDate}",
                          style: const TextStyle(
                              fontSize: 12,
                              color: RAColors.white,
                              fontFamily: "InterRegular"))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                        "\u00A9 ${DateTime.now().year.toString()} ${RAString.copyrightText}",
                        style: const TextStyle(
                            fontSize: 12,
                            color: RAColors.white,
                            fontFamily: "InterRegular")),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

bool isValidPassword(String password) {
  // Regular expression for password validation
  String pattern = r'^(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$';
  RegExp regex = RegExp(pattern);
  return regex.hasMatch(password);
}

// Method to show the bottom sheet
void showMyBottomSheet(
    BuildContext context, List<EmployeeBranchDatumEntity> branchList) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select an Branch',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: RAColors.colorM,
                  fontFamily: "AldrichRegular"),
            ),
            SizedBox(height: 16),
            // Call the method to build the list
            buildList(branchList),
          ],
        ),
      );
    },
  );
}

// Method to build the list of items
Widget buildList(List<EmployeeBranchDatumEntity> branchList) {
  return ListView.separated(
    shrinkWrap: true, // To make the list view fit inside the bottom sheet
    itemCount: branchList.length,
    separatorBuilder: (BuildContext context, int index) {
      return Divider();
    },
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0.0),
        // Reduce padding inside each ListTile

        title: Text(branchList[index].branchName),
        onTap: () {
          isBranchSelected = true;

          RAUtilis.setStorage(
              StorageString.branchName, branchList[index].branchName);
          RAUtilis.setStorage(StorageString.branchId,
              branchList[index].agencyBranchId.toString());
          print(branchList[index].agencyBranchId.toString());
          // Handle item tap
          Navigator.pop(context);

          String email = RAUtilis.getStorage(StorageString.email);
          BlocProvider.of<LoginCubit>(context)
              .getStore(email, "login", context);

          // Modular.to.popAndPushNamed('/${RoutingString.dashBoardScreen}');
// Close the bottom sheet
        },
      );
    },
  );
}

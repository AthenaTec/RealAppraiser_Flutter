import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_appraiser/common_utilis/colors.dart';
import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/login_cubit.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/login_state.dart';
import 'package:real_appraiser/features/ra/presentation/widgets/ra_button.dart';
import 'package:real_appraiser/features/ra/presentation/widgets/ra_textfield.dart';
import '../widgets/curve_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextEditingController? serverUrlController =
  //     TextEditingController(text: 'https://');
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  bool isEmailValid = false;
  String emailErrorText = "";
  bool isPasswordVisible = false;

  // bool isUrlSet = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
        if (state is SecurityTokenSuccessState) {
          Modular.to.popAndPushNamed('/${RoutingString.dashBoardScreen}');
        }

      }, builder: (context, state) {
        if (state is LoginPasswordVisibilityState) {
          isPasswordVisible = state.isPasswordVisible;
        }
        return Stack(
          children: [
            Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/png/background.png"),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Email
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          LoginString.email,
                          style: const TextStyle(
                              color: RAColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                          fontFamily: "InterRegular"),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: RATextField(
                        controller: emailController!,
                        hintText: 'Enter Email',
                        keyboardType: TextInputType.emailAddress,
                        onSubmitted: (v) {
                          isEmailValid = RAUtilis.isValidEmail(v);

                          if (isEmailValid) {
                            BlocProvider.of<LoginCubit>(context)
                                .getStore(emailController!.text, "",context);
                          } else {
                            Fluttertoast.showToast(msg: "Enter a valid email");
                          }
                        },
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: RAColors.test,
                        ),
                      ),
                    ),

                    if (isPasswordVisible) ...[
                      //Password
                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            LoginString.password,
                            style: const TextStyle(
                                color: RAColors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                            fontFamily: "InterRegular"),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: RATextField(
                          controller: passwordController!,
                          hintText: 'Enter Password',
                          prefixIcon: const Icon(
                            Icons.lock_open_outlined,
                            color: RAColors.test,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: RAButton(
                            text: LoginString.loginBtn,
                            onPressed: () {
                              if (emailController!.text.isNotEmpty &&
                                  passwordController!.text.isNotEmpty) {
                                print(passwordController!.text);
                                BlocProvider.of<LoginCubit>(context)
                                    .authenticateUser(emailController!.text,
                                        passwordController!.text,context);
                              }
                            }),
                      ),
                    ]
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        LoginString.footerOne,
                        style: const TextStyle(
                            color: RAColors.white, fontSize: 14),
                      ),
                      Text(
                        LoginString.footerTwo,
                        style: const TextStyle(
                            color: RAColors.white, fontSize: 14),
                      ),
                    ],
                  )),
            ),
            ClipPath(
              clipper: BezierClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height / 3.8,
                color: Colors.white,
                child: Center(
                    child: Transform.scale(
                        scale: 0.7,
                        child: Image.asset(
                          "assets/png/ra_logo.png",
                          width: 300,
                          height: 250,
                        ))),
              ),
            ),
          ],
        );
      }),
    );
  }
}

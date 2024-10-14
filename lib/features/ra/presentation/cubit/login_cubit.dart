import 'package:encrypt/encrypt.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';
import 'package:real_appraiser/features/ra/domain/usecases/login_usecases.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/login_state.dart';

String dataKey = "";

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUseCases}) : super(LoginInitialState());
  LoginUseCases loginUseCases;
  bool isPasswordVisible = false;

  Future submitUrl(String url) async {
    try {
      emit(SubmitUrlInitialState());
      var result = await loginUseCases.submitUrl(url);
      result.fold((failure) {
        emit(SubmitUrlErrorState(message: failure.message));
      }, (data) {
        print("HHHHHHHHH");
        emit(SubmitUrlSuccessState(loginEntity: data));
      });
    } catch (e) {
      emit(SubmitUrlErrorState(message: e.toString()));
    }
  }

  Future getStore(
    String email,
    String login,
    BuildContext c,
  ) async {
    try {
      emit(GetStoreInitialState());
      var result = await loginUseCases.getStore(email, c);
      result.fold((failure) {
        emit(GetStoreErrorState(message: failure.message));
      }, (data) async {
        print("GetStoreSuccess");
        if (login.isEmpty) {
          dataKey = data.data.toString();
          print(data.msg);
          print(data.data);
          String pass = RAUtilis.getStorage(StorageString.pKey);
         await authenticateUser(email, pass, c);
        } else {
          print("second time getstore");
          String pass = RAUtilis.getStorage(StorageString.pKey);
          Encrypted encrypted = RAUtilis.encryptWithAES(data.data, pass);
          await securityToken(email, encrypted.base64, c);
        }
      });
    } catch (e) {
      emit(GetStoreErrorState(message: e.toString()));
    }
  }

  Future authenticateUser(String email, String password, BuildContext c) async {
    try {
      emit(AuthenticateUserInitialState());
      String getStoreData = RAUtilis.getStorage(StorageString.getStoreKey);
      print("getStoredata===> $getStoreData");
      Encrypted encryptPswd = RAUtilis.encryptWithAES(dataKey, password);
      print(encryptPswd.base64);

      var result =
          await loginUseCases.authenticateUser(email, encryptPswd.base64, c);
      result.fold((failure) {
        print("authenticateUser failed");
        emit(AuthenticateUserErrorState(message: failure.message));
      }, (data) async {
        print("authenticateUser");
        emit(AuthenticateUserSuccessState(authenticateUserEntity: data));
        RAUtilis.setStorage(
            StorageString.loginId, data.data.loginId.toString());
        RAUtilis.setStorage(
            StorageString.empId, data.data.employeeId.toString());
        RAUtilis.setStorage(StorageString.name, data.data.firstName);
        RAUtilis.setStorage(
            StorageString.agencyId, data.data.agencyId.toString());
        print(
            "LoginID==> ${data.data.loginId.toString()}  || ${data.data.employeeId.toString()}");
        await securityToken(email, encryptPswd.base64, c);
      });
    } catch (e) {
      emit(AuthenticateUserErrorState(message: e.toString()));
    }
  }

  Future securityToken(String email, String password, BuildContext c) async {
    try {
      emit(SecurityTokenInitialState());
      var result = await loginUseCases.securityToken(email, password, c);
      result.fold((failure) {
        emit(SecurityTokenErrorState(message: failure.message));
      }, (data) {
        print("securityTokenSuccess==>  ${data.accessToken}");
        RAUtilis.setStorage(StorageString.accessToken, data.accessToken);
        emit(SecurityTokenSuccessState(securityTokenEntity: data));
      });
    } catch (e) {
      emit(SecurityTokenErrorState(message: e.toString()));
    }
  }

  Future getEmployeeBranches(BuildContext c) async {
    try {
      emit(EmployeeBranchInitialState());
      var result = await loginUseCases.getEmployeeBranch(c);
      result.fold((failure) {
        emit(EmployeeBranchErrorState(message: failure.message));
      }, (data) {
        print("employeebranch");
        emit(EmployeeBranchSuccessState(employeeBranchEntity: data));
      });
    } catch (e) {
      emit(EmployeeBranchErrorState(message: e.toString()));
    }
  }
}

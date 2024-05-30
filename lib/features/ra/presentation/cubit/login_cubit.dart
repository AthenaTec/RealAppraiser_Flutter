import 'package:encrypt/encrypt.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_appraiser/common_utilis/encryption.dart';
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

  Future getStore(String email) async {
    try {
      emit(GetStoreInitialState());
      var result = await loginUseCases.getStore(email);
      result.fold((failure) {
        emit(GetStoreErrorState(message: failure.message));
      }, (data) {
        print("GetStoreSuccess");
        emit(GetStoreSuccessState(getStoreEntity: data));
        dataKey = data.data.toString();
        print(data.msg);
        print(data.data);
        isPasswordVisible = true;
        emit(
            LoginPasswordVisibilityState(isPasswordVisible: isPasswordVisible));
      });
    } catch (e) {
      emit(GetStoreErrorState(message: e.toString()));
    }
  }

  Future authenticateUser(String email, String password) async {
    try {
      emit(AuthenticateUserInitialState());
      String getStoreData = RAUtilis.getStorage(StorageString.getStoreKey);
      print("getStoredata===> $getStoreData");
      Encrypted encryptPswd = RAUtilis.encryptWithAES(dataKey, password);
      print(encryptPswd.base64);

      var result =
          await loginUseCases.authenticateUser(email, encryptPswd.base64);
      result.fold((failure) {
        print("authenticateUser failed");
        emit(AuthenticateUserErrorState(message: failure.message));
      }, (data) async {
        print("authenticateUser");
        emit(AuthenticateUserSuccessState(authenticateUserEntity: data));
        RAUtilis.setStorage(StorageString.loginId, data.data.loginId.toString());
        await securityToken(email, encryptPswd.base64);
      });
    } catch (e) {
      emit(AuthenticateUserErrorState(message: e.toString()));
    }
  }

  Future securityToken(String email, String password) async {
    try {
      emit(SecurityTokenInitialState());
      var result = await loginUseCases.securityToken(email, password);
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
}

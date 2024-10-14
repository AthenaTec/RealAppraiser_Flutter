import 'package:equatable/equatable.dart';
import 'package:real_appraiser/features/ra/domain/entities/authenticate_user_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_store_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/login_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/security_token_entity.dart';

import '../../domain/entities/employee_branch_entity.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class SubmitUrlInitialState extends LoginState {}

class SubmitUrlSuccessState extends LoginState {
  final LoginEntity loginEntity;

  const SubmitUrlSuccessState({required this.loginEntity});
}

class SubmitUrlErrorState extends LoginState {
  final String message;

  const SubmitUrlErrorState({required this.message});
}

class GetStoreInitialState extends LoginState {}

class GetStoreSuccessState extends LoginState {
  final GetStoreEntity getStoreEntity;

  const GetStoreSuccessState({required this.getStoreEntity});
}

class GetStoreErrorState extends LoginState {
  final String message;

  const GetStoreErrorState({required this.message});
}

class AuthenticateUserInitialState extends LoginState {}

class AuthenticateUserSuccessState extends LoginState {
  final AuthenticateUserEntity authenticateUserEntity;

  const AuthenticateUserSuccessState({required this.authenticateUserEntity});
}

class AuthenticateUserErrorState extends LoginState {
  final String message;

  const AuthenticateUserErrorState({required this.message});
}

class LoginPasswordVisibilityState extends LoginState {
  final bool isPasswordVisible;

  const LoginPasswordVisibilityState({required this.isPasswordVisible});

  @override
  List<Object> get props => [isPasswordVisible];
}



class SecurityTokenInitialState extends LoginState {}

class SecurityTokenSuccessState extends LoginState {
  final  SecurityTokenEntity securityTokenEntity;

  const SecurityTokenSuccessState({required this.securityTokenEntity});

}

class SecurityTokenErrorState extends LoginState {
  final String message;

  const SecurityTokenErrorState({required this.message});
}

class EmployeeBranchInitialState extends LoginState {}

class EmployeeBranchSuccessState extends LoginState {
  final EmployeeBranchEntity employeeBranchEntity;

  const EmployeeBranchSuccessState({required this.employeeBranchEntity});
}

class EmployeeBranchErrorState extends LoginState {
  final String message;

  const EmployeeBranchErrorState({required this.message});
}

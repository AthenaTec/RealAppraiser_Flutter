import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/data/datasources/login_datasource.dart';
import 'package:real_appraiser/features/ra/domain/entities/authenticate_user_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/employee_branch_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_store_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/login_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/security_token_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  LoginRepositoryImpl({required this.loginDataSource});

  final LoginDataSource loginDataSource;

  @override
  Future<Either<Failure, LoginEntity>> submitUrl(String url) async {
    try {
      var result = await loginDataSource.submitUrl(url);
      if (result is LoginEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetStoreEntity>> getStore(String email,BuildContext c) async {
    try {
      var result = await loginDataSource.getStore(email,c);
      if (result is GetStoreEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthenticateUserEntity>> authenticateUser(
      String email, String password,BuildContext c) async {
    try {
      var result = await loginDataSource.authenticateUser(email, password,c);
      if (result is AuthenticateUserEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SecurityTokenEntity>> securityToken(
      String email, String password,BuildContext c) async {
    try {
      var result = await loginDataSource.securityToken(email, password,c);
      if (result is SecurityTokenEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EmployeeBranchEntity>> getEmployeeBranch(BuildContext c) async {
    try {
      var result = await loginDataSource.getEmployeeBranch(c);
      if (result is EmployeeBranchEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_appraiser/features/ra/domain/usecases/dashboard_usercases.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({required this.dashboardUseCases})
      : super(DashboardStateInitialState());
  DashboardUseCases dashboardUseCases;

  Future getEmployeeBranches() async {
    try {
      emit(EmployeeBranchInitialState());
      var result = await dashboardUseCases.getEmployeeBranch();
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

  Future getFreshCase() async {
    try {
      emit(GetFreshCaseInitialState());
      var result = await dashboardUseCases.getFreshCase();
      result.fold((failure) {
        emit(GetFreshCaseErrorState(message: failure.message));
      }, (data) {
        print("GetFreshCaseSuccess==> $data");
        emit(GetFreshCaseSuccessState(getFreshCaseEntity: data));
      });
    } catch (e) {
      emit(GetFreshCaseErrorState(message: e.toString()));
    }
  }

  Future getBankName(String id) async {
    try {
      emit(GetBankNameInitialState());
      var result = await dashboardUseCases.getBankName(id);
      result.fold((failure) {
        emit(GetBankNameErrorState(message: failure.message));
      }, (data) {
        print("GetFreshCaseSuccess==> $data");
        emit(GetBankNameSuccessState(bankNameEntity: data));
      });
    } catch (e) {
      emit(GetBankNameErrorState(message: e.toString()));
    }
  }

  Future createCase(CreateCaseData createCaseData) async {
    try {
      emit(CreateCaseInitialState());
      var result = await dashboardUseCases.createCase(createCaseData);
      result.fold((failure) {
        emit(CreateCaseErrorState(message: failure.message));
      }, (data) {
        print("CreatecaseSuccess==> $data");
        emit(CreateCaseSuccessState(createCaseEntity: data));
      });
    } catch (e) {
      emit(CreateCaseErrorState(message: e.toString()));
    }
  }
}

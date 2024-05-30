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
}

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_appraiser/features/ra/domain/usecases/homepage_usecases.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit({required this.homepageUsecases})
      : super(HomepageInitialState());
  HomepageUsecases homepageUsecases;

  Future getCaseByEmpId(BuildContext c) async {
    try {
      emit(GetCaseByEmpIdInitialState());
      var result = await homepageUsecases.getCaseByEmpId(c);
      result.fold((failure) {
        emit(GetCaseByEmpIdErrorState(message: failure.message));
      }, (data) {
        print("GetCaseByEmpIdSuccessState==> $data");
        emit(GetCaseByEmpIdSuccessState(getCaseByEmployeeIdEntity: data));
      });
    } catch (e) {
      emit(GetCaseByEmpIdErrorState(message: e.toString()));
    }
  }

  Future updateStatusByCaseId(String caseId, String status,int index) async {
    try {
      emit(UpdateStatusIdInitialState());
      var result = await homepageUsecases.updateStatusByCaseId(caseId, status);
      result.fold((failure) {
        emit(UpdateStatusIdErrorState(message: failure.message));
      }, (data) {
        print("UpdateStatusIdSuccessState==> $data");
        emit(UpdateStatusIdSuccessState(updateCaseStatusByIdEntity: data,index: index));
      });
    } catch (e) {
      emit(UpdateStatusIdErrorState(message: e.toString()));
    }
  }
}

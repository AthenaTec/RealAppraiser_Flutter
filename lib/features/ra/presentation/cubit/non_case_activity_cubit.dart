import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_appraiser/features/ra/domain/usecases/non_case_activity_usecases.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/non_case_activity_state.dart';

class NonCaseActivityCubit extends Cubit<NonCaseActivityState> {
  NonCaseActivityCubit({required this.nonCaseActivityUseCases})
      : super(NonCaseActivityInitialState());
  NonCaseActivityUseCases nonCaseActivityUseCases;

  Future loadNonCaseActivity() async {
    try {
      emit(LoadNonCaseActivityInitialState());
      var result = await nonCaseActivityUseCases.loadNonCaseActivity();
      result.fold((failure) {
        emit(LoadNonCaseActivityErrorState(message: failure.message));
      }, (data) {
        print("loadNonCaseActivitiesEntity");
        emit(
            LoadNonCaseActivitySuccessState(loadNonCaseActivitiesEntity: data));
      });
    } catch (e) {
      emit(LoadNonCaseActivityErrorState(message: e.toString()));
    }
  }

  Future fsTrackerDetails(NonCaseActivityInput inputData) async {
    try {
      emit(FSTrackerDetailsInitialState());
      var result = await nonCaseActivityUseCases.fsTrackerDetails(inputData);
      result.fold((failure) {
        emit(FSTrackerDetailsErrorState(message: failure.message));
      }, (data) {
        print("FSTrackerDetailsSuccessState");
        emit(FSTrackerDetailsSuccessState(fsTrackerEntity: data));
      });
    } catch (e) {
      emit(FSTrackerDetailsErrorState(message: e.toString()));
    }
  }
}

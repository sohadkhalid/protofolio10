import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingState()) {
    on<NextPageEvent>((event, emit) {
      emit(OnboardingState(pageIndex: state.pageIndex + 1));
    });
    on<UpdatePageIndexEvent>((event, emit) {
      emit(OnboardingState(pageIndex: event.newIndex));
    });

    on<SkipEvent>((event, emit) {
      emit(state.copyWith(pageIndex: 3)); //to the next page
    });
  }
}

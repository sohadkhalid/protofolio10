part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NextPageEvent extends OnboardingEvent {}

class SkipEvent extends OnboardingEvent {}

class ContinueButtonPressed extends OnboardingEvent {}

class UpdatePageIndexEvent extends OnboardingEvent {
  final int newIndex;
  UpdatePageIndexEvent(this.newIndex);
}

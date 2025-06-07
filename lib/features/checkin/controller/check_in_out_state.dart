abstract class CheckInOutState {}

class CheckInOutInitial extends CheckInOutState {}

class CheckInOutLoading extends CheckInOutState {}

class CheckInOutSuccess extends CheckInOutState {}

class CheckInOutFailure extends CheckInOutState {
  final String errorMessage;
  CheckInOutFailure({required this.errorMessage});
}

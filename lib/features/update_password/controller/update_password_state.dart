enum UpdateStep { idle, emailSent, otpVerified, passwordUpdated }

enum UpdateStatus { idle, loading, success, error }

class UpdatePasswordState {
  final UpdateStep step;
  final UpdateStatus status;
  final String? message;

  UpdatePasswordState({
    this.step = UpdateStep.idle,
    this.status = UpdateStatus.idle,
    this.message,
  });

  UpdatePasswordState copyWith({
    UpdateStep? step,
    UpdateStatus? status,
    String? message,
  }) {
    return UpdatePasswordState(
      step: step ?? this.step,
      status: status ?? this.status,
      message: message,
    );
  }
}


import '../../../../domain/bloc/bloc_state.dart';

class SplashState extends BlocState {
  final bool showPermission;

  SplashState({
    super.message = "",
    super.isLoading = false,
    this.showPermission = false,
  });

  @override
  SplashState copyWith({
    String? message,
    bool? isLoading,
    bool? isFinish,
    bool? showPermission,
  }) {
    return SplashState(
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      showPermission: showPermission ?? this.showPermission,
    );
  }
}

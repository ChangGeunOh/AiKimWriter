import '../../../../domain/bloc/bloc_state.dart';

class AppInfoState extends BlocState {
  final String currentVersion;

  AppInfoState({
    super.message = '',
    super.isLoading = false,
    this.currentVersion = '',
  });

  @override
  AppInfoState copyWith({
    String? message,
    bool? isLoading,
    String? currentVersion,
  }) {
    return AppInfoState(
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      currentVersion: currentVersion ?? this.currentVersion,
    );
  }
}

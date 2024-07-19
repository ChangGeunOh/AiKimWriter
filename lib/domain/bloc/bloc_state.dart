abstract class BlocState {
  final String message;
  final bool isLoading;

  BlocState({
    this.message = '',
    this.isLoading = false,
  });

  BlocState copyWith({String? message, bool? isLoading});
}

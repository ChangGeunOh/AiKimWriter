import 'bloc_base_event.dart';

class BlocEvent<T> {
  final T type;
  final dynamic extra;

  BlocEvent(this.type, {this.extra});
}

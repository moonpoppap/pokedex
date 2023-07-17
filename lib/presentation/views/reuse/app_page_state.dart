import 'package:equatable/equatable.dart';

enum AppPageStatus { initial, loading, success, failure }

class AppPageState<T> extends Equatable {
  final AppPageStatus status;
  final T? value;

  const AppPageState({
    this.status = AppPageStatus.initial,
    this.value
  });

  AppPageState<T> copyWith({
    AppPageStatus? status,
    T? value
  }) {
    return AppPageState(
      status: status ?? this.status,
      value: value ?? this.value
    );
  }

  @override
  List<Object> get props => [
    status,
    value!
  ];
}
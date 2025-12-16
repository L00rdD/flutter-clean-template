part of 'example_bloc.dart';

@freezed
class ExampleState with _$ExampleState {
  const factory ExampleState.initial() = _Initial;
  const factory ExampleState.loading() = _Loading;
  const factory ExampleState.success(String message) = _Success;
  const factory ExampleState.failure(String error) = _Failure;
}

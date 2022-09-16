import 'package:freezed_annotation/freezed_annotation.dart';
part 'pagination.freezed.dart';

@freezed
class PaginationState<T> with _$PaginationState<T> {
  factory PaginationState.data(List<T> items) = _Data;
  factory PaginationState.loading() = _Loading;
  factory PaginationState.error(Object? e, [StackTrace? stk]) = _Error;
  factory PaginationState.onGoingLoading(List<T> items) = _OnGoingLoading;
  factory PaginationState.onGoingError(List<T> items, Object? e,
      [StackTrace? stk]) = _OnGoingError;
}

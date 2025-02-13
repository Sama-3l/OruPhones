part of 'stick_sort_and_filter_cubit.dart';

@immutable
sealed class StickSortAndFilterState {}

final class StickSortAndFilterInitial extends StickSortAndFilterState {}

final class StickButtonsState extends StickSortAndFilterState {
  final bool stickButtons;

  StickButtonsState({required this.stickButtons});
}

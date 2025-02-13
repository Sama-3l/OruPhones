part of 'bottom_sheet_page_cubit.dart';

@immutable
sealed class BottomSheetPageState {}

final class BottomSheetPageInitial extends BottomSheetPageState {}

final class ChangePageState extends BottomSheetPageState {}

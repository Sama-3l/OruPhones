import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'stick_sort_and_filter_state.dart';

class StickSortAndFilterCubit extends Cubit<StickSortAndFilterState> {
  StickSortAndFilterCubit() : super(StickSortAndFilterInitial());

  onStick(bool stickButtons) => emit(StickButtonsState(stickButtons: stickButtons));
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_sheet_page_state.dart';

class BottomSheetPageCubit extends Cubit<BottomSheetPageState> {
  BottomSheetPageCubit() : super(BottomSheetPageInitial());

  onPageChange() => emit(ChangePageState());
}

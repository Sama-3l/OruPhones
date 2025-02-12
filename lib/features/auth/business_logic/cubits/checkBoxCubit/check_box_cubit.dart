import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'check_box_state.dart';

class CheckBoxCubit extends Cubit<CheckBoxState> {
  CheckBoxCubit() : super(CheckBoxInitial());

  onUpdate() => emit(CheckBoxUpdate());
}

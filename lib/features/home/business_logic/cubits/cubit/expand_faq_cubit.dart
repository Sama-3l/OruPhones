import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'expand_faq_state.dart';

class ExpandFaqCubit extends Cubit<ExpandFaqState> {
  ExpandFaqCubit() : super(ExpandFaqInitial());

  onUpdate() => emit(ExpandFaq());
}

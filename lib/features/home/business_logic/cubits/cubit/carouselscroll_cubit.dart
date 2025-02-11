import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'carouselscroll_state.dart';

class CarouselScrollCubit extends Cubit<CarouselScrollState> {
  CarouselScrollCubit() : super(CarouselScrollInitial());

  onUpdates() => emit(CarouselUpdateState());
}

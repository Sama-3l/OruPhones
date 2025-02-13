import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'like_product_state.dart';

class LikeProductCubit extends Cubit<LikeProductState> {
  LikeProductCubit() : super(LikeProductInitial());

  onPressed(bool liked) => emit(LikeState(liked: liked));
}

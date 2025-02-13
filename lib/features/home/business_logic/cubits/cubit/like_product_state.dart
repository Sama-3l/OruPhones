part of 'like_product_cubit.dart';

@immutable
sealed class LikeProductState {}

final class LikeProductInitial extends LikeProductState {}

final class LikeState extends LikeProductState {
  final bool liked;

  LikeState({required this.liked});
}

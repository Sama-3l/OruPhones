part of 'carouselscroll_cubit.dart';

@immutable
sealed class CarouselScrollState {}

final class CarouselScrollInitial extends CarouselScrollState {}

final class CarouselUpdateState extends CarouselScrollState {}

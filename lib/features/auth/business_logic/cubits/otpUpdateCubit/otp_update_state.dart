part of 'otp_update_cubit.dart';

@immutable
sealed class OtpUpdateState {}

final class OtpUpdateInitial extends OtpUpdateState {}

final class OtpStatusUpdate extends OtpUpdateState {}

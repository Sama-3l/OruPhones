import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'otp_update_state.dart';

class OtpUpdateCubit extends Cubit<OtpUpdateState> {
  OtpUpdateCubit() : super(OtpUpdateInitial());

  onUpdate() => emit(OtpStatusUpdate());
}

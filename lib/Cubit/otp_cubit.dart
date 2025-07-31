import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:logo_app_traning/Cubit/otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpState());

  static OtpCubit get(context) => BlocProvider.of(context);

  void startTimer() {
    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 20;
    final controller = CountdownTimerController(endTime: endTime);
    emit(state.copyWith(controller: controller));
  }

  void resartTimer() {
    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 20;
    final controller = CountdownTimerController(endTime: endTime);
    emit(state.copyWith(controller: controller));
    log('Timer Restart with end time: $endTime');
  }

  // void stopTimer() {
  //   emit(state.copyWith(isRunning: false));
  // }

  void resetTimer() {
    emit(OtpState());
  }
}

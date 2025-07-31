import 'package:equatable/equatable.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';

enum RequestStatus { initial, loading, success, failure }


class OtpState extends Equatable {
   CountdownTimerController? controller;
  RequestStatus? status;
  OtpState({this.controller, this.status = RequestStatus.initial});
  OtpState copyWith({CountdownTimerController? controller, RequestStatus? status}) {
    return OtpState(
      controller: controller ?? this.controller,
      status: status ?? this.status,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [controller, status];
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'translate_state.dart';

class TranslateCubit extends Cubit<TranslateState> {
  TranslateCubit() : super(TranslateState(appLocale: Locale('ar')));
  static TranslateCubit get(context) => BlocProvider.of(context);
  void changeLanguage(Locale locale) {
    emit(state.copyWith(appLocale: locale));
  }
}

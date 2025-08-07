part of 'translate_cubit.dart';

 class TranslateState extends Equatable {
  final Locale appLocale;
  const TranslateState({required this.appLocale});
  TranslateState copyWith({Locale? appLocale}) {
    return TranslateState(appLocale: appLocale ?? this.appLocale);
  }

  @override
  List<Object> get props => [appLocale];
}



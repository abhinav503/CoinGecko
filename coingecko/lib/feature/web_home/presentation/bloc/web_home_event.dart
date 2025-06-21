part of 'web_home_bloc.dart';

@immutable
sealed class WebHomeEvent {}

class SelectCoinEvent extends WebHomeEvent {
  final int index;
  final bool runApis;
  SelectCoinEvent({required this.index, this.runApis = false});
}

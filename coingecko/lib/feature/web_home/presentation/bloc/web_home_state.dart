part of 'web_home_bloc.dart';

@immutable
sealed class WebHomeState {}

final class WebHomeInitial extends WebHomeState {}

class SelectedCoinState extends WebHomeState {}

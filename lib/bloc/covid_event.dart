part of 'covid_bloc.dart';

@immutable
sealed class CovidEvent {}

final class LoadCovid extends CovidEvent {}

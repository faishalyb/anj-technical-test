part of 'covid_bloc.dart';

@immutable
sealed class CovidState {}

final class CovidInitial extends CovidState {}

final class CovidLoading extends CovidState {}

final class CovidLoaded extends CovidState {
  final List<Attributes> attributes;

  CovidLoaded(this.attributes);
}

final class CovidError extends CovidState {
  final String error;

  CovidError(this.error);
}

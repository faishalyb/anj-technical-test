import 'package:anj_techtest/data/datasource/remote_datasource.dart';
import 'package:anj_techtest/data/model/covid_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'covid_event.dart';
part 'covid_state.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  final RemoteDatasource remoteDatasource;

  CovidBloc({required this.remoteDatasource}) : super(CovidInitial()) {
    on<LoadCovid>((event, emit) async {
      emit(CovidLoading());
      try {
        final result = await remoteDatasource.getData();
        emit(CovidLoaded(result.features));
      } catch (e) {
        emit(CovidError(e.toString()));
      }
    });
  }
}

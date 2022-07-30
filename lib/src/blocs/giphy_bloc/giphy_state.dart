part of 'giphy_bloc.dart';

@immutable
abstract class GiphyState {}

class GiphyInitial extends GiphyState {}

class LoadingGiphy extends GiphyState{}

class ErrorGiphy extends GiphyState{
  final String error; 
  ErrorGiphy(this.error);
  List<Object> get props => [error];
}

class SuccessSearchGifs extends GiphyState{
  final List<Giphy> gifs;
  final Pagination paginacion;
  SuccessSearchGifs(this.gifs, this.paginacion);
  List<Object> get props => [gifs, paginacion];
}
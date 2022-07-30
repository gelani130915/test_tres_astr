part of 'giphy_bloc.dart';

@immutable
abstract class GiphyEvent {}

class SearchGifsEvent extends GiphyEvent{
  final String search; 
  final int offset;
  SearchGifsEvent(this.search, this.offset);
  List<Object> get props => [search, offset];  
}
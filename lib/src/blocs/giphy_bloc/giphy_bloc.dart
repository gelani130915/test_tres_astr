import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_tecn/src/models/giphy.dart';
import 'package:test_tecn/src/models/pagination_model.dart';
import 'package:test_tecn/src/providers/giphy_provider.dart';

part 'giphy_event.dart';
part 'giphy_state.dart';

class GiphyBloc extends Bloc<GiphyEvent, GiphyState> {
  final GiphyProvider provider;
  GiphyBloc({required this.provider}) : super(GiphyInitial()) {
    on<GiphyEvent>((event, emit) async { 
      if(event is SearchGifsEvent){
        emit(LoadingGiphy());
        try {
          final result = await provider.searchGif(event.search, event.offset);
          if(result['status']){
            emit(SuccessSearchGifs(result['data'], result['page']));
          }else{
            emit(ErrorGiphy(result['message']));
          }
        } catch (e) {
          emit(ErrorGiphy(e.toString()));
        }
      }
    });
  }
}

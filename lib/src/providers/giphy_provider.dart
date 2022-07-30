import 'package:http/http.dart' as http;
import 'package:test_tecn/src/models/giphy.dart';
import 'package:test_tecn/src/models/pagination_model.dart';

import 'package:test_tecn/src/utils/constants.dart';
import 'package:test_tecn/src/utils/custom_app_exception.dart';

class GiphyProvider{

  Future<Map<String,dynamic>> searchGif(String search, int offset) async{
    Map<String,dynamic> _retorno = {
      'status':false,
      'data':'',
      'message': '',
      'page': ''
    };
    try {
      final baseUrl =  Constants.GIPHY_SEARCH_URL;
      final apiKey  =  Constants.GIPHY_API_KEY;
      final _url = "$baseUrl$apiKey&q=$search&limit=10&offset=$offset&rating=g&lang=es"; 
      final _uriUrl = Uri.parse(_url);  
      final resp = await http.get(
        _uriUrl,  
      );
      final Map _decodedResponse = returnResponse(resp);
      if(_decodedResponse['meta']['status'] == 200){ 
        List<Giphy> _gifs = []; 
        _decodedResponse['data'].forEach((item){
          _gifs.add(Giphy.fromJson(item));
        });
        Pagination _page = Pagination.fromJson(_decodedResponse['pagination']);
        _retorno['data']    = _gifs; 
        _retorno['page']    = _page; 
        _retorno['message'] = 'OK'; 
        _retorno['status']  = true;
      }else{
        _retorno['message'] = 'Ah ocurrido un error...';
      }      
    } catch (e) {
      _retorno['message'] = e.toString();
    }
    return _retorno;
  }  

}
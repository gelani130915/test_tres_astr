import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_tecn/src/blocs/giphy_bloc/giphy_bloc.dart';
import 'package:test_tecn/src/models/giphy.dart';
import 'package:test_tecn/src/models/pagination_model.dart';
import 'package:test_tecn/src/providers/giphy_provider.dart';
import 'package:test_tecn/src/widgets/card_giphy.dart';
import 'package:test_tecn/src/widgets/circular_button.dart';
import 'package:test_tecn/src/widgets/rounded_button.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool _busca = false;
  int indexSelected = 1;
  List<Giphy> gifs = [];
  late Pagination pagination; 
  final List<Map<String,String>> _menuHor = [
    {'title':'All', 'search':'dinner'},
    {'title':'Happy Hours', 'search':'restaurante'},
    {'title':'Drinks', 'search':'bebida'},
    {'title':'Beer', 'search':'cerveza'},
    {'title':'Food', 'search':'comida'},
  ];
  String _textTitle = '';
  final ScrollController _scrollController = ScrollController();
  late BuildContext _blocContext;

  @override
  void initState() {
    _textTitle = _menuHor[indexSelected]['title']!;
    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _fetchData(_blocContext);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: _getAppBar(),
      body: BlocProvider(
        create: (context) => GiphyBloc(provider: GiphyProvider()),
        child: BlocListener<GiphyBloc, GiphyState>(
          listener: (context, state) {
            if(state is SuccessSearchGifs){
                gifs.addAll(state.gifs);
                pagination = state.paginacion;
            }else if(state is ErrorGiphy){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error))
              );
            }
          },
          child: BlocBuilder<GiphyBloc, GiphyState>(
            builder: (context, state) {
              _blocContext = context;
              if(!_busca){
                _getGifsData(context, _menuHor[indexSelected]['search']!, 0);
                _busca = true;
              }
              return Stack(
                children: [
                  _getContent(),
                  _loadingWidget(state)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _getAppBar(){
    return AppBar(
      toolbarHeight: 280,
      automaticallyImplyLeading: false,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/img/nasa.png',
                height: 95,
              ),
              Row(
                children: [
                  CircularButton(
                    icon: Icons.notifications,
                    presed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Notifications'),
                          backgroundColor: Colors.orange[300],
                          action: SnackBarAction(label: 'OK', textColor: Colors.blue, onPressed: (){}),
                        )
                      );
                    },
                  ),
                  CircularButton(
                    icon: Icons.settings,
                    presed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Settings'),
                          backgroundColor: Colors.orange[300],
                          action: SnackBarAction(label: 'OK', textColor: Colors.blue, onPressed: (){}),
                        )
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Favorites',
                    style: TextStyle(
                        fontFamily: 'FuturaBold', 
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 65)),
                CircularButton(
                  icon: Icons.add,
                  padding: 8,
                  iconSize: 30,
                  presed: ()=>_showFormFavs(),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_menuHor.length, (i){
                return RoudedButton(
                  text: _menuHor[i]['title']!,
                  isSlected: indexSelected == i,
                  onPressed: () {
                    setState(() {
                      indexSelected = i;
                      _textTitle = _menuHor[i]['title']!;
                      gifs.clear();
                      pagination = Pagination(totalCount: 0, count: 0, offset: 0);
                      _getGifsData(_blocContext, _menuHor[i]['search']!, 0);
                    });
                  },
                );
              }), 
            ),
          )
        ],
      ),
    );
  }

  Widget _loadingWidget(GiphyState state){
    if(state is LoadingGiphy){
      return const Center(child: CircularProgressIndicator(),);
    }else{
      return const SizedBox();
    }
  }

  Widget _getContent(){
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          )),
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _textTitle,
                  style: const TextStyle(
                    fontFamily: 'FuturaBold',
                    fontSize: 35
                  ),
                ),
                CircularButton(
                  icon: Icons.delete_outline,
                  presed: () {
                    if(_menuHor.length > 1){
                      setState(() {
                        _menuHor.removeAt(indexSelected);
                        indexSelected = 0;
                        _textTitle = _menuHor[indexSelected]['title']!;
                        gifs.clear();
                        pagination = Pagination(totalCount: 0, count: 0, offset: 0);
                        _getGifsData(_blocContext, _menuHor[indexSelected]['search']!, 0);
                      });
                    }
                  },
                )
              ],
            ),
            Wrap(
              children: List.generate(gifs.length, (i){
                return CardGiphy(
                  idGiphy: gifs[i].id!, 
                  title: gifs[i].title!
                );
              }),
            )
          ],
        ),
      ),
    );
  } 

  _showFormFavs() {
    String _title = '';
    String _search = '';
    final _formKey = GlobalKey<FormState>();
    showDialog(
      context: context, 
      builder: (_){
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Add Favorite',
                    style: TextStyle( 
                      fontSize: 22,
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration( 
                      label: Text(
                        'Title', 
                      ),
                      suffixIcon: Icon(Icons.text_fields)
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Title is required';
                      }
                    },
                    onSaved: (value){
                      _title = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration( 
                      label: Text(
                        'Search in Giphy', 
                      ),
                      suffixIcon: Icon(Icons.image_search_rounded)
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Search data is required';
                      } 
                    },
                    onSaved: (value){
                      _search = value!;
                    },
                  ),
                  RoudedButton(
                    text: 'Save', 
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                        setState(() {
                          _menuHor.add(
                            {'title':_title, 'search':_search},
                          );
                        });
                        Navigator.of(context).pop();
                      }
                    }
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  void _fetchData(BuildContext currentContext) {
    int lOffset = pagination.offset + 1;
    if((pagination.count * lOffset) < pagination.totalCount){
      _getGifsData(currentContext, _menuHor[indexSelected]['search']!, lOffset);
    }
  }

  //Métodos para agregar estados al bloc
  void _getGifsData(BuildContext context, String search, int offset) {
    BlocProvider.of<GiphyBloc>(context).add(SearchGifsEvent(search, offset));
  }  
}

import 'dart:math';

import 'package:flutter/material.dart';

class IslasPage extends StatefulWidget {
  const IslasPage({Key? key}) : super(key: key);

  @override
  State<IslasPage> createState() => _IslasPageState();
}

class _IslasPageState extends State<IslasPage> {
  final TextEditingController _numerCont = TextEditingController();
  final List<List<int>> _matriz    = [];
  final List<List<bool>> _visitados = []; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: TextFormField(
              controller: _numerCont,
              decoration: InputDecoration(
                label: const Text('Ingrese un número'),
                suffixIcon: ElevatedButton(
                  child: const Text('OK'), 
                  onPressed: ()=>_processData()
                ),
              ),
              keyboardType: TextInputType.number, 
            ),
          ),
          _matriz.isEmpty
          ? const SizedBox()
          : Table(
            border: TableBorder.all(),
            children: List.generate(_matriz.length, (i){
              return TableRow(
                children: List.generate(_matriz[i].length, (j){
                  return InkWell(
                    child: Container(
                      color: _matriz[i][j] == 1 ? Colors.brown[400] : Colors.blue[300],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _matriz[i][j].toString(), 
                          textAlign: TextAlign.center
                        ),
                      ),
                    ),
                    onTap: (){
                      setState(() { 
                            _matriz[i][j] = _matriz[i][j] == 1 ? 0 : 1;
                          });
                    },
                  );
                })
              );
            }),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text('Islas:', style: TextStyle(fontSize: 23),),
          ),
          Text(_getNumIslas(_matriz).toString(), style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }

  _processData(){
    _visitados.clear();
    var _num = int.tryParse(_numerCont.text);
    if(_numerCont.text.isEmpty || (_num == null)){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe ingresar un número'))
      );
      return;
    }
    _matriz.clear();
    Random random = Random();
    for (var i = 0; i < _num; i++) { 
        _matriz.add(List.generate(_num, (index){
          return random.nextInt(2);
        })); 
        // _visitados.add(List.generate(_num, (index){
        //   return false;
        // }));
    }   
    setState(() {
      _matriz;
    });
  }

  int _getNumIslas(List<List<int>> matriz){
    if(matriz.isEmpty){
      return 0;
    }
    int _islas = 0; 
    _setFalseVisitados(matriz);
    for (var i = 0; i < matriz.length; i++) {
      for (var j = 0; j < matriz[i].length; j++) {
        if(matriz[i][j] == 1 && _visitados[i][j] == false){
          buscaNodos(matriz, i, j);
          _islas++;
        }
      }
    } 
    return _islas;
  }

  buscaNodos(List<List<int>> matriz, int x, int y){
    List<int> filas     = [-1,0,1,0];
    List<int> columnas  = [0,-1,0,1];
    _visitados[x][y] = true;
    for (var k = 0; k < 4; k++) {
      int nX = x + filas[k];
      int nY = y + columnas[k];
      if((nX >= 0) && (nX < matriz[0].length) && (nY >= 0) && (nY < matriz.length) && ((matriz[nX][nY] == 1) && (_visitados[nX][nY] == false))){
        buscaNodos(matriz, nX, nY);
      }
    } 
  }

  _setFalseVisitados(List<List<int>> matriz){
    _visitados.clear(); 
    for (var i = 0; i < matriz.length; i++) {
      _visitados.add(List.generate(matriz[i].length, (j){
        return false;
      }));
    }
    setState(() {
      _visitados;
    });
  }

  @override
  void dispose() {
    _numerCont.dispose();
    super.dispose();
  }
}
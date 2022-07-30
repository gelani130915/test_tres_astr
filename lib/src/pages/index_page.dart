import 'package:flutter/material.dart';

import 'package:test_tecn/src/pages/favorites_page.dart';
import 'package:test_tecn/src/pages/other_page.dart';
import 'package:test_tecn/src/widgets/custom_bottom_bar.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _selectedIndex = 3;
  final _inactiveColor = Colors.grey;
  final List<Widget> _pages = <Widget>[
    OtherPage(text: 'Home'),
    OtherPage(text: 'Calendar'),
    OtherPage(text: 'Search'),
    const FavoritesPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: _buildBottomBar() 
    );
  }

  Widget _buildBottomBar(){
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: _selectedIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _selectedIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.home),
          title: const Text('Principal'), 
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.today),
          title: const Text('Calendario'), 
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.search),
          title: const Text(
            'Buscar',
          ), 
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.favorite_border),
          title: const Text('Favoritos', style: TextStyle(fontFamily: 'Futura'),), 
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  } 
}
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Evaluación técnica', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(  
            children: [
              const Text(
              'Evaluación técnica realizada por Lorenzo Benítez para la empresa Tres Astronautas. En ésta aplicación encontrarán los dos ejercicios proporcionados, agradezco su tiempo y su ineterés en mi trabajo.',
                style: TextStyle(
                  fontSize: 18
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                icon: const Icon(Icons.beach_access_sharp),
                label: const Text('Ejercicio 1'),
                onPressed: ()=>Navigator.of(context).pushNamed('islas'),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.design_services_sharp),
                label: const Text('Ejercicio 2'),
                onPressed: ()=>Navigator.of(context).pushNamed('index'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
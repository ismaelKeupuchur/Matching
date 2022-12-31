import 'package:flutter/material.dart';

// Guardar fecha, movimientos, tiempo

class Leadboard extends StatefulWidget {
  const Leadboard({super.key});

  @override
  State<Leadboard> createState() => _LeadboardState();
}

class _LeadboardState extends State<Leadboard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Menu'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            //Se dibujan los puntajes
            children: <Widget>[
              Text("Puntaje"),
              Text("Puntaje 2"),
              Text("Puntaje 3"),
            ],
          ),
        ),
      ),
    );
  }
}

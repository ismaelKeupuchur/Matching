import 'package:flutter/material.dart';
import 'pagetwo.dart';
import "pagethree.dart";

void main() {
  runApp(const MaterialApp(
    title: 'Proyecto',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Menu'),
        ),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            //Se carga una imagen desde la carpeta de assets
            Image.asset('assets/image/7bc.png'),
            //Se crean los buttones con texto dentro
            ElevatedButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.play_arrow),
                  const Text('Jugar'),
                ],
              ),
              //Se cambia el tamaño del boton
              style: ElevatedButton.styleFrom(
                minimumSize: Size(300, 40),
              ),
              //Al apretar, se usa el Navigator para cambiar de pagina
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      //Se carga la clase SecondRoute del archivo "pagetwo.dart"
                      builder: (context) => SecondRoute(
                            title: "Grid",
                          )),
                );
              },
            ),
            ElevatedButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.star),
                  const Text('Tablero de Posiciones'),
                ],
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(300, 40),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Leadboard()),
                );
              },
            ),
            ElevatedButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.settings),
                  const Text('Ajustes'),
                ],
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(300, 40),
              ),
              onPressed: () {},
            ),
          ]),
        ),
      ),
    );
  }
}

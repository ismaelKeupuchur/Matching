import 'package:flutter/material.dart';
import 'dart:async';

// Se define una clase que extiende de StatefulWidget para actualizar los
// elementos en pantalla
class SecondRoute extends StatefulWidget {
  const SecondRoute({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

//Clase que representa cada uno de los cuadrados y su infomacion como visibilidad, sus icono, si han sido encontrados y sus parejas
class TileIcon {
  late Icon figura;
  late int id;
  late int idPareja;
  bool visible = false;
  bool encontrado = false;

  TileIcon(Icon _figura, int _id, _idPareja) {
    figura = _figura;
    id = _id;
    idPareja = _idPareja;
  }
}

// Clase que define el estado de nuestra clase GridPage
class _SecondRouteState extends State<SecondRoute> {
  // Variables del estado para llevar el registro del offset
  // y los segundos transcurridos en la ejecución del timer.
  int _moves = 0;
  int _seconds = 0;
  int _tapDobles = 0;
  TileIcon? ultimoMovimiento;

  // Objeto Timer importado de 'dart:async', que nos permitirá ejecutar tareas
  // de forma periódica.
  Timer? _timer;

  //Lista de clase TileIcon que tienen con icon, id, idpareja, bool visibilidad
  // la grid
  final List<TileIcon> _tileiconList = [
    TileIcon(Icon(Icons.headphones_battery), 1, 7),
    TileIcon(Icon(Icons.handshake), 2, 8),
    TileIcon(Icon(Icons.wifi), 3, 9),
    TileIcon(Icon(Icons.piano), 4, 10),
    TileIcon(Icon(Icons.sports_golf), 5, 11),
    TileIcon(Icon(Icons.car_crash), 6, 12),
    TileIcon(Icon(Icons.headphones_battery), 7, 1),
    TileIcon(Icon(Icons.handshake), 8, 2),
    TileIcon(Icon(Icons.wifi), 9, 3),
    TileIcon(Icon(Icons.piano), 10, 4),
    TileIcon(Icon(Icons.sports_golf), 11, 5),
    TileIcon(Icon(Icons.car_crash), 12, 6)
  ];

  // Init State es llamado al iniciar el estado de nuestro widget, en el ciclo
  // de vida de nuestro widget es llamado una sola vez antes de ejecutar el
  // build de nuestra aplicación
  @override
  void initState() {
    super.initState();
    _tileiconList.shuffle();
    // Iniciamos el timer al momento de cargar nuestra pantalla
    // utilizamos el constructor periodic, el cual realizará la llamada a la
    // función definida como segundo parámetro cada vez que se cumpla el tiempo
    // definido en la duración del primer parámetro.
    _timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      // Realizamos un setState para actualizar los elementos en pantalla.
      setState(() {
        // Se incrementa el contador de segundos simplemente sumando 1, ya que
        // nuestra duración coincide con el tiempo de un segundo.
        _seconds++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        // Utilizamos una columna para ordenar los elementos en pantalla
        body: Column(
          children: [
            // Utilizamos el constructor count de Gridview para construir
            // nuestra grid.
            Padding(
              padding: const EdgeInsets.all(80),
              child: GridView.count(
                // Definimos un espaciado entre los elementos de la grid
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                // Definimos la cantidad de columnas a utilizar en la grid
                crossAxisCount: 3,
                // Por defecto Grid utiliza todo el espacio disponible en pantalla
                // como estamos trabajando en una columna que no define su alto
                // utilizamos el parámetro shrinkWrap para definir que utilice el
                // espacio mínimo requerido
                shrinkWrap: true,
                // Los children de count es un listado de elementos.
                // Utilizamos el constructor generate de List para generar ese
                // listado de forma programática.
                children: List.generate(
                  // Número de elementos a generar
                  _tileiconList.length,
                  // Función para generar cada elemento
                  // Cada elemento se compone de un Container con cuadrado con icono
                  // especificado
                  (index) => InkWell(
                    onTap: () async {
                      _tapDobles++;
                      //Se pregunta si es que se ha apretado en el mismo lugar, si no es asi y ya se apreto en dos lugares entonces es movimiento
                      if (_tapDobles >= 2 &&
                          _tileiconList[index].id != ultimoMovimiento?.id) {
                        _tapDobles = 0;
                        _moves++;
                      }

                      print("Funcionando");
                      //Primero pregunta si lo que se ha tocado ya se ha encontrado
                      if (_tileiconList[index].encontrado == false) {
                        setState(() {
                          _tileiconList[index].visible = true;
                        });

                        //Hay un delayed para que el jugador pueda ver los iconos
                        Future.delayed(Duration(seconds: 1), () {
                          //Se comparan los iconos apretados
                          if (ultimoMovimiento?.id ==
                              _tileiconList[index].idPareja) {
                            _tileiconList[index].encontrado = true;
                            for (int i = 0; i < _tileiconList.length; i++) {
                              if (_tileiconList[i].id == ultimoMovimiento?.id) {
                                _tileiconList[i].encontrado = true;
                                _tileiconList[i].visible = true;
                              }
                            }
                            //Si el ultimo icono no es la pareja entonces se vuelve invisible
                          } else {
                            setState(() {
                              _tileiconList[index].visible = false;
                              ultimoMovimiento = _tileiconList[index];
                            });
                          }
                        });
                      }
                    },
                    child: Container(
                      color: Colors.blue,
                      child: Center(
                          // Como contenido dentro de Container se muestra el
                          // numero del offset generado para el contenedor.
                          child: _tileiconList[index].visible
                              ? _tileiconList[index].figura
                              : null),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Se muestra la variable offset en pantalla
            Text(
              'Movimientos: $_moves',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 20),
            // Se muestran los segundos transcurridos en la ejecución del Timer
            // en pantalla
            Text(
              'Seconds: $_seconds',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 20),
            // Creamos un botón para cancelar el timer.
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _timer!.cancel();
                    builder:
                    (context) => SecondRoute(title: "Grid");
                  });
                },
                child: const Text('Reiniciar'))
          ],
        ));
  }
}

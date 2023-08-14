import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
      const _messages = <String>[
        'Cargando películas',
        'Comprando palomitas',
        'Cargando películas en cartelera',
        'Comprando bebidas',
        'Cargando películas populares',
        'Esto está tardando más de lo esperado :(',
        'Cargando películas mejor calificadas',
        'Demos un rato más, quiza la conexión esta lenta',
        'Cargando películas que se estrenarán próximamente',
        'Parece que hay un problema con la conexión',
      ];

    return Stream
      .periodic(Duration(milliseconds: 500), (int step) => _messages[step])
      .take(_messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator( strokeWidth: 2,),

          SizedBox(height: 20),

          Text('Espere por favor ...'),

          SizedBox(height: 20,),

          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              return Text(snapshot.data ?? 'Cargando');
            },
          ),
        ],
      ),
    );
  }
}
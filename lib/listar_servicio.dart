import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smile/agregar_servicio.dart';
import 'package:smile/editar_servicio.dart';
import 'package:smile/firebase_options.dart';
import 'package:smile/firebase_service.dart';
import 'package:smile/menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ListaServicio1());
}

class ListaServicio1 extends StatelessWidget {
  const ListaServicio1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Map<String, dynamic>> servicios;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Servicios:'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>const Menu(), 
              ),
            );
          },
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getServicio(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            servicios = snapshot.data!;

            return SingleChildScrollView(
              child: FittedBox(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('ID:')),
                    DataColumn(label: Text('Nombre:')),
                    DataColumn(label: Text('Descripcion:')),
                    DataColumn(label: Text('Precio:')),
                    DataColumn(label: Text('Acciones:')),
                  ],
                  rows: servicios
                      .map((servicioData) => DataRow(
                            cells: [
                              DataCell(Text(servicioData['id'].toString())),
                              DataCell(Text(servicioData['nombre'].toString())),
                              DataCell(Text(servicioData['descripcion'].toString())),
                              DataCell(Text(servicioData['precio'].toString())),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditarServicio(servicioData: servicioData),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () async {
                                        await deleteServicio(servicioData['id'].toString());
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AgregarServicio()),
          );
          // Después de agregar, actualiza los datos volviendo a llamar a getServicio
          List<Map<String, dynamic>> updatedServicios = await getServicio();
          setState(() {
            servicios = updatedServicios;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

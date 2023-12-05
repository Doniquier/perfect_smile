import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smile/agregar_cliente.dart';
import 'package:smile/editar_cliente.dart';
import 'package:smile/firebase_service.dart';
import 'package:smile/firebase_options.dart';
import 'package:smile/menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Lista1());
}

class Lista1 extends StatelessWidget {
  const Lista1({Key? key}) : super(key: key);

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
  late List<Map<String, dynamic>> clientes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de clientes:'),
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
        future: getCliente(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            clientes = snapshot.data!;

            return SingleChildScrollView(
              child: FittedBox(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('ID:')),
                    DataColumn(label: Text('Nombre:')),
                    DataColumn(label: Text('Apellidos:')),
                    DataColumn(label: Text('Edad:')),
                    DataColumn(label: Text('Dni:')),
                    DataColumn(label: Text('Teléfono:')),
                    DataColumn(label: Text('Dirección:')),
                    DataColumn(label: Text('Acciones:')), 
                  ],
                  rows: clientes
                      .map(
                        (clienteData) => DataRow(
                          cells: [
                            DataCell(Text(clienteData['id'].toString())),
                            DataCell(Text(clienteData['nombre'].toString())),
                            DataCell(Text(clienteData['apellidos'].toString())),
                            DataCell(Text(clienteData['edad'].toString())),
                            DataCell(Text(clienteData['dni'].toString())),
                            DataCell(Text(clienteData['telefono'].toString())),
                            DataCell(Text(clienteData['direccion'].toString())),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditarCliente(clienteData: clienteData),
                                          ),
                                        );
                                      },
                                    ),
                                  IconButton(
                                      icon:const Icon(Icons.delete),
                                      onPressed: () async {                                        
                                        await deleteCliente(clienteData['id'].toString());                                        
                                        setState(() {});
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AgregarCliente()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

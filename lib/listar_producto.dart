import 'package:firebase_core/firebase_core.dart';
import 'package:smile/agregar_producto.dart';
import 'package:smile/editar_producto.dart';
import 'package:smile/firebase_options.dart';
import 'package:smile/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:smile/menu.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ListaProducto1());
}

class ListaProducto1 extends StatelessWidget {
  const ListaProducto1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home:  Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Map<String, dynamic>> productos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Lista de Productos:'),
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
        future: getProducto(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            productos = snapshot.data!;

            return SingleChildScrollView(
              child: FittedBox(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('ID:')),
                    DataColumn(label: Text('Nombre:')),
                    DataColumn(label: Text('Descripcion:')),
                    DataColumn(label: Text('Cantidad:')),
                    DataColumn(label: Text('Precio:')), 
                    DataColumn(label: Text('Acciones:')),                   
                  ],
                  rows: productos
                      .map((productoData) => DataRow(
                            cells: [
                              DataCell(Text(productoData['id'].toString())),
                              DataCell(Text(productoData['nombre'].toString())),
                              DataCell(Text(productoData['descripcion'].toString())),
                              DataCell(Text(productoData['cantidad'].toString())),
                              DataCell(Text(productoData['precio'].toString())),
                              DataCell(
                              Row(
                                children: [
                                  IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditarProducto(productoData: productoData),
                                          ),
                                        );
                                      },
                                    ),
                                  IconButton(
                                      icon:const Icon(Icons.delete),
                                      onPressed: () async {
                                        
                                        await deleteProducto(productoData['id'].toString());
                                    
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>const AgregarProducto()),
          );
        },
        child:const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smile/firebase_service.dart';
import 'package:smile/listar_producto.dart';

class EditarProducto extends StatefulWidget {
  final Map<String, dynamic> productoData;

  const EditarProducto({Key? key, required this.productoData}) : super(key: key);

  @override
  EditarProductoState createState() => EditarProductoState();
}

class EditarProductoState extends State<EditarProducto> {
  late TextEditingController nombreController;
  late TextEditingController descripcionController;
  late TextEditingController cantidadController;
  late TextEditingController precioController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.productoData['nombre']);
    descripcionController = TextEditingController(text: widget.productoData['descripcion']);
    precioController = TextEditingController(text: widget.productoData['precio'].toString());
    cantidadController = TextEditingController(text: widget.productoData['cantidad'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(nombreController, 'Nombre'),
            _buildTextField(descripcionController, 'Descripción'),
            _buildTextField(cantidadController, 'Cantidad'),
            _buildTextField(precioController, 'Precio', keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await updateProducto(
                  widget.productoData['id'].toString(),
                  nombreController.text,
                  descripcionController.text,
                  int.parse(cantidadController.text),
                  int.parse(precioController.text),
                );                
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListaProducto1(),
                  ),
                );
              },
              child: const Text('Actualizar Producto'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {TextInputType? keyboardType}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 120.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smile/firebase_options.dart';
import 'package:smile/firebase_service.dart';
import 'package:smile/listar_producto.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AgregarProducto());
}

class AgregarProducto extends StatelessWidget {
  const AgregarProducto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: _AgregarProducto(),
    );
  }
}

class _AgregarProducto extends StatefulWidget {
  const _AgregarProducto({Key? key}) : super(key: key);

  @override
  __AgregarProductoState createState() => __AgregarProductoState();
}

class __AgregarProductoState extends State<_AgregarProducto> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Nuevo Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildOvalTextField(
              controller: _nombreController,
              labelText: 'Nombre',
            ),
            _buildOvalTextField(
              controller: _descripcionController,
              labelText: 'Descripción',
            ),
            _buildOvalTextField(
              controller: _cantidadController,
              labelText: 'Cantidad',
              keyboardType: TextInputType.number,
            ),
            _buildOvalTextField(
              controller: _precioController,
              labelText: 'Precio',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _agregarNuevoProducto();
              },
              child: const Text('Agregar Producto'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOvalTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 120.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        textAlign: TextAlign.center,
        keyboardType: keyboardType,
      ),
    );
  }

  void _agregarNuevoProducto() {
    String nombre = _nombreController.text;
    String descripcion = _descripcionController.text;
    int cantidad = int.tryParse(_cantidadController.text) ?? 0;
    int precio = int.tryParse(_precioController.text) ?? 0;
    addProducto(nombre, descripcion,cantidad, precio);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ListaProducto1(),
      ),
    );
  }
}

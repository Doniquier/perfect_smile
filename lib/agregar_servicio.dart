import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smile/firebase_options.dart';
import 'package:smile/firebase_service.dart';
import 'package:smile/listar_servicio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AgregarServicio());
}

class AgregarServicio extends StatelessWidget {
  const AgregarServicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: _AgregarServicio(),
    );
  }
}

class _AgregarServicio extends StatefulWidget {
  const _AgregarServicio({Key? key}) : super(key: key);

  @override
  __AgregarServicioState createState() => __AgregarServicioState();
}

class __AgregarServicioState extends State<_AgregarServicio> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Nuevo Servicio'),
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
              controller: _precioController,
              labelText: 'Precio',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _agregarNuevoServicio();
              },
              child: const Text('Agregar Servicio'),
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

  void _agregarNuevoServicio() {
    String nombre = _nombreController.text;
    String descripcion = _descripcionController.text;
    double precio = double.tryParse(_precioController.text) ?? 0.0;
    addServicio(nombre, descripcion, precio);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ListaServicio1(),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smile/firebase_options.dart';
import 'package:smile/firebase_service.dart';
import 'package:smile/listar_cliente.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AgregarCliente());
}

class AgregarCliente extends StatelessWidget {
  const AgregarCliente({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: _AgregarCliente(),
    );
  }
}

class _AgregarCliente extends StatefulWidget {
  const _AgregarCliente({Key? key}) : super(key: key);

  @override
  __AgregarClienteState createState() => __AgregarClienteState();
}

class __AgregarClienteState extends State<_AgregarCliente> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Nuevo Cliente'),
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
              controller: _apellidoController,
              labelText: 'Apellido',
            ),
            _buildOvalTextField(
              controller: _edadController,
              labelText: 'Edad',
              keyboardType: TextInputType.number,
            ),
            _buildOvalTextField(
              controller: _dniController,
              labelText: 'Dni',
              keyboardType: TextInputType.number,
            ),
            _buildOvalTextField(
              controller: _direccionController,
              labelText: 'Direccion',
              
            ),
            _buildOvalTextField(
              controller: _telefonoController,
              labelText: 'Teléfono',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _agregarNuevoCliente();
              },
              child: const Text('Agregar cliente'),
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

  void _agregarNuevoCliente() {
    String nombre = _nombreController.text;
    String apellido = _apellidoController.text;
    int edad = int.tryParse(_edadController.text) ?? 0;
    int dni = int.tryParse(_dniController.text) ?? 0;    
    String direccion = _direccionController.text;
    int telefono = int.tryParse(_telefonoController.text) ?? 0;

    addCliente(nombre, apellido, edad, dni, direccion, telefono);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Lista1(),
      ),
    );
  }
}

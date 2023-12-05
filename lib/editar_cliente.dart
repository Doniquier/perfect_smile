import 'package:flutter/material.dart';
import 'package:smile/firebase_service.dart';
import 'package:smile/listar_cliente.dart';

class EditarCliente extends StatefulWidget {
  final Map<String, dynamic> clienteData;

  const EditarCliente({Key? key, required this.clienteData}) : super(key: key);

  @override
  EditarClienteState createState() => EditarClienteState();
}

class EditarClienteState extends State<EditarCliente> {
  late TextEditingController nombreController;
  late TextEditingController apellidoController;
  late TextEditingController edadController;
  late TextEditingController dniController;
  late TextEditingController direccionController;
  late TextEditingController telefonoController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.clienteData['nombre']);
    apellidoController = TextEditingController(text: widget.clienteData['apellido']);
    edadController = TextEditingController(text: widget.clienteData['edad'].toString());
    dniController = TextEditingController(text: widget.clienteData['dni'].toString());
    direccionController = TextEditingController(text: widget.clienteData['direccion']);
    telefonoController = TextEditingController(text: widget.clienteData['telefono'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(nombreController, 'Nombre'),
            _buildTextField(apellidoController, 'Apellido'),
            _buildTextField(edadController, 'Edad', keyboardType: TextInputType.number),
            _buildTextField(dniController, 'Dni', keyboardType: TextInputType.number),
            _buildTextField(direccionController, 'Direccion'),
            _buildTextField(telefonoController, 'Telefono', keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await updateCliente(
                  widget.clienteData['id'].toString(),
                  nombreController.text,
                  apellidoController.text,
                  int.parse(edadController.text),
                  int.parse(dniController.text),
                  direccionController.text,
                  int.parse(telefonoController.text),
                );                
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Lista1(),
                  ),
                );
              },
              child: const Text('Actualizar Cliente'),
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

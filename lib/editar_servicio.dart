import 'package:flutter/material.dart';
import 'package:smile/firebase_service.dart';
import 'package:smile/listar_servicio.dart';

class EditarServicio extends StatefulWidget {
  final Map<String, dynamic> servicioData;

  const EditarServicio({Key? key, required this.servicioData}) : super(key: key);

  @override
  EditarServicioState createState() => EditarServicioState();
}

class EditarServicioState extends State<EditarServicio> {
  late TextEditingController nombreController;
  late TextEditingController descripcionController;
  late TextEditingController precioController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.servicioData['nombre']);
    descripcionController = TextEditingController(text: widget.servicioData['descripcion']);
    precioController = TextEditingController(text: widget.servicioData['precio'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Servicio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(nombreController, 'Nombre'),
            _buildTextField(descripcionController, 'Descripción'),
            _buildTextField(precioController, 'Precio', keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await updateServicio(
                  widget.servicioData['id'].toString(),
                  nombreController.text,
                  descripcionController.text,
                  int.parse(precioController.text),
                );                
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListaServicio1(),
                  ),
                );
              },
              child: const Text('Actualizar Servicio'),
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

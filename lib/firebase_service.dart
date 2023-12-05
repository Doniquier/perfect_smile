
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//lISTAR//

Future<List<Map<String, dynamic>>> getCliente() async {
  List<Map<String, dynamic>> clientes = [];
  CollectionReference collectionReferenceCliente = db.collection('cliente');

  QuerySnapshot queryCliente = await collectionReferenceCliente.get();
  for (QueryDocumentSnapshot documento in queryCliente.docs) {
    Map<String, dynamic> clienteData = {
      'id': documento.id,
      'nombre': documento['nombre'],
      'apellidos': documento['apellidos'],      
      'edad': documento['edad'],
      'dni': documento['dni'],
      'direccion': documento['direccion'],
      'telefono': documento['telefono'],
    };
    clientes.add(clienteData);
  }

  return clientes;
}

Future<List<Map<String, dynamic>>> getProducto() async {
  List<Map<String, dynamic>> productos = [];
  CollectionReference collectionReferenceProducto = db.collection('producto');

  QuerySnapshot queryProducto = await collectionReferenceProducto.get();
  for (QueryDocumentSnapshot documento in queryProducto.docs) {
    Map<String, dynamic> productoData = {
      'id': documento.id,
      'nombre': documento['nombre'],
      'descripcion': documento['descripcion'],      
      'cantidad': documento['cantidad'],
      'precio': documento['precio'],
    };
    productos.add(productoData);
  }

  return productos;
}

Future<List<Map<String, dynamic>>> getServicio() async {
  List<Map<String, dynamic>> servicios = [];
  CollectionReference collectionReferenceServicio = db.collection('servicio');

  QuerySnapshot queryServicio = await collectionReferenceServicio.get();
  for (QueryDocumentSnapshot documento in queryServicio.docs) {
    Map<String, dynamic> servicioData = {
      'id': documento.id,
      'nombre': documento['nombre'],
      'descripcion': documento['descripcion'],
      'precio': documento['precio'],
    };
    servicios.add(servicioData);
  }

  return servicios;
}



//AGREGAR//

Future<void> addCliente(String nombre, String apellidos, int edad, int dni, String direccion, int telefono) async {
  CollectionReference collectionReferenceCliente = db.collection('cliente');

  await collectionReferenceCliente.add({
    'nombre': nombre,
    'apellidos': apellidos,
    'edad': edad,
    'dni': dni,
    'direccion': direccion,
    'telefono': telefono,
  });
}

Future<void> addProducto(String nombre, String descripcion, int cantidad, int precio) async {
  CollectionReference collectionReferenceProducto = db.collection('producto');

  await collectionReferenceProducto.add({
    'nombre': nombre,
    'descripcion': descripcion,
    'cantidad': cantidad,
    'precio': precio,
    
  });
}

Future<void> addServicio(String nombre, String descripcion, double precio) async {
  CollectionReference collectionReferenceServicio = db.collection('servicio');

  await collectionReferenceServicio.add({
    'nombre': nombre,
    'descripcion': descripcion,
    'precio': precio,
  });
}

//ACTUALIZAR//

Future<void> updateCliente(String id, String nombre, String apellidos, int edad, int dni, String direccion, int telefono) async {
  try {
    CollectionReference collectionReferenceCliente = db.collection('cliente');
    await collectionReferenceCliente.doc(id).update({
      'nombre': nombre,
      'apellidos': apellidos,
      'edad': edad,
      'dni': dni,
      'direccion': direccion,
      'telefono': telefono,
    });
    print('Cliente actualizado correctamente');
  } catch (e) {
    print('Error al actualizar el cliente: $e');
  }
}

Future<void> updateProducto(String id, String nombre, String descripcion, int cantidad, int precio) async {
  try {
    CollectionReference collectionReferenceProducto = db.collection('producto');
    await collectionReferenceProducto.doc(id).update({
      'nombre': nombre,
      'descripcion': descripcion,
      'cantidad': cantidad,
      'precio': precio,
    });
    print('Producto actualizado correctamente');
  } catch (e) {
    print('Error al actualizar el producto: $e');
  }
}

Future<void> updateServicio(String id, String nombre, String descripcion, int precio) async {
  try {
    CollectionReference collectionReferenceServicio = db.collection('servicio');
    await collectionReferenceServicio.doc(id).update({
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
    });
    print('Servicio actualizado correctamente');
  } catch (e) {
    print('Error al actualizar el servicio: $e');
  }
}



// ELIMINAR //

Future<void> deleteCliente(String id) async {
  try {
    await FirebaseFirestore.instance.collection('cliente').doc(id).delete();  
    print('Servicio eliminado correctamente');
  } catch (e) {
    print('Error al eliminar el servicio: $e');
  }
}

Future<void> deleteProducto(String id) async {
  try {
    await FirebaseFirestore.instance.collection('producto').doc(id).delete();  
    print('Servicio eliminado correctamente');
  } catch (e) {
    print('Error al eliminar el servicio: $e');
  }
}


Future<void> deleteServicio(String id) async {
  try {
    await FirebaseFirestore.instance.collection('servicio').doc(id).delete();  
    print('Servicio eliminado correctamente');
  } catch (e) {
    print('Error al eliminar el servicio: $e');
  }
}


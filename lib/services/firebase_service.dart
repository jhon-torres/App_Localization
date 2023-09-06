import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

Future<List<Map<String, dynamic>>> getUsers() async {
  List<Map<String, dynamic>> users = [];
  CollectionReference collectionReferenceUsers = db.collection('locations');
  QuerySnapshot queryUsers = await collectionReferenceUsers.get();
  queryUsers.docs.forEach((element) {
    print(element);
    users.add({
      'name': element['name'],
      'latitud': element['latitud'],
      'longitud': element['longitud'],
    });
  });
  return users;
}

// Leer base de datos
Future<List> getUser() async {
  List user = [];
  QuerySnapshot querySnapshot = await db.collection('locations').get();

  for (var doc in querySnapshot.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final person = {
      "name": data['name'],
      "email": data['email'],
      "uid": doc.id,
    };
    user.add(person);
    print('Datos recuperados de Firestore: $user');

  }
  return user;
  
}

// Añadir a base de datos
Future<void> registerUser(String email, String password, String name) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    String? uid = userCredential.user?.uid;

    // Una vez registrado el usuario, lo guardamos en Firestore
    if (uid != null) {
      await db.collection('locations').doc(uid).set({
        'name': name,
        'email': email,
        'latitud':0,
        'longitud':0
      });
    }
  } catch (e) {
    print(e);
    throw e;
  }
}

// Actualizar
// Actualizar
Future<void> updateUser(String uid, String name, String email) async {
  try {
     print('Updating user with UID: $uid'); // Nuevo punto de registro
    print('Inside updateuser Service - Updating Firestore...'); // Nuevo punto de registro
    await db.collection("locations").doc(uid).update({
      "name": name,
      "email": email,
    });
    print('Actualizado!'); // Nuevo punto de registro
  } catch (e) {
    print('Update Error: $e'); // Nuevo punto de registro
    if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
      print('Este correo electrónico ya está en uso.');
    }
  }
}


// Eliminar
Future<void> deleteUser(String uid) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    // Eliminar el usuario de Firebase Authentication
    await _auth.currentUser!.delete();

    // Eliminar el documento en Firestore
    await db.collection("locations").doc(uid).delete();
  } catch (e) {
    print(e);
    throw e;
  }
}

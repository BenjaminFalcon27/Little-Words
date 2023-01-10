import 'package:flutter/material.dart';
import 'package:little_words/service/database.helper.dart';

class UserWidget extends StatefulWidget {
  const UserWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserWidgetState createState() => _UserWidgetState();

  static Future<String> getUserName() async {
    String userName = "";
    String? value = await DatabaseHelper.getUser();

    if (value != null) {
      userName = value;
    } else {
      userName = "Aucun nom d'utilisateur trouvé";
    }

    return userName;
  }
}

class _UserWidgetState extends State<UserWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: DatabaseHelper.getUser(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text('Aucune connexion');
          case ConnectionState.waiting:
            return const Text('Chargement en cours...');
          default:
            if (snapshot.hasError) {
              return Text('Erreur : ${snapshot.error}');
            } else {
              return Text('Connecté en tant que : ${snapshot.data}');
            }
        }
      },
    );
  }
}

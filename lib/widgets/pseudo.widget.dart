import 'package:flutter/material.dart';
import 'package:little_words/views/home.view.dart';

class PseudoWidget extends StatefulWidget {
  const PseudoWidget({super.key});

  @override
  PseudoWidgetState createState() {
    return PseudoWidgetState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class PseudoWidgetState extends State<PseudoWidget> {
  final _formKey = GlobalKey<FormState>();
  String userName = "";

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Write your name :'),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              } else {
                userName = value;
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Good morning $userName')),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeView()),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

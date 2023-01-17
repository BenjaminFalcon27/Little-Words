import 'package:flutter/material.dart';
import 'package:little_words/models/word.model.dart';
import 'package:little_words/service/database.helper.dart';
import 'package:little_words/widgets/user.widget.dart';

class WordScreen extends StatelessWidget {
  final Word? word;
  const WordScreen({Key? key, this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authorController = TextEditingController();
    UserWidget.getUserName().then((username) {
      authorController.text = username;
    });
    final contentController = TextEditingController();
    final latitudeController = TextEditingController();
    final longitudeController = TextEditingController();

    if (word != null) {
      authorController.text = word!.author;
      contentController.text = word!.content;
      latitudeController.text = word!.latitude.toString();
      longitudeController.text = word!.longitude.toString();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(word == null ? 'Créer un mot' : 'Editer un mot'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
            ),
            TextFormField(
              controller: contentController,
              decoration: const InputDecoration(
                  hintText: 'Contenu',
                  labelText: 'Contenu',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0.75,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ))),
              keyboardType: TextInputType.multiline,
              onChanged: (str) {},
              maxLines: 1,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      final author = authorController.value.text;
                      final content = contentController.value.text;
                      //TODO: get location
                      final longitude = longitudeController.value.text;
                      final latitude = latitudeController.value.text;

                      if (content.isEmpty || content.isEmpty) {
                        return;
                      }

                      final Word model = Word(
                          id: word?.id,
                          uid: 1,
                          author: author,
                          content: content,
                          //TODO: get location
                          longitude: 1.0,
                          latitude: 1.0);
                      if (word == null) {
                        await DatabaseHelper.addWord(model);
                      } else {
                        await DatabaseHelper.updateWord(model);
                      }

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                              return Theme.of(context).primaryColor.withOpacity(0.5);
                          },
                        ),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 0.75,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                )))),
                    child: Text(
                      word == null ? 'Save' : 'Edit',
                      style: const TextStyle(fontSize: 20),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:little_words/models/word.model.dart';
import 'package:little_words/service/database.helper.dart';

class WordScreen extends StatelessWidget {
  final Word? word;
  const WordScreen({Key? key, this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authorController = TextEditingController();
    final contentController = TextEditingController();
    final latitudeController = TextEditingController();
    final longitudeController = TextEditingController();

    if (word != null) {
      authorController.text = word!.author;
      contentController.text = word!.content;
      latitudeController.text = word!.latitude!;
      longitudeController.text = word!.longitude!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(word == null ? 'Créer un mot' : 'Editer un mot'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Center(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: TextFormField(
                controller: authorController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'Auteur',
                    labelText: 'Nom auteur',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
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
                          longitude: '1.0',
                          latitude: '1.0');
                      if (word == null) {
                        await DatabaseHelper.addWord(model);
                      } else {
                        await DatabaseHelper.updateWord(model);
                      }

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
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

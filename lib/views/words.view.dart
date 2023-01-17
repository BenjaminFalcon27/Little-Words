import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

import '../models/word.model.dart';
import '../service/database.helper.dart';
import '../widgets/user.widget.dart';
import '../widgets/word.widget.dart';
import 'word.view.dart';
import '../service/dio.client.dart';

class WordsScreen extends StatefulWidget {
  const WordsScreen({Key? key}) : super(key: key);

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  final dioClient = DioClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: FutureBuilder(
            future: UserWidget.getUserName(), // fonction qui retourne un Future
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(text: 'Sac à mot de '),
                      TextSpan(
                        text: '${snapshot.data}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("Erreur : ${snapshot.error}");
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const WordScreen()));
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder<List<Word>?>(
          future: DatabaseHelper.getAllWord(),
          builder: (context, AsyncSnapshot<List<Word>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => WordWidget(
                    word: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WordScreen(
                                    word: snapshot.data![index],
                                  )));
                      setState(() {});
                    },
                    onLongPress: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('What do you want to do?'),
                              actions: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.red)),
                                  onPressed: () async {
                                    await DatabaseHelper.deleteWord(
                                        snapshot.data![index]);
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: const Text('Delete'),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.orange)),
                                  onPressed: () {
                                    DatabaseHelper.getWordById(
                                            snapshot.data![index].id!)
                                        .then((value) async => {
                                              await dioClient.throwWord(
                                                  word: value!,
                                                  uid: snapshot.data![index].id!
                                                      .toString()),
                                              Navigator.pop(context),
                                              setState(() {})
                                            });
                                  },
                                  child: const Text('Throw'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                );
              }
              return const Center(
                child: Text('No words yet'),
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}

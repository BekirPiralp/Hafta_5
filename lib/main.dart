import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //Değişkenler
   // final wordPair = WordPair.random();
    //Tanımlamalar
    return MaterialApp(
      debugShowCheckedModeBanner: false, // debug yazısı kaldırma€€
      title: '18 Nisan 2021',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text("Flutter' a hoş geldiniz \nWelcome to Flutter"),
      //   ),
      //   body: Center(
      //     //child: Text("Merhaba Dünya / Hello World"),
      //     child: RandomWords(),
      //   ),
      // ),
      home: RandomWords(),
    );
  }
}


class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  // değişkenler
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = TextStyle(fontSize: 18.0);

  // methotlar
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index], index+1,_suggestions.length);
        });
  }

  Widget _buildRow(WordPair pair, int sayi, int uzunluk) {
    //değişkenler
    final alreadySaved = _saved.contains(pair);

    //tanımlar ve geri dönüş
    return ListTile(
      title: Text(sayi.toString()+"/"+uzunluk.toString()+" "+
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.airplanemode_active : Icons.airline_seat_recline_normal_sharp,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map(
                (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
            color: Colors.green,
          ).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }, // ...to here.
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Değişkenler
    //final wordPair = WordPair.random();
    //tanımlar
    //return Text(wordPair.asPascalCase);

    return Scaffold(
        appBar: AppBar(
          title: Text('Startup Name Generator'),
          actions: [
            IconButton(icon: Icon(Icons.label_important_outline), onPressed: _pushSaved),
          ],
        ),
        body: _buildSuggestions(),
      );
    }
}


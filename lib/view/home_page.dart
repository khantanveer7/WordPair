import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _randomeWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordPairs.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : Colors.red,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedWordPairs.remove(pair);
          } else {
            _savedWordPairs.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          final Iterable<ListTile> tiles = _savedWordPairs.map(
            (pair) => ListTile(
              title: Text(
                pair.asPascalCase,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                setState(() {
                  _savedWordPairs.remove(pair);
                });
              },
            ),
          );

          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text("Favourite"),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WordPair"),
        actions: [
          IconButton(
            onPressed: _pushSaved,
            icon: Icon(Icons.favorite_border_rounded),
          )
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemBuilder: (context, item) {
          final index = item ~/ 2;

          if (item.isOdd) return Divider();
          if (index >= _randomeWordPairs.length) {
            _randomeWordPairs.addAll(
              generateWordPairs().take(10),
            );
          }
          return _buildRow(_randomeWordPairs[index]);
        },
      ),
    );
  }
}

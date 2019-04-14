import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWordsWidget extends StatefulWidget {
  @override
  createState() => RandomWordsWidgetState();
}

class RandomWordsWidgetState extends State<RandomWordsWidget> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Startup Name Generator'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: _pushSavedNames,
        )
      ]),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return Scrollbar(
        child: ListView.builder(
            itemCount: 30,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, i) {
              if (i.isOdd) {
                return Divider();
              } else {
                final index = i ~/ 2;
                if (index >= _suggestions.length) {
                  _suggestions.addAll(generateWordPairs().take(10));
                }
                return _buildRow(_suggestions[index]);
              }
            }));
  }

  Widget _buildRow(WordPair pair) {
    final isWordSaved = _saved.contains(pair);
    return ListTile(
        title: Text(pair.asPascalCase, style: const TextStyle(fontSize: 18.0)),
        trailing: Icon(
          isWordSaved ? Icons.favorite : Icons.favorite_border,
          color: isWordSaved ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if (isWordSaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        });
  }

  _pushSavedNames() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
            return ListTile(title: Text(pair.asPascalCase));
          });
          final List<Widget> savedItemListView = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: savedItemListView),
          );
        },
      ),
    );
  }
}

import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(App());

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Names for a startUp',
      home: RandomWords(),
    );
  }
}



class RandomWords extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => RandomWordsState();
}


// States
class RandomWordsState extends State<RandomWords>{
    final _suggestions = <WordPair>[];
    final _saved = Set<WordPair>();
    final _biggerFont = TextStyle(fontSize: 18.0);

     Widget _buildRow(WordPair pair) {
      final alreadySaved = _saved.contains(pair);
      return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
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

    Widget _buildSuggestions(){
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, rowNumber){
          if(rowNumber.isOdd) return Divider();

          final index = rowNumber ~/ 2;
          if(index >= _suggestions.length){
            _suggestions.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_suggestions[index]);
        },
      );
    }

    void _pushSaved(){
      Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (BuildContext context){
          final Iterable<ListTile> tiles = _saved.map((WordPair pair){
            return ListTile(title: Text(pair.asPascalCase, style: _biggerFont,),);
          });

          final List<Widget> dividedTiles = ListTile.divideTiles(context: context, tiles: tiles).toList();

          return Scaffold(appBar: AppBar(title: Text('Favorites'),),
            body: ListView(children: dividedTiles,),
          );
        }
        )
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Startup Name Generator'), actions: <Widget>[IconButton(icon: Icon(Icons.list), onPressed: _pushSaved,)],),
      body: _buildSuggestions(),
      );
  }

}
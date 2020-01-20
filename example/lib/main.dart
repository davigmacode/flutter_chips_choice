import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ChipsChoice',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int tag = 1;
  List<String> tags = [];

  List<String> options = [
    'News', 'Entertainment', 'Politics',
    'Automotive', 'Sports', 'Education',
    'Fashion', 'Travel', 'Food', 'Tech',
    'Science',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter ChipsChoice'),
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: <Widget>[
          Content(
            title: 'Scrollable List Single Choice',
            child: ChipsChoice<int>.single(
              value: tag,
              options: ChipsChoiceOption.listFrom<String, int>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
              onChanged: (val) => setState(() => tag = val),
            ),
          ),
          Content(
            title: 'Scrollable List Multiple Choice',
            child: ChipsChoice<String>.multiple(
              value: tags,
              options: ChipsChoiceOption.listFrom<String, String>(
                source: options,
                value: (i, v) => v,
                label: (i, v) => v,
              ),
              onChanged: (val) => setState(() => tags = val),
            ),
          ),
          Content(
            title: 'Wrapped List Single Choice',
            child: ChipsChoice<int>.single(
              value: tag,
              options: ChipsChoiceOption.listFrom<String, int>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
              onChanged: (val) => setState(() => tag = val),
              itemConfig: ChipsChoiceItemConfig(
                isWrapped: true,
                margin: EdgeInsets.all(0)
              ),
            ),
          ),
          Content(
            title: 'Wrapped List Multiple Choice',
            child: ChipsChoice<String>.multiple(
              value: tags,
              options: ChipsChoiceOption.listFrom<String, String>(
                source: options,
                value: (i, v) => v,
                label: (i, v) => v,
              ),
              onChanged: (val) => setState(() => tags = val),
              itemConfig: ChipsChoiceItemConfig(
                isWrapped: true,
                margin: EdgeInsets.all(0)
              ),
            ),
          ),
          Content(
            title: 'Disabled Choice item',
            child: ChipsChoice<int>.single(
              value: tag,
              options: ChipsChoiceOption.listFrom<String, int>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => v,
                disabled: (i, v) => [0, 2, 5].contains(i),
              ),
              onChanged: (val) => setState(() => tag = val),
              itemConfig: ChipsChoiceItemConfig(
                isWrapped: true,
                margin: EdgeInsets.all(0)
              ),
            ),
          ),
          Content(
            title: 'Hidden Choice item',
            child: ChipsChoice<String>.multiple(
              value: tags,
              options: ChipsChoiceOption.listFrom<String, String>(
                source: options,
                value: (i, v) => v,
                label: (i, v) => v,
                hidden: (i, v) => ['Science', 'Politics', 'News', 'Tech'].contains(v),
              ),
              onChanged: (val) => setState(() => tags = val),
              itemConfig: ChipsChoiceItemConfig(
                isWrapped: true,
                margin: EdgeInsets.all(0)
              ),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Content extends StatelessWidget {

  final String title;
  final Widget child;

  Content({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            color: Colors.blueGrey[50],
            child: Text(
              title,
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

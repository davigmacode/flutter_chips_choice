import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:theme_patrol/theme_patrol.dart';
import 'package:dio/dio.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemePatrol(
      light: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.red,
        ),
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.red,
        ),
        toggleableActiveColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (context, theme) {
        return MaterialApp(
          title: 'Chips Choice',
          theme: theme.lightData,
          darkTheme: theme.darkData,
          themeMode: theme.mode,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  // single choice value
  int tag = 3;

  // multiple choice value
  List<String> tags = ['Education'];

  // list of string options
  List<String> options = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
  ];

  String? user;
  final usersMemoizer = C2ChoiceMemoizer<String>();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final formKey = GlobalKey<FormState>();
  List<String> formValue = [];

  Future<List<C2Choice<String>>> getUsers() async {
    try {
      String url =
          "https://randomuser.me/api/?inc=gender,name,nat,picture,email&results=25";
      Response res = await Dio().get(url);
      return C2Choice.listFrom<String, dynamic>(
        source: res.data['results'],
        value: (index, item) => item['email'],
        label: (index, item) =>
            item['name']['first'] + ' ' + item['name']['last'],
        meta: (index, item) => item,
      )..insert(0, const C2Choice<String>(value: 'all', label: 'All'));
    } on DioError catch (e) {
      throw ErrorDescription(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ChipsChoice'),
        actions: <Widget>[
          ThemeConsumer(builder: ((context, theme) {
            return IconButton(
              onPressed: () => theme.toggleMode(),
              icon: Icon(theme.modeIcon),
            );
          })),
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _about(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Expanded(
              child: ListView(
                addAutomaticKeepAlives: true,
                children: <Widget>[
                  Content(
                    title: 'Scrollable List Single Choice',
                    child: ChipsChoice<int>.single(
                      value: tag,
                      onChanged: (val) => setState(() => tag = val),
                      choiceItems: C2Choice.listFrom<int, String>(
                        source: options,
                        value: (i, v) => i,
                        label: (i, v) => v,
                        tooltip: (i, v) => v,
                      ),
                      // choiceStyle: const C2ChoiceStyle(
                      //   appearance: C2ChipType.elevated,
                      // ),
                      choiceActiveStyle: C2ChoiceStyle(
                        appearance: C2ChipType.elevated,
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                        showCheckmark: true,
                      ),
                    ),
                  ),
                  Content(
                    title: 'Scrollable List Multiple Choice',
                    child: ChipsChoice<String>.multiple(
                      value: tags,
                      onChanged: (val) => setState(() => tags = val),
                      choiceItems: C2Choice.listFrom<String, String>(
                        source: options,
                        value: (i, v) => v,
                        label: (i, v) => v,
                        tooltip: (i, v) => v,
                      ),
                      choiceStyle: const C2ChoiceStyle(
                        appearance: C2ChipType.outlined,
                        showCheckmark: true,
                      ),
                    ),
                  ),
                  Content(
                    title:
                        'Wrapped List Single Choice and Custom Border Radius',
                    child: ChipsChoice<int>.single(
                      value: tag,
                      onChanged: (val) => setState(() => tag = val),
                      choiceItems: C2Choice.listFrom<int, String>(
                        source: options,
                        value: (i, v) => i,
                        label: (i, v) => v,
                        tooltip: (i, v) => v,
                      ),
                      choiceStyle: const C2ChoiceStyle(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      wrapped: true,
                    ),
                  ),
                  Content(
                    title:
                        'Wrapped List Multiple Choice and Right to Left Text Direction',
                    child: ChipsChoice<String>.multiple(
                      value: tags,
                      onChanged: (val) => setState(() => tags = val),
                      choiceItems: C2Choice.listFrom<String, String>(
                        source: options,
                        value: (i, v) => v,
                        label: (i, v) => v,
                        tooltip: (i, v) => v,
                      ),
                      wrapped: true,
                      textDirection: TextDirection.rtl,
                      choiceActiveStyle:
                          const C2ChoiceStyle(showCheckmark: true),
                    ),
                  ),
                  Content(
                    title: 'Disabled Choice Item',
                    child: ChipsChoice<int>.single(
                      value: tag,
                      onChanged: (val) => setState(() => tag = val),
                      choiceItems: C2Choice.listFrom<int, String>(
                        source: options,
                        value: (i, v) => i,
                        label: (i, v) => v,
                        tooltip: (i, v) => v,
                        disabled: (i, v) => [0, 2, 5].contains(i),
                      ),
                      wrapped: true,
                    ),
                  ),
                  Content(
                    title: 'Hidden Choice Item',
                    child: ChipsChoice<String>.multiple(
                      value: tags,
                      onChanged: (val) => setState(() => tags = val),
                      choiceItems: C2Choice.listFrom<String, String>(
                        source: options,
                        value: (i, v) => v,
                        label: (i, v) => v,
                        tooltip: (i, v) => v,
                        hidden: (i, v) =>
                            ['Science', 'Politics', 'News', 'Tech'].contains(v),
                      ),
                      wrapped: true,
                    ),
                  ),
                  Content(
                    title: 'Individual Style Choice Item',
                    child: ChipsChoice<String>.multiple(
                      value: tags,
                      onChanged: (val) => setState(() => tags = val),
                      choiceItems: C2Choice.listFrom<String, String>(
                        source: options,
                        value: (i, v) => v,
                        label: (i, v) => v,
                        tooltip: (i, v) => v,
                        style: (i, v) {
                          if (['Science', 'Politics', 'News', 'Tech']
                              .contains(v)) {
                            return const C2ChoiceStyle(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              showCheckmark: false,
                            );
                          }
                          return null;
                        },
                        activeStyle: (i, v) {
                          if (['Science', 'Politics', 'News', 'Tech']
                              .contains(v)) {
                            return const C2ChoiceStyle(
                                brightness: Brightness.dark);
                          }
                          return null;
                        },
                      ),
                      wrapped: true,
                    ),
                  ),
                  Content(
                    title: 'Append an Item to Options',
                    child: ChipsChoice<int>.single(
                      value: tag,
                      onChanged: (val) => setState(() => tag = val),
                      choiceItems: C2Choice.listFrom<int, String>(
                        source: options,
                        value: (i, v) => i,
                        label: (i, v) => v,
                        tooltip: (i, v) => v,
                      )..insert(
                          0, const C2Choice<int>(value: -1, label: 'All')),
                    ),
                  ),
                  Content(
                    title: 'Without Checkmark and Custom Border Shape',
                    child: ChipsChoice<int>.single(
                      value: tag,
                      onChanged: (val) => setState(() => tag = val),
                      choiceItems: C2Choice.listFrom<int, String>(
                        source: options,
                        value: (i, v) => i,
                        label: (i, v) => v,
                        tooltip: (i, v) => v,
                      )..insert(
                          0, const C2Choice<int>(value: -1, label: 'All')),
                      choiceStyle: C2ChoiceStyle(
                        showCheckmark: false,
                        labelStyle: const TextStyle(fontSize: 20),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        borderColor: Colors.blueGrey.withOpacity(.5),
                      ),
                      choiceActiveStyle: const C2ChoiceStyle(
                        brightness: Brightness.dark,
                        borderShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            side: BorderSide(color: Colors.red)),
                      ),
                    ),
                  ),
                  Content(
                    title: 'Async Choice Items and Brightness Dark',
                    child: FutureBuilder<List<C2Choice<String>>>(
                      initialData: const [],
                      future: usersMemoizer.runOnce(getUsers),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  )),
                            ),
                          );
                        } else {
                          if (!snapshot.hasError) {
                            return ChipsChoice<String>.single(
                              value: user,
                              onChanged: (val) => setState(() => user = val),
                              choiceItems: snapshot.data ?? [],
                              choiceStyle: const C2ChoiceStyle(
                                color: Colors.blueGrey,
                                brightness: Brightness.dark,
                                margin: EdgeInsets.all(5),
                                showCheckmark: false,
                              ),
                              choiceActiveStyle: const C2ChoiceStyle(
                                color: Colors.green,
                                brightness: Brightness.dark,
                              ),
                              choiceAvatarBuilder: (data) {
                                if (data.meta == null) return null;
                                return CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      data.meta['picture']['thumbnail']),
                                );
                              },
                            );
                          } else {
                            return Container(
                              padding: const EdgeInsets.all(25),
                              child: Text(
                                snapshot.error.toString(),
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  Content(
                    title: 'Async Choice Items Using choiceLoader',
                    child: ChipsChoice<String>.single(
                      value: user,
                      onChanged: (val) => setState(() => user = val),
                      choiceLoader: getUsers,
                      choiceStyle: const C2ChoiceStyle(
                        color: Colors.blueGrey,
                        brightness: Brightness.dark,
                        margin: EdgeInsets.all(5),
                        showCheckmark: false,
                      ),
                      choiceActiveStyle: const C2ChoiceStyle(
                        color: Colors.green,
                        brightness: Brightness.dark,
                      ),
                      choiceAvatarBuilder: (data) {
                        if (data.meta == null) return null;
                        return CircleAvatar(
                          backgroundImage: NetworkImage(
                            data.meta['picture']['thumbnail'],
                          ),
                        );
                      },
                    ),
                  ),
                  Content(
                    title: 'Works with FormField and Validator',
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          FormField<List<String>>(
                            autovalidateMode: AutovalidateMode.always,
                            initialValue: formValue,
                            onSaved: (val) =>
                                setState(() => formValue = val ?? []),
                            validator: (value) {
                              if (value?.isEmpty ?? value == null) {
                                return 'Please select some categories';
                              }
                              if (value!.length > 5) {
                                return "Can't select more than 5 categories";
                              }
                              return null;
                            },
                            builder: (state) {
                              return Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: ChipsChoice<String>.multiple(
                                      value: state.value ?? [],
                                      onChanged: (val) => state.didChange(val),
                                      choiceItems:
                                          C2Choice.listFrom<String, String>(
                                        source: options,
                                        value: (i, v) => v.toLowerCase(),
                                        label: (i, v) => v,
                                        tooltip: (i, v) => v,
                                      ),
                                      choiceStyle: const C2ChoiceStyle(
                                        color: Colors.indigo,
                                        borderOpacity: .3,
                                      ),
                                      choiceActiveStyle: const C2ChoiceStyle(
                                          color: Colors.indigo,
                                          brightness: Brightness.dark,
                                          appearance: C2ChipType.elevated),
                                      wrapped: true,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 0, 15, 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      state.errorText ??
                                          '${state.value!.length}/5 selected',
                                      style: TextStyle(
                                          color: state.hasError
                                              ? Colors.redAccent
                                              : Colors.green),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (formKey.currentState!.validate()) {
                                      // If the form is valid, save the value.
                                      formKey.currentState!.save();
                                    }
                                  },
                                  child: const Text('Submit'),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text('Submitted Value:'),
                                      const SizedBox(height: 5),
                                      Text(formValue.toString())
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Content(
                    title: 'Custom Choice Widget',
                    child: ChipsChoice<String>.multiple(
                      value: tags,
                      onChanged: (val) => setState(() => tags = val),
                      choiceItems: C2Choice.listFrom<String, String>(
                        source: options,
                        value: (i, v) => v,
                        label: (i, v) => v,
                      ),
                      choiceBuilder: (item) {
                        return CustomChip(
                          label: item.label,
                          width: 70,
                          height: 100,
                          selected: item.selected,
                          onSelect: item.select!,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 100,
              child: Content(
                title: 'Vertical Direction',
                child: ChipsChoice<int>.single(
                  value: tag,
                  onChanged: (val) => setState(() => tag = val),
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: options,
                    value: (i, v) => i,
                    label: (i, v) => v,
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  choiceBuilder: (item) {
                    return CustomChip(
                      label: item.label,
                      width: double.infinity,
                      height: 90,
                      color: Colors.redAccent,
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      selected: item.selected,
                      onSelect: item.select!,
                    );
                  },
                  direction: Axis.vertical,
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CustomChip extends StatelessWidget {
  final String label;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final bool selected;
  final Function(bool selected) onSelect;

  const CustomChip({
    Key? key,
    required this.label,
    this.color,
    this.width,
    this.height,
    this.margin,
    this.selected = false,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: selected ? (color ?? Colors.green) : Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(selected ? 25 : 10)),
        border: Border.all(
          color: selected ? (color ?? Colors.green) : Colors.grey,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => onSelect(!selected),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Visibility(
              visible: selected,
              child: const Icon(
                Icons.check_circle_outline,
                color: Colors.white,
                size: 32,
              ),
            ),
            Positioned(
              left: 9,
              right: 9,
              bottom: 7,
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  final String title;
  final Widget child;

  const Content({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  ContentState createState() => ContentState();
}

class ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            // color: Colors.blueGrey[50],
            child: Text(
              widget.title,
              style: const TextStyle(
                // color: Colors.blueGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Flexible(fit: FlexFit.loose, child: widget.child),
        ],
      ),
    );
  }
}

void _about(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(
              'chips_choice',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.black87),
            ),
            subtitle: const Text('by davigmacode'),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Easy way to provide a single or multiple choice chips.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.black54),
                  ),
                  Container(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

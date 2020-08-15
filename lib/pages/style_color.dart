import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm/common/utils/utils.dart';

class StyleColorPage extends StatefulWidget {
  StyleColorPage({Key key}) : super(key: key);

  StyleColorPageState createState() => StyleColorPageState();
}

class StyleColorPageState extends State<StyleColorPage> {
  String title;
  int ids;
  _numcheck() async {
    int a;
    if (a == null) {
      ids = 0;
    } else {
      setState(() {
        ids = a;
      });
    }
  }

  void initState() {
    super.initState();
    this._numcheck();
  }

  StyleColorPageState({this.title = "主题风格"});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: ListView.builder(
            itemCount: colorsList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                    color: colorsList[index],
                    width: 40,
                    height: 40,
                    child: ids == index ? Icon(Icons.check) : Center()),
                title: Text(colorsListText[index]),
                onTap: () {
                  //更换主题
                  Provider.of<Counter>(context).countColors(index);
                },
              );
            }));
  }
}

import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {

  final Function(String text) func;
  const TextComposer({this.func});

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[200])))
            : null,
        child: Row(
          children: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 15.0),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration.collapsed(
                      hintText: "Enviar uma mensagem"),
                  onChanged: (data) {
                    setState(() {
                      if (data.isNotEmpty) {
                        _isComposing = true;
                      } else {
                        _isComposing = false;
                      }
                    });
                  },
                ),
              ),
            ),
            Container(
              child: IconButton(
                icon: _isComposing
                    ? Icon(Icons.send)
                    : Icon(
                        Icons.send,
                        color: Colors.grey,
                      ),
                onPressed: _isComposing
                    ? () {
                      widget.func(_textController.text);
                      _textController.clear();
                    }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

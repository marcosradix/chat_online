import 'package:flutter/material.dart';


class ChatMessage extends StatelessWidget {
final Map<String, dynamic> data;
const ChatMessage(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(data["senderPhotoUrl"]),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(data["senderName"],
                style: Theme.of(context).textTheme.subtitle1,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: data["imageUrl"] != null ?
                  Image.network(data["imageUrl"], width: 250,):
                  Text( data["text"])
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}
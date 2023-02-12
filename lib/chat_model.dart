enum chatMessagetype { user, bot }

class ChatMessage {
  ChatMessage({this.text, this.type});
  String? text;
  chatMessagetype? type;
}

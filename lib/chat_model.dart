enum ChatMessagetype { user, bot }

class ChatMessage {
  ChatMessage({this.text, this.type});
  String? text;
  ChatMessagetype? type;
}

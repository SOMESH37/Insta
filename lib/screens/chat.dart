import '../helper.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController control = TextEditingController();
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              splashRadius: 1,
              tooltip: 'Back to feed',
              alignment: Alignment.centerLeft,
              onPressed: () {
                if (isSearching) {
                  setState(() {
                    isSearching = false;
                  });
                  control.clear();
                } else
                  pageController.previousPage(
                    duration: Duration(milliseconds: 150),
                    curve: Curves.easeIn,
                  );
              },
            ),
            isSearching
                ? Container(
                    child: buildSearchField(context, control),
                    width: screenW - 140,
                  )
                : Text(
                    'Chats',
                    style: Theme.of(context).textTheme.headline4.copyWith(letterSpacing: 1.2),
                  ),
            Spacer(),
            IconButton(
              splashRadius: 1,
              tooltip: isSearching ? 'Clear' : 'Search',
              color: Theme.of(context).textTheme.headline4.color,
              icon: isSearching ? Icon(Icons.clear_rounded) : Icon(Icons.search_rounded),
              iconSize: isSearching ? 26 : 30,
              onPressed: () {
                if (isSearching && control.text.isNotEmpty)
                  control.clear();
                else
                  setState(() {
                    isSearching = !isSearching;
                  });
              },
            ),
          ],
        ),
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 8),
        itemBuilder: (c, index) => ChatTile(index),
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final int index;
  final bool isSeen = Random().nextBool();
  ChatTile(this.index);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatTo(index),
          ),
        );
      },
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          Hero(
            tag: 'toChatTo$index',
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: circularImg('https://picsum.photos/id/${155 + index}/100', 65),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: isSeen
                      ? Theme.of(context).textTheme.headline5
                      : Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Laborum exercitation nostru d t e mpor sit enim ipsum ad cupidatat ut.',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: isSeen
                      ? Theme.of(context).textTheme.headline6
                      : Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
          Container(
            width: 48,
            child: isSeen
                ? Center(child: Text('${Random().nextInt(59)}m'))
                : Icon(
                    Icons.circle,
                    color: Color(0xff1477f8),
                    size: 12,
                  ),
          ),
        ],
      ),
    );
  }
}

// TODO: temporary chat model
class MyChats {
  bool sendByMe;
  String msg, time;
  MyChats(this.msg, this.sendByMe, this.time);
  static List<MyChats> kAllChats = [];
}

class ChatTo extends StatefulWidget {
  final int index;
  ChatTo(this.index);

  @override
  _ChatToState createState() => _ChatToState();
}

class _ChatToState extends State<ChatTo> {
  @override
  void initState() {
    super.initState();
    MyChats.kAllChats.clear();
    for (var i = 0; i < Random().nextInt(300); i++) {
      var msg =
          'Minim aliqua magna do sit nisi laborum ex irure anim. Enim qui aliquip non cupidatat cupidatat laborum amet incididunt dolor anim deserunt. Deserunt reprehenderit anim laboris commodo ut sint consequat laborum Lorem non exercitation exercitation dolor. Veniam sunt amet voluptate labore et sint ea dolor nostrud culpa aute.';
      MyChats.kAllChats.add(MyChats(msg.substring(0, Random().nextInt(msg.length)),
          Random().nextBool(), '${Random().nextInt(12)}:${Random().nextInt(59)}am'));
    }
  }

  String text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              splashRadius: 1,
              tooltip: 'Back to chats',
              alignment: Alignment.centerLeft,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Hero(
              tag: 'toChatTo${widget.index}',
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: circularImg('https://picsum.photos/id/${155 + widget.index}/100', 40),
              ),
            ),
            Expanded(
              child: Text(
                'Name',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Spacer(),
            IconButton(
              splashRadius: 1,
              tooltip: 'More',
              color: Theme.of(context).textTheme.headline4.color,
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true,
              children: [
                if (MyChats.kAllChats.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: MyChats.kAllChats.length + 1,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    itemBuilder: (c, index) => index == MyChats.kAllChats.length
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                                MyChats.kAllChats.last.sendByMe
                                    ? Random().nextBool()
                                        ? 'Seen   '
                                        : 'Delivered   '
                                    : '',
                                style: TextStyle(color: Colors.grey)),
                          )
                        : Dismissible(
                            key: UniqueKey(),
                            confirmDismiss: (direction) async => false,
                            dismissThresholds: {
                              DismissDirection.endToStart: 2,
                              DismissDirection.startToEnd: 2,
                            },
                            direction: MyChats.kAllChats[index].sendByMe
                                ? DismissDirection.endToStart
                                : DismissDirection.startToEnd,
                            background: ChatBubble(2, index),
                            secondaryBackground: ChatBubble(2, index),
                            child: ChatBubble(1, index),
                          ),
                  ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: circularImg('https://picsum.photos/id/${155 + widget.index}/100', 100),
                    ),
                    Text(
                      'Name',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      'user_name',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 26),
                      child: Container(
                        width: 136,
                        height: 36,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text('View profile'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: TextField(
              maxLines: 5,
              minLines: 1,
              style: Theme.of(context).textTheme.bodyText2,
              onChanged: (value) {
                value = value.trim();
                if (text.isEmpty ^ value.isEmpty) setState(() {});
                text = value;
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  splashRadius: 1,
                  iconSize: 34,
                  icon: Container(
                    height: 34,
                    width: 34,
                    alignment: Alignment(0.4, 0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: text.isEmpty ? Colors.grey[350] : Colors.blueAccent,
                    ),
                    child: Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  onPressed: text.isEmpty
                      ? null
                      : () {
                          MyChats.kAllChats.add(MyChats(
                              text, true, '${Random().nextInt(12)}:${Random().nextInt(59)}am'));
                          setState(() {});
                        },
                ),
                contentPadding: const EdgeInsets.all(16),
                hintText: 'Type a message',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatefulWidget {
  final int type, index;
  ChatBubble(this.type, this.index);
  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Align(
        alignment:
            MyChats.kAllChats[widget.index].sendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 13, horizontal: 14),
          constraints: BoxConstraints(
            maxWidth: screenW * 0.82,
          ),
          decoration: BoxDecoration(
            color: widget.type == 1
                ? MyChats.kAllChats[widget.index].sendByMe
                    ? Color(0xff1477f8)
                    : Colors.grey[300]
                : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
          ),
          child: RichText(
            text: TextSpan(
              children: [
                if (widget.type == 2)
                  TextSpan(
                    text: MyChats.kAllChats[widget.index].sendByMe
                        ? '${MyChats.kAllChats[widget.index].time} ↑ '
                        : '${MyChats.kAllChats[widget.index].time} ↓ ',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: MyChats.kAllChats[widget.index].sendByMe
                            ? Color(0xbf1477f8)
                            : Colors.grey),
                  )
                else
                  TextSpan(
                    text: MyChats.kAllChats[widget.index].msg,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontSize: 15,
                        color: MyChats.kAllChats[widget.index].sendByMe
                            ? Colors.white
                            : Color(0xff292929)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

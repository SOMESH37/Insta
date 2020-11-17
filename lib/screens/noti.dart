import '../helper.dart';

class Noti extends StatefulWidget {
  @override
  _NotiState createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  int chipIdx = 1;

  Widget makeChip(int type) {
    String findLabel() {
      switch (type) {
        case 1:
          return 'All';
          break;
        case 2:
          return 'Requests';
          break;
        case 3:
          return 'Comments';
          break;
        case 4:
          return 'Likes';
          break;
        case 5:
          return 'Birthdays';
          break;
        default:
          return 'Impossible';
      }
    }

    return ChoiceChip(
      onSelected: (a) {
        if (a)
          setState(() {
            chipIdx = type;
          });
      },
      label: Text(findLabel()),
      selected: chipIdx == type,
      shape: StadiumBorder(
        side: chipIdx == type
            ? BorderSide(
                color: Color(0xff1477f8),
                width: 0.6,
              )
            : BorderSide.none,
      ),
      pressElevation: 6,
      elevation: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Activity',
            style: Theme.of(context).textTheme.headline5.copyWith(letterSpacing: 1),
          ),
        ),
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            scrollDirection: Axis.horizontal,
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,
              spacing: 10,
              children: [
                for (int i = 1; i < 6; i++) makeChip(i),
              ],
            ),
          ),
          Container(
            height: screenH * 0.7,
            width: screenW * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                makeReqCard(context),
                makeCommentCard(context),
                makeLikeCard(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget makeReqCard(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    height: 250,
    width: 190,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
    ),
    child: Column(
      children: [
        circularImg('https://picsum.photos/id/${Random().nextInt(1000)}/100', 80),
        Text(
          'Name Lorem',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          'user_name',
          style: Theme.of(context).textTheme.headline6,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: 136,
          height: 56,
          child: OutlinedButton(
            onPressed: () {},
            child: Text(
              'Delete',
            ),
          ),
        ),
        Container(
          width: 136,
          height: 36,
          child: RaisedButton(
            onPressed: () {},
            child: Text('Accept'),
          ),
        ),
      ],
    ),
  );
}

Widget makeCommentCard(BuildContext context) {
  return Container(
    padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
    width: screenW,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
    ),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: circularImg('https://picsum.photos/id/${Random().nextInt(1000)}/100', 56),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Name Lorem pisicing',
                  style: Theme.of(context).textTheme.headline5,
                  children: [
                    TextSpan(
                      text: ' • Commented',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                    'Laboris laboris elit nostrud id veniam id sunt laboris amet qui. Veniam irure consectetur quis eiusmod. In ipsum eu id duis. Veniam commodo incididunt culpa dolore.'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget makeLikeCard(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    width: screenW,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
    ),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: circularImg('https://picsum.photos/id/${Random().nextInt(1000)}/100', 56),
        ),
        Row(
          children: [
            Text(
              'Name Laboris veniam',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              ' • Liked',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ],
    ),
  );
}

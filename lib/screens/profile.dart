import 'dart:ui';

import 'package:day_night_switcher/day_night_switcher.dart';

import '../helper.dart';

class Profile extends StatefulWidget {
  final String userName;
  Profile({this.userName});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isMore = false, isPreview = false;
  int idx;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(
                    widget.userName ?? 'user_name',
                    style: Theme.of(context).textTheme.headline5.copyWith(letterSpacing: 1),
                  ),
                  Spacer(),
                  if (widget.userName == null)
                    Row(
                      children: [
                        Container(
                          width: AppBar().preferredSize.height,
                          height: AppBar().preferredSize.height,
                          // padding: EdgeInsets.all(30),
                          child: DayNightSwitcherIcon(
                            // cloudsColor: Colors.blue,
                            // dayBackgroundColor: Colors.blue[50],
                            // sunColor: Colors.amber[300],
                            // nightBackgroundColor: Colors.black,
                            isDarkModeEnabled:
                                Provider.of<MyTheme>(context).currentTheme == MyTheme.myDark,
                            onStateChanged: (aBool) => aBool
                                ? Provider.of<MyTheme>(context, listen: false).setCurrentTheme(1)
                                : Provider.of<MyTheme>(context, listen: false).setCurrentTheme(0),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {},
                          iconSize: 30,
                          visualDensity: VisualDensity.compact,
                          splashRadius: 1,
                          tooltip: 'More options',
                        ),
                      ],
                    ),
                ],
              ),
            ),
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          body: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            circularImg('https://picsum.photos/id/525/150', 100),
                            numColumn(28, 'Posts'),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Follow(widget.userName, 0),
                                    ),
                                  );
                                },
                                child: numColumn(237, 'Followers')),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Follow(widget.userName, 1),
                                    ),
                                  );
                                },
                                child: numColumn(309, 'Following')),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            GestureDetector(
                              onTap: () {
                                isMore = !isMore;
                                setState(() {});
                              },
                              child: Text(
                                'Magna aliquip Lorem sunt laboris duis elit aliqua velit reprehenderit ea voluptate do. Ullamco nisi ut anim nulla voluptate Lorem occaecat. Aliquip occaecat pariatur ex excepteur exercitation ad cillum mollit dolor sit labore reprehenderit tempor. Est et laboris est eiusmod cillum sunt sit officia duis. Elit laboris dolore velit Lorem culpa amet voluptate eu sint do deserunt officia pariatur. Sit incididunt eu occaecat nostrud voluptate dolor sunt. Nostrud cupidatat pariatur ullamco adipisicing anim elit ullamco ea aliqua eu ipsum.',
                                maxLines: isMore ? null : 2,
                                overflow: isMore ? null : TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: widget.userName == null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  buttonColumn(1, context),
                                  buttonColumn(2, context),
                                  buttonColumn(3, context),
                                ],
                              )
                            : Container(
                                height: 34,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: false
                                    ? OutlineButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Unfollow',
                                        ),
                                      )
                                    : RaisedButton(
                                        onPressed: () {},
                                        child: Text('Follow'),
                                      ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
              body: Column(
                children: [
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.grey[500],
                    labelColor: Provider.of<MyTheme>(context).currentTheme == MyTheme.myLight
                        ? Colors.black
                        : Colors.white,
                    indicatorColor: Provider.of<MyTheme>(context).currentTheme == MyTheme.myLight
                        ? Colors.black
                        : Colors.white,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                    tabs: [
                      Tab(
                        text: 'Posts',
                      ),
                      Tab(
                        text: 'Tags',
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        StaggeredGridView.countBuilder(
                          itemCount: 28,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          crossAxisCount: 3,
                          staggeredTileBuilder: (index) =>
                              index == 0 ? StaggeredTile.count(2, 2) : StaggeredTile.count(1, 1),
                          itemBuilder: (context, index) => GestureDetector(
                            onLongPressStart: (_) {
                              idx = index;
                              setState(() {
                                isPreview = true;
                              });
                            },
                            onLongPressEnd: (details) {
                              setState(() {
                                isPreview = false;
                              });
                            },
                            onTap: () {},
                            child: FadeInImage(
                              fit: BoxFit.cover,
                              placeholder:
                                  AssetImage(index == 0 ? resourceHelper[1] : resourceHelper[0]),
                              image: NetworkImage('https://picsum.photos/id/${index + 464}/400'),
                            ),
                          ),
                        ),
                        StaggeredGridView.countBuilder(
                          itemCount: 8,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          crossAxisCount: 3,
                          staggeredTileBuilder: (index) => StaggeredTile.count(1, 1),
                          itemBuilder: (context, index) => GestureDetector(
                            onLongPressStart: (_) {
                              idx = index;
                              setState(() {
                                isPreview = true;
                              });
                            },
                            onLongPressEnd: (details) {
                              setState(() {
                                isPreview = false;
                              });
                            },
                            onTap: () {},
                            child: FadeInImage(
                              fit: BoxFit.cover,
                              placeholder: AssetImage(resourceHelper[0]),
                              image: NetworkImage('https://picsum.photos/id/${index + 404}/400'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isPreview) zoomImg(context, 'https://picsum.photos/id/${idx + 464}/400'),
      ],
    );
  }
}

Widget buttonColumn(int type, BuildContext context) {
  String buttonText() => type == 1
      ? 'Saved posts'
      : type == 2
          ? 'Create'
          : 'Edit profile';

  IconData buttonIcon() => type == 1
      ? Icons.bookmark_rounded
      : type == 2
          ? Icons.add_circle
          : Icons.edit_rounded;

  handleTap() {
    if (type == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Saved(),
        ),
      );
    } else if (type == 2) {
      print('Clicked Create');
    } else {
      print('Clicked Edit');
    }
  }

  return ActionChip(
    pressElevation: 0,
    labelPadding: EdgeInsets.fromLTRB(1, 2.5, 0, 2.5),
    padding: EdgeInsets.only(right: 15, left: 1),
    shape: StadiumBorder(
      side: BorderSide(
        color: Colors.grey[500],
        width: 0,
      ),
    ),
    avatar: Icon(
      buttonIcon(),
      color: Colors.grey[600],
    ),
    onPressed: handleTap,
    label: Text(
      buttonText(),
      textHeightBehavior: TextHeightBehavior(applyHeightToLastDescent: false),
      style: TextStyle(
        color: Colors.grey[600],
        // textBaseline: TextBaseline.ideographic,
      ),
    ),
  );
}

Widget numColumn(int n, String title) {
  return Column(
    children: [
      Text(
        '$n',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      Text(
        '$title',
        style: TextStyle(
          color: Colors.grey[500],
        ),
      ),
    ],
  );
}

class Follow extends StatefulWidget {
  final String userName;
  final int index;
  Follow(this.userName, this.index);

  @override
  _FollowState createState() => _FollowState();
}

class _FollowState extends State<Follow> {
  TextEditingController control = TextEditingController();
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.index,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              isSearching
                  ? Container(
                      child: buildSearchField(context, control),
                      width: screenW - 140,
                    )
                  : Text(
                      widget.userName ?? 'user_name',
                      style: Theme.of(context).textTheme.headline5.copyWith(letterSpacing: 1),
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
          bottom: TabBar(
            unselectedLabelColor: Colors.grey[500],
            labelColor: Provider.of<MyTheme>(context).currentTheme == MyTheme.myLight
                ? Colors.black
                : Colors.white,
            indicatorColor: Provider.of<MyTheme>(context).currentTheme == MyTheme.myLight
                ? Colors.black
                : Colors.white,
            labelStyle: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            tabs: [
              Tab(
                text: '237 Followers',
              ),
              Tab(
                text: '309 Following',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: 237,
              itemBuilder: (context, index) => FollowTile(1),
            ),
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: 309,
              itemBuilder: (context, index) => FollowTile(2),
            ),
          ],
        ),
      ),
    );
  }
}

class FollowTile extends StatefulWidget {
  final int type;
  FollowTile(this.type);
  @override
  _FollowTileState createState() => _FollowTileState();
}

class _FollowTileState extends State<FollowTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
          child: circularImg('https://picsum.photos/id/${Random().nextInt(645)}/100', 54),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.headline5),
            Text('user_name',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.headline6),
          ],
        ),
        Spacer(),
        Container(
          height: 35,
          width: 135,
          child: widget.type == 1
              ? OutlinedButton(
                  child: Text('Remove'),
                  onPressed: () {},
                )
              : widget.type == 2
                  ? OutlinedButton(
                      child: Text('Unfollow', style: TextStyle(color: Colors.black)),
                      onPressed: () {},
                    )
                  : RaisedButton(
                      child: Text('Follow'),
                      onPressed: () {},
                    ),
        ),
      ],
    );
  }
}

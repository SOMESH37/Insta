import 'dart:io';

import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/cupertino.dart';
import '../helper.dart';

class Profile extends StatefulWidget {
  final String userName;
  final toggleDrawer;
  Profile({this.userName, this.toggleDrawer});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isMore = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(
                'c_daddy',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(letterSpacing: 1),
              ),
              Spacer(),
              if (widget.userName == null && widget.toggleDrawer != null)
                IconButton(
                  onPressed: () => widget.toggleDrawer(true),
                  icon: Icon(Icons.menu_rounded),
                  splashRadius: 1,
                  iconSize: 30,
                ),
            ],
          ),
        ),
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 20),
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
                                  builder: (context) => Follow(0),
                                ),
                              );
                            },
                            child: numColumn(237, 'Followers')),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Follow(1),
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
                          'Dennis Ritchie',
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
                            'Created the C programming language and, with long-time colleague Ken Thompson, the Unix operating system and B programming language.',
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
                labelColor: Provider.of<MyTheme>(context).currentTheme ==
                        MyTheme.myLight
                    ? Colors.black
                    : Colors.white,
                indicatorColor: Provider.of<MyTheme>(context).currentTheme ==
                        MyTheme.myLight
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
                      staggeredTileBuilder: (index) => index == 0
                          ? StaggeredTile.count(2, 2)
                          : StaggeredTile.count(1, 1),
                      itemBuilder: (context, index) => Stack(
                        children: [
                          FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: AssetImage(index == 0
                                ? resourceHelper[1]
                                : resourceHelper[0]),
                            image: NetworkImage(
                                'https://picsum.photos/id/${index + 490}/600'),
                          ),
                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                child: GestureDetector(
                                  onLongPressStart: (_) {
                                    currentPreviewImgUrl =
                                        'https://picsum.photos/id/${index + 490}/600';

                                    isPreview.sink.add(true);
                                  },
                                  onLongPressEnd: (details) {
                                    isPreview.sink.add(false);
                                  },
                                ),
                                onTap: () {
                                  pushThePost(context, index + 490);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    StaggeredGridView.countBuilder(
                      itemCount: 8,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      crossAxisCount: 3,
                      staggeredTileBuilder: (index) =>
                          StaggeredTile.count(1, 1),
                      itemBuilder: (context, index) => Stack(
                        children: [
                          FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: AssetImage(resourceHelper[0]),
                            image: NetworkImage(
                                'https://picsum.photos/id/${index + 404}/600'),
                          ),
                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                child: GestureDetector(
                                  onLongPressStart: (_) {
                                    currentPreviewImgUrl =
                                        'https://picsum.photos/id/${index + 404}/600';
                                    isPreview.sink.add(true);
                                  },
                                  onLongPressEnd: (details) {
                                    isPreview.sink.add(false);
                                  },
                                ),
                                onTap: () {
                                  pushThePost(context, index + 404);
                                },
                              ),
                            ),
                          ),
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
    );
  }
}

Widget buttonColumn(int type, BuildContext context) {
  handleOptionsTap() {
    if (type == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Saved(),
        ),
      );
    } else if (type == 2) {
      navigateTo(context, 2);
    } else {
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (context) => EditProfile(),
        ),
      );
    }
  }

  IconData buttonIcon(type) => type == 1
      ? Icons.bookmark_rounded
      : type == 2
          ? Icons.add_circle
          : Icons.edit_rounded;
  String buttonText() => type == 1
      ? 'Saved posts'
      : type == 2
          ? 'Create'
          : 'Edit profile';

  return ActionChip(
    pressElevation: 0,
    labelPadding: EdgeInsets.fromLTRB(1, 2.5, 0, 2.5),
    padding: EdgeInsets.only(right: 15, left: 1),
    backgroundColor:
        Provider.of<MyTheme>(context).currentTheme == MyTheme.myLight
            ? Colors.white
            : Color(0xff3a464f),
    shape: StadiumBorder(
      side: BorderSide(
        color: Provider.of<MyTheme>(context).currentTheme == MyTheme.myLight
            ? Colors.grey[400]
            : Colors.transparent,
        width: 0,
      ),
    ),
    avatar: Icon(
      buttonIcon(type),
      color: Provider.of<MyTheme>(context).currentTheme == MyTheme.myLight
          ? Colors.grey[600]
          : Colors.white,
    ),
    onPressed: handleOptionsTap,
    label: Text(
      buttonText(),
      textHeightBehavior: TextHeightBehavior(applyHeightToLastDescent: false),
      style: TextStyle(
        color: Provider.of<MyTheme>(context).currentTheme == MyTheme.myLight
            ? Colors.grey[600]
            : Colors.white,
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

class Follow extends StatelessWidget {
  final int index;
  Follow(this.index);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: index,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'c_daddy',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(letterSpacing: 1),
              ),
              Spacer(),
              IconButton(
                splashRadius: 1,
                tooltip: 'Search',
                color: Theme.of(context).textTheme.headline4.color,
                icon: Icon(Icons.search_rounded),
                iconSize: 30,
                onPressed: () {},
              ),
            ],
          ),
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          bottom: TabBar(
            unselectedLabelColor: Colors.grey[500],
            labelColor:
                Provider.of<MyTheme>(context).currentTheme == MyTheme.myLight
                    ? Colors.black
                    : Colors.white,
            indicatorColor:
                Provider.of<MyTheme>(context).currentTheme == MyTheme.myLight
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
              itemBuilder: (context, index) => FollowTile(1, index),
            ),
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: 309,
              itemBuilder: (context, index) => FollowTile(0, index),
            ),
          ],
        ),
      ),
    );
  }
}

class FollowTile extends StatelessWidget {
  final int type;
  final int index;
  FollowTile(this.type, this.index);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
          child: circularImg(
              'https://picsum.photos/id/${index + 648 * type}/100', 54),
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
          child: type == 1
              ? OutlinedButton(
                  child: Text('Remove'),
                  onPressed: () {},
                )
              : type == 0
                  ? OutlinedButton(
                      child: Text('Unfollow'),
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

class MyDrawer extends StatefulWidget {
  final toggleDrawer;
  MyDrawer(this.toggleDrawer);
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

var allAccounts = [
  [true, 'Dennis Ritchie', 'c_daddy'],
  [false, 'Just Exist', 'third.eye'],
  [false, 'John Marshal', 'beyond.above'],
  [false, 'Tech Surf', 'tech_surf'],
];

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenW * 0.62,
      child: ListView(
        children: [
          if (true)
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My accounts',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () => widget.toggleDrawer(false),
                    icon: Icon(Icons.close_fullscreen_rounded),
                  ),
                ],
              ),
            ),
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: allAccounts[index][0] ? Color(0xff1477f8) : null,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(100)),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                      child: circularImg(
                          'https://picsum.photos/id/${525 + index}/150', 56),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${allAccounts[index][1]}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      color: allAccounts[index][0]
                                          ? Colors.white
                                          : null,
                                    ),
                          ),
                          Text(
                            '${allAccounts[index][2]}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: allAccounts[index][0]
                                          ? Colors.white
                                          : null,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Options',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    if (!true)
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () => widget.toggleDrawer(false),
                        icon: Icon(Icons.close_fullscreen_rounded),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 22, top: 10),
                  child: Row(
                    children: [
                      Icon(Icons.nights_stay_rounded),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Dark mode',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 56,
                        height: 48,
                        child: DayNightSwitcher(
                          isDarkModeEnabled:
                              Provider.of<MyTheme>(context).currentTheme ==
                                  MyTheme.myDark,
                          onStateChanged: (aBool) => aBool
                              ? Provider.of<MyTheme>(context, listen: false)
                                  .setCurrentTheme(1)
                              : Provider.of<MyTheme>(context, listen: false)
                                  .setCurrentTheme(0),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Future.delayed(Duration(milliseconds: 500),
                        () => widget.toggleDrawer(false));
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Saved(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.bookmark_rounded),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Saved posts',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 36),
                  child: InkWell(
                    onTap: () {
                      Future.delayed(Duration(milliseconds: 500),
                          () => widget.toggleDrawer(false));
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) => EditProfile(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.edit_rounded),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Edit profile',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Future.delayed(Duration(milliseconds: 500),
                        () => widget.toggleDrawer(false));
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MoreOptions(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.more_horiz_rounded),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'More options',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MoreOptions extends StatefulWidget {
  @override
  _MoreOptionsState createState() => _MoreOptionsState();
}

class _MoreOptionsState extends State<MoreOptions> {
  bool isPrivate = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'More options',
          style:
              Theme.of(context).textTheme.headline5.copyWith(letterSpacing: 1),
        ),
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    Icons.lock_outline_rounded,
                    size: 32,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Private account',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        'If enabled then only your followers will be able to see your posts and stories. ',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: CupertinoSwitch(
                    value: isPrivate,
                    onChanged: (v) {
                      setState(() {
                        isPrivate = !isPrivate;
                      });
                    },
                    activeColor: Color(0xff1477f8),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  Icons.link_rounded,
                  size: 32,
                ),
              ),
              Text(
                'Create new linked account',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Icon(
                    Icons.vpn_key_outlined,
                    size: 28,
                  ),
                ),
                Text(
                  'Change password',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Icon(
                  Icons.logout,
                  size: 28,
                ),
              ),
              Text(
                'Log out',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> _formKey = GlobalKey();
  File pic;
  @override
  void initState() {
    super.initState();
    editProfileData.replaceRange(0, 3, ['Name ', 'user_name', '']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit profile',
          style:
              Theme.of(context).textTheme.headline5.copyWith(letterSpacing: 1),
        ),
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: pic != null
                  ? Container(
                      width: 150,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.file(pic))
                  : circularImg('https://picsum.photos/id/${151}/100', 150),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 26),
              child: Container(
                width: 140,
                height: 36,
                child: OutlineButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    var croppedimg;
                    var img = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    if (img != null)
                      croppedimg = await ImageCropper.cropImage(
                        sourcePath: img.path,
                        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                        androidUiSettings: AndroidUiSettings(
                          activeControlsWidgetColor: Color(0xff1477f8),
                          toolbarColor: Colors.white,
                          toolbarWidgetColor: Color(0xff1477f8),
                        ),
                        compressFormat: ImageCompressFormat.jpg,
                        compressQuality: getSize(File(img.path).lengthSync()),
                      );
                    if (croppedimg != null) {
                      pic = croppedimg;
                      setState(() {});
                    }
                  },
                  child: Text('Change picture'),
                  shape: StadiumBorder(),
                ),
              ),
            ),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextFields2(context, 1),
                    buildTextFields2(context, 2),
                    buildTextFields2(context, 3),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: RaisedButton(
        onPressed: () {
          if (!_formKey.currentState.validate()) return;
        },
        child: Text('Save'),
        shape: ContinuousRectangleBorder(),
      ),
    );
  }
}

List<String> editProfileData = ['', '', ''];

buildTextFields2(BuildContext context, int type) {
/*types:
  1 for name
  2 for username
  3 for birthDate
  enum would have been better...nah*/

  String labTxt() {
    switch (type) {
      case 1:
        return 'Name';
      case 2:
        return 'User name';
      case 3:
        return 'Birthdate';
      default:
        return '';
    }
  }

  String validators(value) {
    switch (type) {
      case 1:
        if (value.isEmpty) return 'Name can\'t be empty';
        if (!RegExp(r'^[a-z A-Z]{1,20}$').hasMatch(value))
          return 'Upto 20 alphabets are allowed';
        else
          return null;
        break;
      case 2:
        if (value.isEmpty) return 'Dots and underscores are allowed';
        if (value.length > 12 || value.length < 3)
          return 'Allowed character range is 3-12';
        if (!RegExp(r'^[0-9a-z._]{2,12}$').hasMatch(value))
          return 'Alphabets, numbers, dots and underscores are allowed only';
        else
          return null;
        break;
      case 3:
        if (value.isEmpty) return null;
        // 1950-2019, cant handle months n date together
        if (!RegExp(
                r'^(0[1-9]|[12]\d|3[01])-(0[1-9]|1[0-2])-([1][9][5-9]\d|[2][0][0-1]\d)$')
            .hasMatch(value))
          return 'Invaild date';
        else
          return null;
        break;
      default:
        return null;
    }
  }

  saving(String value) {
    switch (type) {
      case 1:
        editProfileData[0] = value;
        break;
      case 2:
        editProfileData[1] = value;
        break;
      case 3:
        editProfileData[2] = value;
        break;
    }
  }

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: TextFormField(
      inputFormatters: [
        if (type == 1)
          FilteringTextInputFormatter.allow(
            RegExp('[a-z A-Z]'),
          ),
        if (type == 2)
          FilteringTextInputFormatter.allow(
            RegExp('[a-z0-9._]'),
          ),
        if (type == 3)
          FilteringTextInputFormatter.allow(
            RegExp('[-0-9]'),
          ),
      ],
      style: Theme.of(context).textTheme.bodyText2,
      initialValue: editProfileData[type - 1],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        fillColor: Colors.transparent,
        border:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
        errorBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
        focusedErrorBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
        // prevents jumping
        helperText: '',
        labelText: labTxt(),
        hintText: type == 3 ? 'dd-mm-yyyy' : null,
        errorStyle: TextStyle().copyWith(color: Colors.blue),
      ),
      validator: (value) => validators(value),
      onChanged: (value) => saving(value),
    ),
  );
}

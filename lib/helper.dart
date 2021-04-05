import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

export 'dart:async';
export 'dart:convert';
export 'dart:math';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
export 'package:image_cropper/image_cropper.dart';
export 'package:image_picker/image_picker.dart';
export 'package:provider/provider.dart';
export 'providers/bottomnavbar.dart';
export 'providers/themes.dart';
export 'screens/authentication.dart';
export 'screens/chat.dart';
export 'screens/createPost.dart';
export 'screens/createStory.dart';
export 'screens/explore.dart';
export 'screens/home.dart';
export 'screens/filters.dart';
export 'screens/noti.dart';
export 'screens/profile.dart';
export 'screens/saved.dart';

const kurl = 'https://not_deployed.ngrok.io';

const String kAppName = 'Insta';

const List resourceHelper = [
  'resources/loading_mini.png',
  'resources/loading.png',
  'resources/logo.png', //app logo
  'resources/google_logo.png', //google logo png
  'resources/profile.png',
  'resources/post.png',
  'resources/story.png',
  'resources/camera.png',
  'resources/gallery.png',
  'resources/profile_dark.png',
  'resources/groupChat.svg',
  'resources/comment.svg',
  'resources/share.svg',
];
BuildContext mainContext;
String currentPreviewImgUrl = '';
var isPreview = StreamController<bool>();
double screenH, screenW;
toast(BuildContext context, String m) {
  return Fluttertoast.showToast(
    msg: m,
    backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
    textColor: Theme.of(context).textTheme.bodyText2.backgroundColor,
  );
}

class ZoomImg extends StatelessWidget {
  final url;
  ZoomImg(this.url);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 8,
          sigmaY: 8,
        ),
        child: Container(
          height: screenH,
          width: screenW,
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Theme.of(context).bottomNavigationBarTheme.backgroundColor.withOpacity(0.96),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
                      child: circularImg('https://picsum.photos/id/525/150', 42),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dennis Ritchie',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.headline5),
                          Text('Bronxville, New York',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.headline6),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10)),
                ),
                child: FadeInImage(
                  fit: BoxFit.contain,
                  placeholder: AssetImage(resourceHelper[1]),
                  image: NetworkImage(url),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget circularImg(String url, double size) {
  return Container(
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
    ),
    child: FadeInImage(
      width: size,
      fit: BoxFit.cover,
      placeholder: AssetImage(resourceHelper[0]),
      image: NetworkImage(url),
    ),
  );
}

Future showMyDialog(context, String msg) async {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        buttonPadding: EdgeInsets.all(15),
        title: Text('Important Notice!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              // Text(isDis),
              Text(msg),
            ],
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Text(
              'Okay',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ],
      );
    },
  );
}

buildSearchField(BuildContext context, TextEditingController control) {
  return TextField(
    autofocus: true,
    controller: control,
    inputFormatters: [
      FilteringTextInputFormatter.allow(
        RegExp('[ A-Za-z0-9._]'),
      ),
    ],
    style:
        Theme.of(context).textTheme.headline5.copyWith(color: Colors.grey[600]),
    decoration: InputDecoration(
      hintText: 'Search',
      hintStyle: Theme.of(context)
          .textTheme
          .headline5
          .copyWith(color: Colors.grey[600]),
      contentPadding: EdgeInsets.zero,
    ),
    keyboardType: TextInputType.name,
  );
}

Future onSave(BuildContext cxt) {
  return showModalBottomSheet(
    elevation: double.infinity,
    backgroundColor: Theme.of(cxt).scaffoldBackgroundColor,
    context: cxt,
    clipBehavior: Clip.hardEdge,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) {
          return ListView(
            controller: scrollController,
            children: [
              Divider(
                height: 40,
                thickness: 4,
                endIndent: screenW * 0.44,
                indent: screenW * 0.44,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
                child: Row(
                  children: [
                    Text(
                      'Save to collection',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Spacer(),
                    ActionChip(
                      onPressed: () {
                        newCollection(context);
                      },
                      backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                      padding: EdgeInsets.all(6),
                      shape: StadiumBorder(),
                      label: Row(
                        children: [
                          Icon(
                            Icons.add,
                            size: 24,
                            color: Colors.grey[400],
                          ),
                          Text(
                            ' New collection',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: 7,
                itemBuilder: (cxt, index) => InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            width: 52,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: FadeInImage(
                                fit: BoxFit.cover,
                                placeholder: AssetImage(resourceHelper[0]),
                                image: NetworkImage(
                                    'https://picsum.photos/id/${727 + index}/100'),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Collection name',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Text(
                              '18 posts',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

Future newCollection(BuildContext cxt) {
  return showModalBottomSheet(
    isDismissible: false,
    enableDrag: false,
    // @important
    isScrollControlled: true,
    elevation: double.infinity,
    backgroundColor: Theme.of(cxt).scaffoldBackgroundColor,
    context: cxt,
    clipBehavior: Clip.hardEdge,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (cxt, reset) {
          return AbsorbPointer(
            absorbing: false,
            child: AnimatedPadding(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    leading: IconButton(
                      splashRadius: 1,
                      tooltip: 'Back',
                      color: Theme.of(context).textTheme.headline6.color,
                      icon: Icon(Icons.arrow_back),
                      iconSize: 28,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    centerTitle: true,
                    title: Text(
                      'New collection',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey[200],
                          blurRadius: 10,
                          spreadRadius: 4,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    width: 170,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: AssetImage(resourceHelper[1]),
                        image: NetworkImage(
                            'https://picsum.photos/id/666/250'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35, bottom: 65),
                    child: Container(
                      width: 140,
                      child: TextField(
                        autofocus: true,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(15),
                        ],
                        decoration: InputDecoration(
                          hintText: 'Collection name',
                          hintStyle: TextStyle(color: Colors.grey[300]),
                          isDense: true,
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: EdgeInsets.all(4),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Text('Save'),
                    shape: ContinuousRectangleBorder(),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

import 'dart:io';
import 'package:before_after/before_after.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import '../helper.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  bool isStep1 = true, isPost;

  Widget postsButton(int type) {
    String buttonText() => type == 5
        ? 'Post'
        : type == 6
            ? 'Story'
            : type == 7
                ? 'Camera'
                : 'Gallery';

    handleTap() {
      if (type == 5 || type == 6) {
        if (type == 5) isPost = true;
        if (type == 6) isPost = false;
        setState(() {
          isStep1 = false;
        });
      } else {
        if (type == 7 && isPost)
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => AddImg(7),
            ),
          );
        if (type == 7 && !isPost)
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => StoryEditor(7),
            ),
          );
        if (type == 8 && isPost)
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => AddImg(8),
            ),
          );
        if (type == 8 && !isPost)
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => StoryEditor(8),
            ),
          );
        setState(() {
          isStep1 = true;
        });
      }
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: handleTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Image.asset(
              resourceHelper[type],
              height: 70,
              color: (type == 7 || type == 8) ? Colors.grey : null,
            ),
          ),
          Text(
            buttonText(),
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            isStep1
                ? SizedBox(width: 40)
                : IconButton(
                    icon: Icon(Icons.arrow_back_ios_rounded),
                    visualDensity: VisualDensity.compact,
                    splashRadius: 1,
                    tooltip: 'Back',
                    onPressed: () {
                      setState(() {
                        isStep1 = true;
                      });
                    },
                  ),
            Text(
              'Create',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(letterSpacing: 1),
            ),
          ],
        ),
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Card(
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 60),
                    child: postsButton(isStep1 ? 5 : 7),
                  ),
                  postsButton(isStep1 ? 6 : 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<File> images = [];

int getSize(int len) {
  int size;
  if (len > (1250 * 1000))
    size = 40;
  else if (len < (200 * 1000))
    size = 100;
  else
    size = 70;
  return size;
}

class AddImg extends StatefulWidget {
  final int type;
  const AddImg(this.type);
  @override
  _AddImgState createState() => _AddImgState();
}

class _AddImgState extends State<AddImg> {
  void getImg(int type) async {
    var croppedimg;
    var img = await ImagePicker()
        .getImage(source: type == 7 ? ImageSource.camera : ImageSource.gallery);
    if (img != null)
      croppedimg = await ImageCropper.cropImage(
        sourcePath: img.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        androidUiSettings: AndroidUiSettings(
          // statusBarColor: Color(0xff1477f8), // status bar
          activeControlsWidgetColor: Color(0xff1477f8), // highlight color
          toolbarColor: Colors.white, // appbar color
          toolbarWidgetColor: Color(0xff1477f8), // appbar title color
        ),
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: getSize(File(img.path).lengthSync()),
      );
    if (croppedimg != null) {
      images.add(croppedimg);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    images.clear();
    getImg(widget.type);
  }

  @override
  void dispose() {
    images.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New post',
          style:
              Theme.of(context).textTheme.headline5.copyWith(letterSpacing: 1),
        ),
      ),
      body: ListView(
        children: [
          StaggeredGridView.countBuilder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 8),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            crossAxisCount: 2,
            itemCount: images.length < 10 ? images.length + 1 : images.length,
            staggeredTileBuilder: (index) => StaggeredTile.count(1, 1),
            itemBuilder: (context, index) => Stack(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  width: screenW/2,
                  height: screenW/2,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  ),
                  child: index == images.length
                      ? Icon(Icons.add_rounded,
                          size: 100, color: Colors.grey.withOpacity(0.3))
                      : Image.file(images[index]),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () async {
                        if (index == images.length)
                          getImg(8);
                        else {
                          var res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FilterPage(index),
                            ),
                          );
                          if (res != null) setState(() {});
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                'Tap an image to apply filters',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: RaisedButton(
        onPressed: () {
          if (images.length > 0)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FinishPosting(),
              ),
            );
        },
        child: Text('Next'),
        shape: ContinuousRectangleBorder(),
      ),
    );
  }
}

class FinishPosting extends StatefulWidget {
  @override
  _FinishPostingState createState() => _FinishPostingState();
}

class _FinishPostingState extends State<FinishPosting> {
  var control = TextEditingController();
  bool isLoad = false, isSearch = false;
  List<String> tags = [
    'James Gosling',
    'Tim Berners',
    'Bill Gates',
    'Steve Jobs'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenW, AppBar().preferredSize.height),
        child: AppBar(
          title: Text(
            'New post',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(letterSpacing: 1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      width: 80,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.file(images[0]),
                      ),
                    ),
                  ),
                  Container(
                    width: screenW - 110,
                    child: TextField(
                      maxLines: 12,
                      minLines: 1,
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(16),
                        hintText: 'Write a caption',
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(2000),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 32, bottom: 8),
                child: Text(
                  'Add Location',
                ),
              ),
              TextField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16),
                  hintText: 'Add a location',
                  prefixIcon:
                      Icon(Icons.location_on_rounded, color: Color(0xff1477f8)),
                ),
                textCapitalization: TextCapitalization.words,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 32, bottom: 8),
                child: Text(
                  'Tag people',
                ),
              ),
              ExpansionTile(
                initiallyExpanded: false,
                onExpansionChanged: (v) {
                  setState(() {});
                },
                backgroundColor: Colors.transparent,
                tilePadding: EdgeInsets.zero,
                trailing: IconButton(
                  splashRadius: 1,
                  color: Theme.of(context).textTheme.headline4.color,
                  alignment: Alignment.centerLeft,
                  icon: isSearch
                      ? Icon(Icons.clear_rounded)
                      : Icon(Icons.search_rounded),
                  iconSize: (control.text.trim().isNotEmpty) ? 26 : 30,
                  onPressed: (isSearch && control.text.trim().isNotEmpty)
                      ? () {
                          control.clear();
                          setState(() {});
                        }
                      : null,
                ),
                title: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[ A-Za-z0-9._]'),
                    ),
                  ],
                  controller: control,
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    hintText: 'People to tag',
                    prefixIcon: Icon(Icons.people_alt_rounded,
                        color: Color(0xff1477f8)),
                  ),
                ),
              ),
              if (tags.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 32, bottom: 8),
                  child: Text(
                    'Tagged people',
                  ),
                ),
              Wrap(
                spacing: 10,
                children: [
                  for (int i = 0; i < tags.length; i++)
                    InputChip(
                      label: Text('${tags[i]}'),
                      labelPadding: EdgeInsets.symmetric(horizontal: 4),
                      onDeleted: () {
                        tags.removeAt(i);
                        setState(() {});
                      },
                      deleteIconColor: Colors.grey,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: RaisedButton(
        onPressed: () {},
        child: isLoad ? myProgressIndicator() : Text('Post'),
        shape: ContinuousRectangleBorder(),
      ),
    );
  }
}

class FilterPage extends StatefulWidget {
  final int index;
  const FilterPage(this.index);
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final GlobalKey _globalKey = GlobalKey();

  void convertWidgetToImage() async {
    // reduces quality of large images
    RenderRepaintBoundary repaintBoundary =
        _globalKey.currentContext.findRenderObject();
    ui.Image boxImage = await repaintBoundary.toImage(pixelRatio: 1);
    ByteData byteData =
        await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Directory tempdic = await getTemporaryDirectory();
    images.removeAt(widget.index);
    images.insert(
      widget.index,
      await File(tempdic.path +
              '/tasveer${widget.index}0${Random().nextInt(100)}.tmp')
          .writeAsBytes(
        byteData.buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
      ),
    );
    Navigator.pop(context, widget.index);
  }

  String filtersName(int index) {
    switch (index) {
      case 1:
        return 'Sepia';
        break;
      case 2:
        return 'Greyscale';
        break;
      case 3:
        return 'Vintage';
        break;
      case 4:
        return 'Sweet';
        break;
      default:
        return 'No filter';
    }
  }

  int idx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit picture',
          style:
              Theme.of(context).textTheme.headline5.copyWith(letterSpacing: 1),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: BeforeAfter(
              thumbColor: Theme.of(context).scaffoldBackgroundColor,
              thumbRadius: 0,
              overlayColor: Colors.transparent,
              beforeImage: RepaintBoundary(
                key: _globalKey,
                child: ColorFiltered(
                  colorFilter: ColorFilter.matrix(filters[idx]),
                  child: Image.file(images[widget.index]),
                ),
              ),
              afterImage: Image.file(images[widget.index]),
            ),
          ),
          Container(
            height: 130,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    idx = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        padding: const EdgeInsets.all(1.6),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: idx == index
                              ? Border.all(
                                  width: 3,
                                  color: Color(0xff1477f8),
                                )
                              : null,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          clipBehavior: Clip.hardEdge,
                          child: RepaintBoundary(
                            child: ColorFiltered(
                              colorFilter: ColorFilter.matrix(filters[index]),
                              child: Image.file(images[widget.index]),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        filtersName(index),
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: idx == index
                                  ? Color(0xff1477f8)
                                  : Colors.grey,
                              fontWeight: idx == index
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              fontSize: idx == index ? 15 : 14,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: RaisedButton(
        onPressed:
            idx == 0 ? () => Navigator.pop(context) : convertWidgetToImage,
        child: Text('Done'),
        shape: ContinuousRectangleBorder(),
      ),
    );
  }
}

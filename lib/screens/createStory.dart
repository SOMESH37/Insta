// https://github.com/papmodern/storyMaker with little modifications
import 'dart:io';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../helper.dart';

class StoryEditor extends StatefulWidget {
  final int type;
  StoryEditor(this.type);
  @override
  _StoryEditorState createState() => _StoryEditorState();
}

File storyImg;

class _StoryEditorState extends State<StoryEditor> {
  EditableItem _activeItem;
  Offset _initPos, _currentPos;
  double _currentScale, _currentRotation;
  bool isLoad = false;
  Color textC = Colors.white, backC = Colors.black12;
  String text = '';
  var textController = TextEditingController();
  void getImg(int type) async {
    var croppedimg;
    var img = await ImagePicker()
        .getImage(source: type == 7 ? ImageSource.camera : ImageSource.gallery);
    if (img != null)
      croppedimg = await ImageCropper.cropImage(
        sourcePath: img.path,
        androidUiSettings: AndroidUiSettings(
          activeControlsWidgetColor: Color(0xff1477f8),
          toolbarColor: Colors.white,
          toolbarWidgetColor: Color(0xff1477f8),
        ),
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: getSize(File(img.path).lengthSync()),
      );
    if (croppedimg != null) {
      storyImg = croppedimg;
      mockData.add(EditableItem()
        ..type = ItemType.Image
        ..value = storyImg
        ..position = Offset(0.3, 0.3));
      setState(() {});
    }
    if (img == null || croppedimg == null) Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    storyImg = null;
    mockData.clear();
    getImg(widget.type);
  }

  @override
  void dispose() {
    storyImg = null;
    mockData.clear();
    super.dispose();
  }

  changeColor({bool isTextField = false}) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding: EdgeInsets.only(top: 20),
        title: const Text('Choose a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: backC,
            onColorChanged: (c) => setState(() {
              if (isTextField)
                textC = c;
              else if (_activeItem != null && _activeItem.type == ItemType.Text)
                _activeItem.color = c;
              else
                backC = c;
            }),
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
            enableAlpha: true,
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.pop(context);
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoad,
      child: Scaffold(
        body: GestureDetector(
          onScaleStart: (details) {
            if (_activeItem == null) return;
            _initPos = details.focalPoint;
            _currentPos = _activeItem.position;
            _currentScale = _activeItem.scale;
            _currentRotation = _activeItem.rotation;
          },
          onScaleUpdate: (details) {
            if (_activeItem == null) return;
            final delta = details.focalPoint - _initPos;
            final left = (delta.dx / screenW) + _currentPos.dx;
            final top = (delta.dy / screenH) + _currentPos.dy;
            _activeItem.position = Offset(left, top);
            _activeItem.rotation = details.rotation + _currentRotation;
            if ((_activeItem.scale > 2 && details.scale < 1) ||
                (_activeItem.scale < 0.1 && details.scale > 1) ||
                (_activeItem.scale <= 2 && _activeItem.scale >= 0.1))
              _activeItem.scale = details.scale * _currentScale;
            setState(() {});
          },
          onTap: () {
            _activeItem = null;
            setState(() {});
          },
          child: Container(
            color: backC,
            child: SafeArea(
              child: Stack(
                children: [
                  if (storyImg != null)
                    ...mockData.map(_buildItemWidget).toList(),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 16, 10),
                                child: circularImg(
                                    'https://picsum.photos/id/525/150', 42),
                              ),
                              Text('${allAccounts[0][2]}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.headline5),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            splashRadius: 1,
                            tooltip: 'Close',
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor,
                            icon: Icon(Icons.close_rounded),
                            iconSize: 30,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => changeColor(isTextField: true),
                                  child: Container(
                                    width: 36,
                                    decoration: BoxDecoration(
                                      color: textC,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Color',
                                        style: TextStyle(color: backC),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: screenW - 148,
                                  child: TextField(
                                    controller: textController,
                                    maxLines: null,
                                    autofocus: false,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(color: textC, fontSize: 16),
                                    onChanged: (value) {
                                      text = value.trim();
                                    },
                                    decoration: InputDecoration(
                                      fillColor: Colors.transparent,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      hintText: 'Add text',
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(color: textC),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    if (text == null || text.isEmpty) return;
                                    mockData.add(_activeItem = EditableItem()
                                      ..type = ItemType.Text
                                      ..value = text
                                      ..scale = 2
                                      ..position = Offset(0.3, 0.3)
                                      ..color = textC);
                                    textController.clear();
                                    text = '';
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(100)),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          'Add',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: backC,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () => changeColor(),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        gradient: SweepGradient(
                                          colors: [
                                            Colors.indigo,
                                            Colors.blue,
                                            Colors.lightGreenAccent,
                                            Colors.green,
                                            Colors.yellow,
                                            Colors.orange,
                                            Colors.red,
                                          ],
                                        ),
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        (_activeItem == null ||
                                                _activeItem.type ==
                                                    ItemType.Image)
                                            ? 'Backgroung color'
                                            : 'Text color',
                                        style: TextStyle(
                                            color: _activeItem != null &&
                                                    _activeItem.type ==
                                                        ItemType.Text
                                                ? _activeItem.color
                                                : Colors.white,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: () {},
                                child: Container(
                                  width: 110,
                                  height: 38,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: isLoad
                                        ? Container(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Colors.black),
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : Text(
                                            'Preview',
                                            style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemWidget(EditableItem e) {
    var widget;
    switch (e.type) {
      case ItemType.Text:
        widget = Text(
          e.value,
          style: TextStyle(color: e.color),
        );
        break;
      case ItemType.Image:
        widget = Image.file(e.value);
    }

    return Positioned(
      top: e.position.dy * screenH,
      left: e.position.dx * screenW,
      child: Transform.scale(
        scale: e.scale,
        child: Transform.rotate(
          angle: e.rotation,
          child: GestureDetector(
            onTap: () {
              _activeItem = e;
              setState(() {});
            },
            child: Listener(
              onPointerDown: (details) {
                if (_activeItem == null) _activeItem = e;
                _initPos = details.position;
                _currentPos = e.position;
                _currentScale = e.scale;
                _currentRotation = e.rotation;
              },
              child: widget,
            ),
          ),
        ),
      ),
    );
  }
}

enum ItemType { Image, Text }

class EditableItem {
  Offset position = Offset(0, 0);
  double scale = 0.8;
  double rotation = 0.0;
  ItemType type;
  Color color;
  var value;
}

List<EditableItem> mockData = [];

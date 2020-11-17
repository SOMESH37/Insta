// https://github.com/papmodern/storyMaker with little modifications
import '../helper.dart';

class StoryEditor extends StatefulWidget {
  @override
  _StoryEditorState createState() => _StoryEditorState();
}

class _StoryEditorState extends State<StoryEditor> {
  EditableItem _activeItem;
  Offset _initPos, _currentPos;
  double _currentScale, _currentRotation;
  bool _inAction = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              (_activeItem.scale < 0.2 && details.scale > 1) ||
              (_activeItem.scale <= 2 && _activeItem.scale >= 0.2))
            _activeItem.scale = details.scale * _currentScale;
          setState(() {});
        },
        child: Stack(
          children: [
            Container(color: Colors.black26),
            ...mockData.map(_buildItemWidget).toList()
          ],
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
          style: TextStyle(color: Colors.white),
        );
        break;
      case ItemType.Image:
        widget = Image.network(e.value);
    }

    return Positioned(
      top: e.position.dy * screenH,
      left: e.position.dx * screenW,
      child: Transform.scale(
        scale: e.scale,
        child: Transform.rotate(
          angle: e.rotation,
          child: Listener(
            onPointerDown: (details) {
              if (_inAction) return;
              _inAction = true;
              _activeItem = e;
              _initPos = details.position;
              _currentPos = e.position;
              _currentScale = e.scale;
              _currentRotation = e.rotation;
            },
            onPointerUp: (details) {
              _inAction = false;
            },
            child: widget,
          ),
        ),
      ),
    );
  }
}

enum ItemType { Image, Text }

class EditableItem {
  Offset position = Offset(0.1, 0.1);
  double scale = 1.0;
  double rotation = 0.0;
  ItemType type;
  String value;
}

final mockData = [
  EditableItem()
    ..type = ItemType.Image
    ..value =
        'https://cdn.pixabay.com/photo/2016/02/19/11/46/night-1209938_960_720.jpg',
  EditableItem()
    ..type = ItemType.Text
    ..value = 'Hello',
  EditableItem()
    ..type = ItemType.Text
    ..value = 'World',
];

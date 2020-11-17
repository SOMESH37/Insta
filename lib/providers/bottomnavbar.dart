import '../helper.dart';

class BottomNavBar with ChangeNotifier {
  int _cIndex = 0;
  get getCurrentIndex => _cIndex;
  set setCurrentIndex(int index) {
    _cIndex = index;
    notifyListeners();
  }
}

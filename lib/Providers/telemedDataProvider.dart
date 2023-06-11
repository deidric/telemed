import 'package:flutter/foundation.dart';

class TelemedDataProvider with ChangeNotifier, DiagnosticableTreeMixin{
  bool _isDark = false;

  bool get isDark => _isDark;

  void setDarkMode(isDark) {
    _isDark = isDark;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(isLoading) {
    this._isLoading = isLoading;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/task.dart';

class AppProvider extends ChangeNotifier {
  int _points = 1250;
  int _selectedIndex = 0;
  bool _isDark = false;
  bool _busy = false;

  final List<AppTask> _tasks = const [
    AppTask(
      id: '1',
      title: 'تسجيل الدخول اليومي',
      subtitle: 'افتح التطبيق يومياً',
      points: 25,
      icon: Icons.login,
    ),
    AppTask(
      id: '2',
      title: 'تحديث الملف الشخصي',
      subtitle: 'أكمل بيانات حسابك',
      points: 50,
      icon: Icons.person_outline,
    ),
    AppTask(
      id: '3',
      title: 'استكشاف العروض',
      subtitle: 'شاهد أحدث العروض المتاحة',
      points: 75,
      icon: Icons.local_offer_outlined,
    ),
    AppTask(
      id: '4',
      title: 'مشاركة التطبيق',
      subtitle: 'شارك التطبيق مع أصدقائك',
      points: 100,
      icon: Icons.share_outlined,
    ),
  ];

  final Set<String> _completed = {'1'};

  int get points => _points;
  int get selectedIndex => _selectedIndex;
  bool get isDark => _isDark;
  bool get busy => _busy;

  List<AppTask> get tasks {
    return _tasks.map((task) {
      return task.copyWith(
        state: _completed.contains(task.id)
            ? TaskState.completed
            : task.state,
      );
    }).toList();
  }

  void selectTab(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  Future<void> completeTask(AppTask task) async {
    if (_completed.contains(task.id) || _busy) return;

    _busy = true;
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 650));

    _completed.add(task.id);
    _points += task.points;
    _busy = false;
    notifyListeners();
  }

  bool redeem(int cost) {
    if (_points < cost) return false;

    _points -= cost;
    notifyListeners();
    return true;
  }
}

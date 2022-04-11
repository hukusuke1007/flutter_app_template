enum BottomNavigationTab {
  tab1,
  tab2,
}

extension BottomNavigationTabExt on BottomNavigationTab {
  String get id {
    switch (this) {
      case BottomNavigationTab.tab1:
        return 'tab1';
      case BottomNavigationTab.tab2:
        return 'tab2';
    }
  }

  String get title {
    switch (this) {
      case BottomNavigationTab.tab1:
        return 'タブ1';
      case BottomNavigationTab.tab2:
        return 'タブ2';
    }
  }

  int get order {
    switch (this) {
      case BottomNavigationTab.tab1:
        return 0;
      case BottomNavigationTab.tab2:
        return 1;
    }
  }

  static BottomNavigationTab fromId(String id) {
    return BottomNavigationTab.values.firstWhere((e) => e.id == id);
  }

  static BottomNavigationTab fromIndex(int index) {
    return BottomNavigationTab.values.firstWhere((e) => e.order == index);
  }
}

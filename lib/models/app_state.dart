class AppState {
  SelectedTheme selectedTheme;

  AppState({this.selectedTheme});

  AppState.fromAppState(AppState another) {
    selectedTheme = another.selectedTheme;
  }
}

enum SelectedTheme { DARK, LIGHT }
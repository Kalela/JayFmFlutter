class AppState {
  SelectedTheme selectedTheme;
  PodcastQuality podcastQuality;

  AppState({this.selectedTheme});

  AppState.fromAppState(AppState another) {
    selectedTheme = another.selectedTheme;
    podcastQuality = another.podcastQuality;
  }
}

enum SelectedTheme { DARK, LIGHT }

enum PodcastQuality { LOW, MED, HIGH }
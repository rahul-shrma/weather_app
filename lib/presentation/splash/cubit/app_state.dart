class AppState {
  int theme = 0;
  bool moveToHome = false;

  AppState copy(AppState state) {
    AppState data = AppState();
    data.moveToHome = state.moveToHome;
    data.theme = state.theme;
    return data;
  }
}

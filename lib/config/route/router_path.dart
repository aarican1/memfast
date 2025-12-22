enum RouterPath {
  splash("/"),
  home("/home"),
  game("/game"),
  settings("/settings"),
  bestScores("/bestScores"),
  levelComplete("/levelComplete"),
  selectLevel("/selectLevel"),
  signUp("/signUp"),
  howToPlay("/howToPlay"),
  gameOver("/gameOver");

  final String path;

  const RouterPath(this.path);
}

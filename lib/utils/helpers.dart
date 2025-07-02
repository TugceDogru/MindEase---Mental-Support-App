int getMoodScore(String moodEmoji) {
  switch (moodEmoji) {
    case '😊':
      return 4;
    case '😐':
      return 3;
    case '😢':
      return 2;
    case '😡':
      return 1;
    case '😴':
      return 2;
    default:
      return 0;
  }
}

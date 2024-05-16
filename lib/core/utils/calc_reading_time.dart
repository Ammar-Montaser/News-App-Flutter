int calcReadingTime(String content) {
  final wordCount = content.split(RegExp(r"\s+")).length;
  //speed =distance/time
  final readingTime = 200 / wordCount;
  return readingTime.ceil();
}

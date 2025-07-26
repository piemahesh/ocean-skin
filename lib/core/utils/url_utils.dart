final urlRegExp = RegExp(r'(https?://[^\s]+)');
List<String> extractUrls(String text) =>
    urlRegExp.allMatches(text).map((m) => m.group(0)!).toList();

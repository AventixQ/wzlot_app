class StringEvents {
  // Sprawdza, czy w stringu znajduje się już podany ciąg znaków
  static bool? contains(String? string, String substring) {
    return string?.split(';').contains(substring);
  }

  // Dodaje do stringa kolejne elementy
  static String? add(String? string, String newElement) {
    if (string == '0') {
      return newElement;
    } else {
      return '${string!};$newElement';
    }
  }

  // Usuwa ze stringa konkretny element
  static String? remove(String? string, String elementToRemove) {
    if (string == '0') {
      return '0';
    } else {
      List<String> elements = string!.split(';');
      elements.remove(elementToRemove);
      return elements.join(';');
    }
  }

  // Usuwa ze stringa znaki specjalne
  static String? removeSpecialCharacters(String? string) {
    return string?.replaceAll(RegExp(r'[^\w\s]+'), '');
  }
}

class Validator {
  static String? isRequired(String? text) {
    if(text == null || text.isEmpty) {
      return 'Text required to register!';
    }

    return null;
  }
}
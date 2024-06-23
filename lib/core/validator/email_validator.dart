class EmailValidation {
  bool validateEmail(String value) {
    final emailRegEx = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    bool matched = emailRegEx.hasMatch(value);
    return matched;
  }
}

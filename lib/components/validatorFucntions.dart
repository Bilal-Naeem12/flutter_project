TextValidator(value) {
  if (value == null || value.isEmpty) {
    return 'Some text required';
  } else if (value.toString().length < 3) {
    return 'More than 3 characters required';
  }
  return null;
}

String? EmailValidator(String value) {
  if (value.isEmpty) {
    return 'Email is required';
  } else if (!isEmailValid(value)) {
    return 'Enter a valid email address';
  } else {
    return null;
  }
}

bool isEmailValid(String email) {
  // Basic email validation using regex
  // You can implement more complex validation if needed
  return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
}

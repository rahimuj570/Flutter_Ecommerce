extension StringCapitalize on String {
  String toCapitalizeFirstWord() {
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

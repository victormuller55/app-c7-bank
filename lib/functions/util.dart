String getCumprimento() {

  int hourNow = DateTime.now().hour;

  if (hourNow >= 6 && hourNow < 12) {
    return "Bom dia ";
  }

  if (hourNow >= 12 && hourNow < 18) {
    return "Boa tarde ";
  }

  return "Boa noite ";
}

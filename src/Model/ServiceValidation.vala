namespace ServicesIndicator.Model.ServiceValidation {
  private GLib.Regex valid_id_regex;

  public bool call(Service service) {
    if(service.id == "" || service.name == "") {
      return false;
    }

    if(!get_id_regex().match(service.id)) {
      return false;
    }

    return true;
  }

  private GLib.Regex? get_id_regex() {
    try {
      if(valid_id_regex == null) {
        valid_id_regex = new GLib.Regex("^\\w+$");
      }

      return valid_id_regex;
    } catch(GLib.RegexError e) {
      stderr.printf("%s\n", e.message);

      return null;
    }
  }
}

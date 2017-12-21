namespace ServicesIndicator.Infra.Settings {
  private GLib.Settings? settings;

  private GLib.Settings get_settings() {
    if(settings == null) {
      settings = new GLib.Settings(Common.Constants.SETTINGS_ID);
    }

    return settings;
  }

  public bool set_value(string key, GLib.Variant val) {
    return get_settings().set_value(key, val);
  }

  public GLib.Variant get_value(string key) {
    return get_settings().get_value(key);
  }
}

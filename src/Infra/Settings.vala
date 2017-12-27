namespace ServicesIndicator.Infra.Settings {
  public delegate void ConnectCallback();
  private GLib.Settings? settings;

  public bool set_value(string key, GLib.Variant val) {
    return get_settings().set_value(key, val);
  }

  public GLib.Variant get_value(string key) {
    return get_settings().get_value(key);
  }

  public void connect(Settings.ConnectCallback callback) {
    get_settings().changed.connect(() => {
      callback();
    });
  }

  private GLib.Settings get_settings() {
    if(settings == null) {
      settings = new GLib.Settings(Common.Constants.SETTINGS_ID);
    }

    return settings;
  }
}

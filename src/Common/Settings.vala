public class ServicesIndicator.Common.Settings {
  private static GLib.Settings? settings;

  public static GLib.Settings get_instance() {
    if(settings == null) {
      settings = new GLib.Settings(Common.Constants.SETTINGS_ID);
    }

    return settings;
  }
}

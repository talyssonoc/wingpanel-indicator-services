public class Services.Settings {
  private static GLib.Settings? settings;

  public static GLib.Settings get_instance() {
    if(settings == null) {
      settings = new GLib.Settings(Constants.EXEC_NAME);
    }

    return settings;
  }
}

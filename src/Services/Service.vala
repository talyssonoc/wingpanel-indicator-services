public class ServicesManager.Services.Service : GLib.Object {
  public signal void change(bool state);
  private string service_id;

  public Service(string service_id) {
    this.service_id = service_id;
  }

  public bool is_active() {
    string standard_output, standard_error;
    int exit_status;

    Process.spawn_command_line_sync (
      service_command("status"),
      out standard_output,
      out standard_error,
      out exit_status
    );

    return exit_status == 0;
  }

  public void toggle() {
    var command = is_active() ? "stop" : "start";

    try {
      Process.spawn_command_line_sync (service_command(command));
    } catch (SpawnError e) {
      stderr.printf("%s\n", e.message);
    }

    change(is_active());
  }

  private string service_command(string command) {
    return @"service $(service_id) $(command)";
  }
}

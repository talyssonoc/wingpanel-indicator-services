public class ServicesIndicator.Model.Service : Object {
  public signal void change(bool state);
  private string id;
  public string name;

  public Service(string id, string name) {
    this.id = id;
    this.name = name;
  }

  public bool is_active() {
    string standard_output, standard_error;
    int exit_status;

    try {
      Process.spawn_command_line_sync (
        service_command("status"),
        out standard_output,
        out standard_error,
        out exit_status
      );


      return exit_status == 0;
    } catch (SpawnError e) {
      stderr.printf("%s\n", e.message);

      return false;
    }
  }

  public void toggle() {
    var command = is_active() ? "stop" : "start";

    try {
      string[] spawn_args = {"service", id, command};
      string[] spawn_env = Environ.get ();
      Pid child_pid;

      Process.spawn_async (
        null,
        spawn_args,
        spawn_env,
        SpawnFlags.SEARCH_PATH | SpawnFlags.DO_NOT_REAP_CHILD,
        null,
        out child_pid
      );

      ChildWatch.add (child_pid, (pid, status) => {
        Process.close_pid (pid);
        change(is_active());
      });

    } catch (SpawnError e) {
      stderr.printf("%s\n", e.message);
    }

  }

  private string service_command(string command) {
    return @"service $(id) $(command)";
  }
}

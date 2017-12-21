namespace ServicesIndicator.Infra.ServiceRepository {
  public delegate void ToggleCallback(bool is_active);
  public delegate void ConnectCallback(Model.Service[] services);
  private Signals signals;

  private class Signals {
    public signal void changed(Model.Service[] service_models);
  }

  private Signals get_signals() {
    if(signals == null) {
      signals = new Signals();
    }

    return signals;
  }

  public void connect(ConnectCallback callback) {
    get_signals().changed.connect((services) => {
      callback(services);
    });
  }

  public Model.Service[] load_all() {
    var raw_services = Common.Settings.get_value("services");

    return ServiceMapper.from_variant_collection(raw_services);
  }

  public bool save_all(Model.Service[] services) {
    try {
      var settings_services = ServiceMapper.from_model_collection(services);

      var successful = Common.Settings.set_value("services", settings_services);

      if(successful) {
        get_signals().changed(load_all());
      }

      return successful;
    } catch(GLib.VariantParseError e) {
      stderr.printf("%s\n", e.message);

      return false;
    }
  }

  public bool is_active(string service_id) {
    try {
      int exit_status;

      Process.spawn_command_line_sync (
        @"service $(service_id) status",
        null,
        null,
        out exit_status
      );


      return exit_status == 0;
    } catch (SpawnError e) {
      stderr.printf("%s\n", e.message);

      return false;
    }
  }

  public void toggle(string service_id, ToggleCallback callback) {
    var command = is_active(service_id) ? "stop" : "start";

    try {
      string[] spawn_args = {"service", service_id, command};
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
        callback(is_active(service_id));
      });

    } catch (SpawnError e) {
      stderr.printf("%s\n", e.message);
    }
  }
}

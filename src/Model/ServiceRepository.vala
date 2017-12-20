namespace ServicesIndicator.Model.ServiceRepository {
  public delegate void ToggleCallback(bool is_active);

  public Service[] load_all() {
    var raw_services = settings().get_value("services");
    var services = new Service[raw_services.n_children()];

    for (int i = 0; i < raw_services.n_children(); i++) {
      var raw_service = raw_services.get_child_value(i);
      var service_id = raw_service.lookup_value("id", GLib.VariantType.STRING).get_string();
      var service_name = raw_service.lookup_value("name", GLib.VariantType.STRING).get_string();

      services[i] = new Service(service_id, service_name);
    }

    return services;
  }

  public bool save_all(Service[] services) {
    var settings_services = GLib.Variant.parse(null, serialize_services_list(services));

    return settings().set_value("services", settings_services);
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

  public void toggle(string service_id, ToggleCallback change) {
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
        change(is_active(service_id));
      });

    } catch (SpawnError e) {
      stderr.printf("%s\n", e.message);
    }
  }

  private GLib.Settings settings() {
    return Common.Settings.get_instance();
  }

  private string serialize_services_list(Service[] services) {
    string[] serialized_services = new string[services.length];

    for (int i = 0; i < services.length; i++) {
      serialized_services[i] = serialize_service(services[i]);
    }

    return @"[$(string.joinv(", ", serialized_services))]";
  }

  private string serialize_service(Service service) {
    var id = service.id;
    var name = service.name;

    return @"{\"id\": \"$(id)\", \"name\": \"$(name)\"}";
  }
}

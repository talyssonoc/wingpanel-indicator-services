namespace ServicesIndicator.Model.ServiceRepository {
  public Service[] load_all() {
    var settings = Common.Settings.get_instance();

    var raw_services = settings.get_value("services");
    var services = new Service[raw_services.n_children()];

    for (int i = 0; i < raw_services.n_children(); i++) {
      var raw_service = raw_services.get_child_value(i);
      var service_id = raw_service.lookup_value("id", GLib.VariantType.STRING).get_string();
      var service_name = raw_service.lookup_value("name", GLib.VariantType.STRING).get_string();

      services[i] = new Service(service_id, service_name);
    }

    return services;
  }
}

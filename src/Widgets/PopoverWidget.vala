public class Services.PopoverWidget : Gtk.Grid {
  private ServiceWidget[] services;

  public PopoverWidget() {
    services = create_services(ServiceRepository.load_all());

    for (int i = 0; i < services.length; i++) {
      attach (services[i], 0, i, 1, 1);
    }
  }

  public void update_services_state () {
    foreach (ServiceWidget service in services) {
      service.update();
    }
  }

  private ServiceWidget[] create_services(Service[] service_models) {
    ServiceWidget[] services = new ServiceWidget[service_models.length];

    for (int i = 0; i < service_models.length; i++) {
      services[i] = new ServiceWidget(service_models[i]);
    }

    return services;
  }
}

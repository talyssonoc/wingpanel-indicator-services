public class Services.PopoverWidget : Gtk.Grid {
  private Gtk.ListBox services_container;
  private ServiceWidget[] services;

  public PopoverWidget() {
    services_container = new Gtk.ListBox();
    services = create_service_widgets(ServiceRepository.load_all());

    for (int i = 0; i < services.length; i++) {
      services_container.prepend (services[i]);
    }

    attach(services_container, 0, 0, 1, 1);
  }

  public void update () {
    foreach (ServiceWidget service in services) {
      service.update();
    }
  }

  private ServiceWidget[] create_service_widgets(Service[] service_models) {
    var services = new ServiceWidget[service_models.length];

    for (int i = 0; i < service_models.length; i++) {
      services[i] = new ServiceWidget(service_models[i]);
    }

    return services;
  }
}

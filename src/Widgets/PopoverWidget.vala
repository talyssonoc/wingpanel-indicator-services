using ServicesManager;

public class ServicesManager.Widgets.PopoverWidget : Gtk.Grid {
  private Widgets.ServiceWidget[] services;

  public PopoverWidget() {
    services = create_services(Services.ServicesLoader.get_services_descriptors());

    for (int i = 0; i < services.length; i++) {
      attach (services[i], 0, i, 1, 1);
    }
  }

  public void update_services_state () {
    foreach (Widgets.ServiceWidget service in services) {
      service.update();
    }
  }

  private Widgets.ServiceWidget[] create_services(Services.ServiceDescriptor[] descriptors) {
    Widgets.ServiceWidget[] services = new Widgets.ServiceWidget[descriptors.length];

    for (int i = 0; i < descriptors.length; i++) {
      services[i] = new Widgets.ServiceWidget(
        descriptors[i].name,
        new Services.Service(descriptors[i].id)
      );
    }

    return services;
  }
}

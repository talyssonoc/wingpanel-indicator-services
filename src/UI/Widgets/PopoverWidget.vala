public class ServicesIndicator.UI.Widgets.PopoverWidget : Gtk.Grid {
  private Gtk.ListBox services_container;
  private UI.Service.ServiceView[] services;

  public PopoverWidget() {
    services_container = new Gtk.ListBox();
    services = create_service_widgets(Model.ServiceRepository.load_all());

    for (int i = 0; i < services.length; i++) {
      services_container.prepend (services[i]);
    }

    attach(services_container, 0, 0, 1, 1);
  }

  public void update () {
    foreach (UI.Service.ServiceView service in services) {
      service.update();
    }
  }

  private UI.Service.ServiceView[] create_service_widgets(Model.Service[] service_models) {
    var services = new UI.Service.ServiceView[service_models.length];

    for (int i = 0; i < service_models.length; i++) {
      services[i] = new UI.Service.ServiceView(service_models[i]);
    }

    return services;
  }
}

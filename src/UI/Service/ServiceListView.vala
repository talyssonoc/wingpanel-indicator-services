public class ServicesIndicator.UI.Service.ServiceListView : Gtk.ListBox {
  private UI.Service.ServiceView[] service_views;

  public ServiceListView() {
    service_views = create_service_views(Model.ServiceRepository.get_instance().load_all());

    render_children();
  }

  public void refresh() {
    foreach (var service_view in service_views) {
      service_view.refresh();
    }
  }

  private void render_children() {
    foreach (var service_view in service_views) {
      prepend(service_view);
    }
  }

  private UI.Service.ServiceView[] create_service_views(Model.Service[] service_models) {
    var service_views = new UI.Service.ServiceView[service_models.length];

    for (int i = 0; i < service_models.length; i++) {
      service_views[i] = new UI.Service.ServiceView(service_models[i]);
    }

    return service_views;
  }
}

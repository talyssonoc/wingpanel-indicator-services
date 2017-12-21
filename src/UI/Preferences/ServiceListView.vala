class ServicesIndicator.UI.Preferences.ServiceListView : Gtk.Box {
  public Gee.List<Model.Service> services;

  public ServiceListView() {
    set_orientation(Gtk.Orientation.VERTICAL);
    set_spacing(2);

    services = new Gee.ArrayList<Model.Service>.wrap(
      Model.ServiceRepository.get_instance().load_all()
    );

    render_children();
  }

  public void add_service() {
    var new_service = new Model.Service.blank();
    services.add(new_service);

    append_service(new_service);
  }

  private void render_children() {
    services.@foreach((service) => {
      append_service(service);
      return true; // just because we need to return something
    });
  }

  private void append_service(Model.Service service) {
    var row = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 2);

    var service_view = new ServiceView(service);
    var delete_button = new Gtk.Button.from_icon_name("window-close-symbolic");

    delete_button.clicked.connect(() => {
      services.remove(service);
      remove(row);
    });

    row.add(service_view);
    row.add(delete_button);

    add(row);

    row.show_all();
  }
}

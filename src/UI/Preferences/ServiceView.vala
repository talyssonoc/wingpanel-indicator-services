class ServicesIndicator.UI.Preferences.ServiceView : Gtk.Box {
  private Model.Service service;
  private Gtk.Entry name_input;
  private Gtk.Entry id_input;

  public ServiceView(Model.Service service) {
    set_orientation(Gtk.Orientation.HORIZONTAL);
    set_spacing(5);

    this.service = service;

    name_input = new Gtk.Entry();
    id_input = new Gtk.Entry();

    render_children();
    add_listeners();
  }

  private void render_children() {
    name_input.set_text(service.name);

    id_input.set_text(service.id);

    add(name_input);
    add(id_input);
  }

  private void add_listeners() {
    name_input.changed.connect(() => {
      service.name = name_input.get_text();
    });

    id_input.changed.connect(() => {
      service.id = id_input.get_text();
    });
  }
}

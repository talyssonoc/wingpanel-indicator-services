public class ServicesIndicator.UI.Widgets.PopoverWidget : Gtk.ListBox {
  private UI.Service.ServiceListView service_list_view;
  private Wingpanel.Widgets.Button show_preferences_button;

  public PopoverWidget() {
    var services = Infra.ServiceRepository.load_all();
    service_list_view = new UI.Service.ServiceListView(services);
    show_preferences_button = new Wingpanel.Widgets.Button("Preferences");

    render_children();
    add_listeners();
  }

  public void refresh () {
    service_list_view.refresh();
  }

  private void render_children() {
    add(service_list_view);
    add(show_preferences_button);
  }

  private void add_listeners() {
    show_preferences_button.clicked.connect(show_preferences);
    Infra.ServiceRepository.connect(handle_services_change);
  }

  private void handle_services_change(Model.Service[] services) {
    service_list_view.get_parent().destroy();
    service_list_view = new UI.Service.ServiceListView(services);
    prepend(service_list_view);
    service_list_view.show_all();
  }

  private void show_preferences() {
    var preferences_view = new UI.Preferences.PreferencesView();

    preferences_view.show_all();
  }
}

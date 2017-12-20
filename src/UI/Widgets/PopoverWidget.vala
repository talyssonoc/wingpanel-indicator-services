public class ServicesIndicator.UI.Widgets.PopoverWidget : Gtk.ListBox {
  private UI.Service.ServiceListView service_list_view;
  private Wingpanel.Widgets.Button show_preferences_button;

  public PopoverWidget() {
    service_list_view = new UI.Service.ServiceListView();
    show_preferences_button = new Wingpanel.Widgets.Button("Preferences");

    show_preferences_button.clicked.connect(show_preferences);

    add(service_list_view);
    add(show_preferences_button);
  }

  public void update () {
    service_list_view.update();
  }

  private void show_preferences() {
    var preferences_view = new UI.Preferences.PreferencesView();

    preferences_view.show_all();
  }
}

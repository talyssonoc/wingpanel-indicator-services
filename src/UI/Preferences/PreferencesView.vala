public class ServicesIndicator.UI.Preferences.PreferencesView : Gtk.Dialog {
  private ServiceListView service_list;
  private Gtk.Button add_service_button;
  private Gtk.Button save_button;

  public PreferencesView() {
    title = "Services indicator preferences";
    set_modal(true);
    (get_action_area() as Gtk.ButtonBox).set_layout(Gtk.ButtonBoxStyle.EDGE);

    service_list = new ServiceListView();
    add_service_button = new Gtk.Button.with_label("Add");
    save_button = new Gtk.Button.with_label("Save");

    render_children();
    add_listeners();
  }

  private void render_children() {
    get_content_area().add(service_list);
    add_action_widget(add_service_button, 123);
    add_action_widget(save_button, 321);
  }

  private void add_listeners() {
    add_service_button.clicked.connect(service_list.add_service);
    save_button.clicked.connect(handle_click_save);
  }

  private void handle_click_save() {
    var success = Model.ServiceRepository.save_all(service_list.services.to_array());

    if(success) {
      close();
    } else {
      Gtk.MessageDialog msg = new Gtk.MessageDialog (
        this,
        Gtk.DialogFlags.MODAL,
        Gtk.MessageType.ERROR,
        Gtk.ButtonsType.OK,
        "Error while saving preferences."
      );

      msg.show();
    }

  }
}

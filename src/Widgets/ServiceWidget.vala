public class ServicesManager.Widgets.ServiceWidget : Gtk.Grid {
  private string service_name;
  private ServicesManager.Services.Service model;
  private Wingpanel.Widgets.Switch state_switch;

  public ServiceWidget(string service_name, ServicesManager.Services.Service model) {
    this.service_name = service_name;
    this.model = model;
    state_switch = create_switch();

    attach(state_switch, 0, 0, 1, 1);
  }

  public void update() {
    update_switch(model.is_active());
  }

  private void update_switch(bool is_active) {
    state_switch.set_active(is_active);
  }

  private Wingpanel.Widgets.Switch create_switch() {
    var state_switch = new Wingpanel.Widgets.Switch (service_name, model.is_active());

    model.change.connect(update_switch);
    state_switch.clicked.connect(model.toggle);

    return state_switch;
  }
}

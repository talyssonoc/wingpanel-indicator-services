public class ServicesIndicator.UI.Service.ServiceView : Gtk.Grid {
  private Wingpanel.Widgets.Switch state_switch;
  private Model.Service model;

  public ServiceView(Model.Service model) {
    this.model = model;
    state_switch = create_switch();

    attach(state_switch, 0, 0, 1, 1);
  }

  public void refresh() {
    update_switch(model.is_active);
  }

  private void update_switch(bool is_active) {
    state_switch.set_active(is_active);
  }

  private Wingpanel.Widgets.Switch create_switch() {
    var state_switch = new Wingpanel.Widgets.Switch (model.name, model.is_active);

    model.state_changed.connect(update_switch);
    state_switch.clicked.connect(model.toggle);

    return state_switch;
  }
}

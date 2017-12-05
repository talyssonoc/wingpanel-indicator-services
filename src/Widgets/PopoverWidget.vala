public class ServicesManager.Widgets.PopoverWidget : Gtk.Grid {
  private Wingpanel.Widgets.Button hide_button;
  private Wingpanel.Widgets.Switch compositing_switch;
  private ServicesManager.Widgets.ServiceWidget[] services_list;

  public PopoverWidget() {
    hide_button = new Wingpanel.Widgets.Button ("Hide me!");
    compositing_switch = new Wingpanel.Widgets.Switch ("Composited Icon");
    services_list = {
      new ServicesManager.Widgets.ServiceWidget(
        "PostgreSQL",
        new ServicesManager.Services.Service("postgresql")
      )
    };

    for (int index = 0; index < services_list.length; index++) {
      attach (services_list[index], 0, index, 1, 1);
    }

  }

  public void update_services_state () {
    foreach (ServicesManager.Widgets.ServiceWidget service in services_list) {
      service.update();
    }
  }
}

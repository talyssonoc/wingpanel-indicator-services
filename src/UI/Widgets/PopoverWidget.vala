public class ServicesIndicator.UI.Widgets.PopoverWidget : Gtk.Grid {
  private UI.Service.ServiceListView service_list_view;

  public PopoverWidget() {
    service_list_view = new UI.Service.ServiceListView();

    attach(service_list_view, 0, 0, 1, 1);
  }

  public void update () {
    service_list_view.update();
  }
}

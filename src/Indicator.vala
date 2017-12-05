public class ServicesManager.Indicator : Wingpanel.Indicator {
  /* Our display widget, a composited icon */
  private ServicesManager.Widgets.OverlayWidget? display_widget = null;

  /* The main widget that is displayed in the popover */
  private ServicesManager.Widgets.PopoverWidget? main_widget = null;

  public Indicator () {
    Object (code_name : "services-indicator",
      display_name : "Services indicator",
      description: "The services manager indicator");

    this.visible = true;
  }

  /* This method is called to get the widget that is displayed in the top bar */
  public override Gtk.Widget get_display_widget () {
    if (display_widget == null) {
      display_widget = new ServicesManager.Widgets.OverlayWidget ();
    }

    return display_widget;
  }

  /* This method is called to get the widget that is displayed in the popover */
  public override Gtk.Widget? get_widget () {
    if (main_widget == null) {
      main_widget = new ServicesManager.Widgets.PopoverWidget ();
    }

    return main_widget;
  }

  /* This method is called when the indicator popover opened */
  public override void opened () {
    main_widget.update_services_state ();
  }

  /* This method is called when the indicator popover closed */
  public override void closed () { }
}

/*
 * This method is called once after your plugin has been loaded.
 * Create and return your indicator here if it should be displayed on the current server.
 */
 public Wingpanel.Indicator? get_indicator (Module module, Wingpanel.IndicatorManager.ServerType server_type) {
  /* A small message for debugging reasons */
  debug ("Activating Services Indicator");

  /* Check which server has loaded the plugin */
  if (server_type != Wingpanel.IndicatorManager.ServerType.SESSION) {
    /* We want to display our sample indicator only in the "normal" session, not on the login screen, so stop here! */
    return null;
  }

  var indicator = new ServicesManager.Indicator ();

  return indicator;
}

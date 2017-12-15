public class Services.Indicator : Wingpanel.Indicator {
  private OverlayWidget? display_widget = null;
  private PopoverWidget? main_widget = null;

  public Indicator () {
    Object (
      code_name: Constants.EXEC_NAME,
      display_name: Constants.INDICATOR_TITLE,
      description: Constants.INDICATOR_DESCRIPTION
    );

    this.visible = true;
  }

  public override Gtk.Widget get_display_widget () {
    if (display_widget == null) {
      display_widget = new OverlayWidget ();
    }

    return display_widget;
  }

  public override Gtk.Widget? get_widget () {
    if (main_widget == null) {
      main_widget = new PopoverWidget ();
    }

    return main_widget;
  }

  public override void opened () {
    main_widget.update ();
  }

  public override void closed () { }
}


public Wingpanel.Indicator? get_indicator (Module module, Wingpanel.IndicatorManager.ServerType server_type) {
  debug ("Activating Services Indicator");

  /* We want to display our sample indicator only in the "normal" session, not on the login screen */
  if (server_type != Wingpanel.IndicatorManager.ServerType.SESSION) {
    return null;
  }

  var indicator = new Services.Indicator ();

  return indicator;
}

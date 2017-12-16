public class ServicesIndicator.UI.Indicator : Wingpanel.Indicator {
  private Widgets.OverlayWidget? display_widget = null;
  private Widgets.PopoverWidget? main_widget = null;

  public Indicator () {
    Object (
      code_name: Common.Constants.EXEC_NAME,
      display_name: Common.Constants.INDICATOR_TITLE,
      description: Common.Constants.INDICATOR_DESCRIPTION
    );

    this.visible = true;
  }

  public override Gtk.Widget get_display_widget () {
    if (display_widget == null) {
      display_widget = new Widgets.OverlayWidget ();
    }

    return display_widget;
  }

  public override Gtk.Widget? get_widget () {
    if (main_widget == null) {
      main_widget = new Widgets.PopoverWidget ();
    }

    return main_widget;
  }

  public override void opened () {
    main_widget.update ();
  }

  public override void closed () { }
}

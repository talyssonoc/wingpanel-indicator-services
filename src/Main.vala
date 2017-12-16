public Wingpanel.Indicator? get_indicator (Module module, Wingpanel.IndicatorManager.ServerType server_type) {
  debug ("Activating Services Indicator");

  /* We want to display our sample indicator only in the "normal" session, not on the login screen */
  if (server_type != Wingpanel.IndicatorManager.ServerType.SESSION) {
    return null;
  }

  var indicator = new ServicesIndicator.UI.Indicator ();

  return indicator;
}

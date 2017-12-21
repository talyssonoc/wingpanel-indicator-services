public class ServicesIndicator.Model.Service : Object {
  public signal void state_changed(bool state);
  public string id;
  public string name;

  public Service(string id, string name) {
    this.id = id;
    this.name = name;
  }

  public Service.blank() {
    this("", "");
  }

  public bool is_active {
    get {
      return ServiceRepository.get_instance().is_active(id);
    }
  }

  public void toggle() {
    ServiceRepository.get_instance().toggle(id, (is_active) => {
      state_changed(is_active);
    });
  }
}

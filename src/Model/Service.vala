public class ServicesIndicator.Model.Service : Object {
  public signal void change(bool state);
  private string id;
  public string name;

  public Service(string id, string name) {
    this.id = id;
    this.name = name;
  }

  public bool is_active() {
    return ServiceRepository.is_active(id);
  }

  public void toggle() {
    ServiceRepository.toggle(id, (is_active) => {
      change(is_active);
    });
  }
}

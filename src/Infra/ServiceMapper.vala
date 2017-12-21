namespace ServicesIndicator.Infra.ServiceMapper {
  public Model.Service[] from_variant_collection(Variant variant) {
    var services = new Model.Service[variant.n_children()];

    for (int i = 0; i < variant.n_children(); i++) {
      var raw_service = variant.get_child_value(i);

      services[i] = from_variant(raw_service);
    }

    return services;
  }

  public Variant from_model_collection(Model.Service[] services) throws GLib.VariantParseError {
    string[] serialized_services = new string[services.length];

    for (int i = 0; i < services.length; i++) {
      serialized_services[i] = from_model(services[i]);
    }

    string concatenated_services = string.joinv(", ", serialized_services);

    return GLib.Variant.parse(null, @"[$(concatenated_services)]");
  }

  private Model.Service from_variant(Variant variant) {
    var service_id = variant.lookup_value("id", GLib.VariantType.STRING).get_string();
    var service_name = variant.lookup_value("name", GLib.VariantType.STRING).get_string();

    return new Model.Service(service_id, service_name);
  }

  private string from_model(Model.Service service) {
    var id = service.id;
    var name = service.name;

    return @"{\"id\": \"$(id)\", \"name\": \"$(name)\"}";
  }
}

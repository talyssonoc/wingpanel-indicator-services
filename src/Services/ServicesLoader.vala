namespace ServicesManager.Services.ServicesLoader {
  public Services.ServiceDescriptor[] get_services_descriptors() {
    return {
      new Services.ServiceDescriptor("postgresql", "PostgreSQL")
    };
  }
}

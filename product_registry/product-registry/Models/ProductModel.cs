namespace product_registry.Models;

public class ProductModel {

    public int Id { get; set; }
    public string Name { get; set; }
    public double Price { get; set; }
    public string Description { get; set; }
    public DateTime RegistryDate { get; set; }
    public bool Useable { get; set; }
}
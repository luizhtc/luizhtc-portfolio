namespace product_registry;

public class ProductTypeModel
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Description { get; set; }
    public DateTime RegistryDate { get; set; }
    public bool Useable { get; set; }
}

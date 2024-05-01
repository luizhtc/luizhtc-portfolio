using System.ComponentModel.DataAnnotations;

namespace product_registry.Models;

public class ProductModel {

    public int Id { get; set; }

    [Required(ErrorMessage = "Product Name is required")]
    [MinLength(2, ErrorMessage = "Product name must have at least 2 characters")]
    [Display(Name = "Product Name")]
    public string Name { get; set; }

    [Required]
    public double Price { get; set; }

    public string Description { get; set; }

    public DateTime RegistryDate { get; set; }
    
    public bool Useable { get; set; }

    public ProductTypeModel productType {get; set; }
}
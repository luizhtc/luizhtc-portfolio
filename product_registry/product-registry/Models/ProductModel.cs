using System.ComponentModel.DataAnnotations;

namespace product_registry.Models;

public class ProductModel {

    public int Id { get; set; }

    [Required(ErrorMessage = "Product Name is required.")]
    [StringLength(50, MinimumLength = 2, ErrorMessage = "Product name must have at least 2 characters and maximum 50 characters")]
    [Display(Name = "Product Name")]
    public string Name { get; set; }

    [Required(ErrorMessage = "Price is required.")]
    [Display(Name = "Price")]
    public double Price { get; set; }

    [Display(Name = "Description")]
    public string Description { get; set; }

    public DateTime RegistryDate { get; set; }
    
    [Required(ErrorMessage = "Useable flag is required.")]
    public bool Useable { get; set; }
}
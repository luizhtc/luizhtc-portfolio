using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using product_registry.Models;

namespace product_registry;

public class ProductController : Controller
{
    private readonly ILogger<ProductController> _logger;

    public ProductController(ILogger<ProductController> logger)
    {
        _logger = logger;
    }

    public IActionResult Index()
    {
        IList<ProductModel> products =
        [
            new ProductModel {
                Id = 1,
                Name = "Product 1",
                Price = 2.5,
                Description = "This is Product 1",
                RegistryDate = DateTime.UtcNow,
                Useable = true
            },
            new ProductModel {
                Id = 2,
                Name = "Product 2",
                Price = 3,
                Description = "This is Product 2",
                RegistryDate = DateTime.UtcNow,
                Useable = true
            },
            new ProductModel {
                Id = 3,
                Name = "Product 3",
                Price = 4.76,
                Description = "This is Product 3",
                RegistryDate = DateTime.UtcNow,
                Useable = true
            }
        ];

        return View(products);
    }

    public IActionResult Register()
    {
        return View();
    }

    [HttpPost]
    public IActionResult Register(ProductModel productTeste)
    {
        if (ModelState.IsValid)
        {
            @TempData["message"] = "Product successfully registered.";
            @TempData["newProductId"] = productTeste.Id;
            @TempData["newProductName"] = productTeste.Name;
            @TempData["newProductPrice"] = productTeste.Price.ToString();
            @TempData["newProductDescription"] = productTeste.Description;
            @TempData["newProductUseable"] = productTeste.Useable.ToString();

            return RedirectToAction("Index", "Product");
        }
        else
        {
            return View(productTeste);
        }
    }
    

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}

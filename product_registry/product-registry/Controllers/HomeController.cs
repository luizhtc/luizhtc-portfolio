using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using product_registry.Models;

namespace product_registry.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;

    public HomeController(ILogger<HomeController> logger)
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

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}

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
        return View();
    }

    public IActionResult Register()
    {
        return View();
    }

    [HttpPost]
    public IActionResult Register(ProductModel newProduct)
    {
        if (ModelState.IsValid)
        {
            return RedirectToAction("Index", "Product");
        }
        else
        {
            return View(newProduct);
        }
    }
    

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}

using System.Diagnostics;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.Sqlite;
using product_registry.Models;
using product_registry.Repository.DAL;

namespace product_registry;

public class ProductController : Controller
{
    private readonly ProductRepository productRepository;
    private readonly ILogger<ProductController> _logger;

    public ProductController(ILogger<ProductController> logger)
    {
        _logger = logger;

        productRepository = new ProductRepository();
    }

    [HttpGet]
    public IActionResult Index()
    {
        var result = productRepository.Read();

        return View(result);
    }

    [HttpGet]
    public IActionResult Create()
    {
        productRepository.Create();

        return RedirectToAction("Index", "Product");
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
            productRepository.Insert(newProduct);

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

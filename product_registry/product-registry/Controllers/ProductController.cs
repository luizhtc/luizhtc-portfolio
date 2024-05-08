using System.Diagnostics;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.Sqlite;
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
        ProductModel product = new ProductModel {
            Id = 1,
            Name = "Test",
            Price = 1.5,
            Description = "TestDesc",
            RegistryDate = DateTime.Now,
            Useable = true
        };

        var products = new List<ProductModel>
        {
            product
        };

        return View(products);
    }

    public void Create() {
        using var conn = new SqliteConnection($"Data Source=product.db");

        const string sql = @"CREATE TABLE IF NOT EXISTS product (
                                [ID] INT IDENTITY(1,1),
                                [NAME] NVARCHAR(50) NOT NULL,
                                [PRICE] DECIMAL(10,2) NOT NULL,
                                [DESCRIPTION] NVARCHAR(100) NULL,
                                [REGISTRY_DATE] DATE NOT NULL,
                                [USEABLE] BIT NOT NULL
                            );";

        int v = conn.Execute(sql);

        Console.WriteLine(v);
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
            using var conn = new SqliteConnection($"Data Source=product.db");

            const string sql = @"INSERT INTO product (NAME, PRICE, DESCRIPTION, REGISTRY_DATE, USEABLE)
                                VALUES ('EXAMPLE', 1.5, 'EXAMPLE DESCRIPTION', TO_DATE('2024-05-08'), 1);";

            int v = conn.Execute(sql);

            Console.WriteLine(v);

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

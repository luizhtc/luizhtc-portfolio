using System.Data.SQLite;
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

        string DbPath = "Data Source=products.db";
        
        using(var conn = new SQLiteConnection(DbPath)) 
        {
            conn.Open();

            var tableCmd = conn.CreateCommand();
            tableCmd.CommandText = "CREATE TABLE product(Id, Teste)";
            tableCmd.ExecuteNonQuery();

            var selectCmd = conn.CreateCommand();
            selectCmd.CommandText = "SELECT * FROM product";

            using(var reader = selectCmd.ExecuteReader()) 
            {
                while(reader.Read()) 
                {
                    var result = reader.GetString(0);
                    Console.WriteLine(result);
                }
            } 
        };

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

using Dapper;
using Microsoft.Data.Sqlite;
using product_registry.Models;

namespace product_registry.Repository.DAL;

public class ProductRepository
{
    // C
    public async void Create() 
    {
        await using var conn = new SqliteConnection($"Data Source=product.db");

        const string sql = @"CREATE TABLE IF NOT EXISTS product (
                                [ID] INTEGER PRIMARY KEY AUTOINCREMENT,
                                [NAME] NVARCHAR(50) NOT NULL,
                                [PRICE] DECIMAL(10,2) NOT NULL,
                                [DESCRIPTION] NVARCHAR(100) NULL,
                                [REGISTRYDATE] DATE NOT NULL,
                                [USEABLE] BIT NOT NULL
                            );";

        var response = await conn.ExecuteAsync(sql);
        conn.Close();
    }

    //R
    public IEnumerable<ProductModel> Read()
    {
        using var conn = new SqliteConnection($"Data Source=product.db");

        const string sql = @"SELECT * FROM product;";

        var response = conn.Query<ProductModel>(sql);
        conn.Close();

        Console.WriteLine(response);

        return response;
    }

    //U
    public void Update() 
    {

    }

    //D
    public void Delete() 
    {
        
    }

    public async void Insert(ProductModel newProduct)
    {
        await using var conn = new SqliteConnection($"Data Source=product.db");

        const string sql = @"INSERT INTO product (NAME, PRICE, DESCRIPTION, REGISTRYDATE, USEABLE)
                            VALUES (:name, :price, :description, DATETIME('2024-05-08 00:01:01'), :useable);";

        var command = conn.CreateCommand();

        command.CommandText = sql;
        command.Parameters.AddWithValue("name", newProduct.Name);
        command.Parameters.AddWithValue("price", Convert.ToDouble(newProduct.Price));
        command.Parameters.AddWithValue("description", newProduct.Description);
        command.Parameters.AddWithValue("useable", newProduct.Useable);

        conn.Open();
        var response = await command.ExecuteNonQueryAsync();

        Console.WriteLine(response);

        conn.Close();
    }
}

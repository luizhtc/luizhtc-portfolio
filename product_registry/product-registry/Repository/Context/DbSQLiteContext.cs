using Microsoft.Data.Sqlite;

namespace product_registry.Repository.Context;

public class DbSQLiteContext
{
    private static readonly String DbPath = "product.db";

    protected SqliteConnection conn = new SqliteConnection(DbPath);
    
}

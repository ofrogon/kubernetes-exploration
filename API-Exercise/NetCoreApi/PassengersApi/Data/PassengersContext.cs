using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace PassengersApi.Models
{
    public class PassengersContext : DbContext
    {
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            var hostname = Environment.GetEnvironmentVariable("SQLSERVER_HOST") ?? "localhost,1433";
            var password = Environment.GetEnvironmentVariable("SQLSERVER_SA_PASSWORD") ?? "TestPassword1!";
            optionsBuilder.UseSqlServer($"data source={hostname};initial catalog=PassengersApi;persist security info=True;user id=SA;password={password};MultipleActiveResultSets=True;");
        }

        public DbSet<PassengersApi.Models.Passenger> Passengers { get; set; }
    }
}

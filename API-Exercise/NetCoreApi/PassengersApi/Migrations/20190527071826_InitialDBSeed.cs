using System;
using System.IO;
using System.Linq;
using System.Text;
using CsvHelper;
using CsvHelper.Configuration;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.Extensions.Configuration;
using PassengersApi.Models;

namespace PassengersApi.Migrations
{
    public partial class InitialDBSeed : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            FileInfo seedFilePath = new FileInfo(Path.Combine(Directory.GetCurrentDirectory(), "Migrations/DataSeed/titanic.csv"));
            Console.WriteLine($"Titanic: {seedFilePath}");

            using (StreamReader reader = new StreamReader(seedFilePath.FullName, Encoding.ASCII))
            using (CsvReader csvReader = new CsvReader(reader))
            using (PassengersContext context = new PassengersContext())
            {
                var records = csvReader.GetRecords<Passenger>().ToArray();
                context.Passengers.AddRange(records);
                context.SaveChanges();
            }
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            using (PassengersContext context = new PassengersContext())
            {
                context.Database.ExecuteSqlCommand("TRUNCATE TABLE [TableName]");
            }
        }
    }
}

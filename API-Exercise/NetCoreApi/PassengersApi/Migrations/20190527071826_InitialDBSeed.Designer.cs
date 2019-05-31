﻿// <auto-generated />
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using PassengersApi.Models;

namespace PassengersApi.Migrations
{
    [DbContext(typeof(PassengersContext))]
    [Migration("20190527071826_InitialDBSeed")]
    partial class InitialDBSeed
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "2.2.4-servicing-10062")
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("PassengersApi.Models.Passengers", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<double>("Age");

                    b.Property<double>("Fare");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100);

                    b.Property<int>("ParentsChildren");

                    b.Property<int>("Pclass");

                    b.Property<string>("Sex")
                        .IsRequired()
                        .HasMaxLength(10);

                    b.Property<int>("SiblingsSpouses");

                    b.Property<int>("Survived");

                    b.HasKey("Id");

                    b.ToTable("Passengers","dbo");
                });
#pragma warning restore 612, 618
        }
    }
}

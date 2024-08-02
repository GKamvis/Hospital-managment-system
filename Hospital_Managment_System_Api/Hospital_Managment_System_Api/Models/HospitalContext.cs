using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace Hospital_Managment_System_Api.Models;

public partial class HospitalContext : DbContext
{
    public HospitalContext()
    {
    }

    public HospitalContext(DbContextOptions<HospitalContext> options)
        : base(options)
    {
    }

    public virtual DbSet<TableAnalysis> TableAnalyses { get; set; }

    public virtual DbSet<TableDoctor> TableDoctors { get; set; }

    public virtual DbSet<TableNurse> TableNurses { get; set; }

    public virtual DbSet<TablePatient> TablePatients { get; set; }

    public virtual DbSet<TableStaff> TableStaffs { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=WINDOWS-72BBIO9\\SQLEXPRESS02;Initial Catalog=Hospital;Integrated Security=True;Trust Server Certificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<TableAnalysis>(entity =>
        {
            entity.HasKey(e => e.AnalysisId);

            entity.ToTable("Table_Analysis");

            entity.Property(e => e.AnalysisName)
                .HasMaxLength(50)
                .HasColumnName("Analysis_Name");
            entity.Property(e => e.AnalysisPrice).HasColumnName("Analysis_Price");
        });

        modelBuilder.Entity<TableDoctor>(entity =>
        {
            entity.HasKey(e => e.DoctorId);

            entity.ToTable("Table_Doctors");

            entity.Property(e => e.DoctorId).HasColumnName("DoctorID");
            entity.Property(e => e.DoctorName)
                .HasMaxLength(50)
                .HasColumnName("Doctor_Name");
            entity.Property(e => e.DoctorRoomNumber).HasColumnName("Doctor_RoomNumber");
            entity.Property(e => e.DoctorSpecialty)
                .HasMaxLength(50)
                .HasColumnName("Doctor_Specialty");
            entity.Property(e => e.DoctorSurname)
                .HasMaxLength(50)
                .HasColumnName("Doctor_Surname");
        });

        modelBuilder.Entity<TableNurse>(entity =>
        {
            entity.HasKey(e => e.NurseId);

            entity.ToTable("Table_Nurses");

            entity.Property(e => e.NurseName)
                .HasMaxLength(50)
                .HasColumnName("Nurse_Name");
            entity.Property(e => e.NurseSurname)
                .HasMaxLength(50)
                .HasColumnName("Nurse_Surname");
        });

        modelBuilder.Entity<TablePatient>(entity =>
        {
            entity.HasKey(e => e.PatientId);

            entity.ToTable("Table_Patient");

            entity.Property(e => e.PatientAppeal)
                .HasMaxLength(250)
                .HasColumnName("Patient_Appeal");
            entity.Property(e => e.PatientDoctor)
                .HasMaxLength(50)
                .HasColumnName("Patient_Doctor");
            entity.Property(e => e.PatientName)
                .HasMaxLength(50)
                .HasColumnName("Patient_Name");
            entity.Property(e => e.PatientSurname)
                .HasMaxLength(50)
                .HasColumnName("Patient_Surname");
        });

        modelBuilder.Entity<TableStaff>(entity =>
        {
            entity.HasKey(e => e.StaffId);

            entity.ToTable("Table_Staff");

            entity.Property(e => e.StaffName)
                .HasMaxLength(50)
                .HasColumnName("Staff_Name");
            entity.Property(e => e.StaffSurname)
                .HasMaxLength(50)
                .HasColumnName("Staff_Surname");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}

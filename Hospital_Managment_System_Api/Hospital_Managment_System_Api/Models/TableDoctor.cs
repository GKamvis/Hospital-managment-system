using System;
using System.Collections.Generic;

namespace Hospital_Managment_System_Api.Models;

public partial class TableDoctor
{
    public int DoctorId { get; set; }

    public string? DoctorName { get; set; }

    public string? DoctorSurname { get; set; }

    public string? DoctorSpecialty { get; set; }

    public int? DoctorRoomNumber { get; set; }
}

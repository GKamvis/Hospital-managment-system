using System;
using System.Collections.Generic;

namespace Hospital_Managment_System_Api.Models;

public partial class TablePatient
{
    public int PatientId { get; set; }

    public string? PatientName { get; set; }

    public string? PatientSurname { get; set; }

    public string? PatientAppeal { get; set; }

    public string? PatientDoctor { get; set; }

    public int? AnalysisId { get; set; }
}

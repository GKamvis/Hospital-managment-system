using System;
using System.Collections.Generic;

namespace Hospital_Managment_System_Api.Models;

public partial class TableNurse
{
    public int NurseId { get; set; }

    public string? NurseName { get; set; }

    public string? NurseSurname { get; set; }
}

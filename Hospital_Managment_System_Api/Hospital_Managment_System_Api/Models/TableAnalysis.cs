using System;
using System.Collections.Generic;

namespace Hospital_Managment_System_Api.Models;

public partial class TableAnalysis
{
    public int AnalysisId { get; set; }

    public string? AnalysisName { get; set; }

    public double? AnalysisPrice { get; set; }
}

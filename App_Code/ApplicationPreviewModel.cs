using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ApplicationPreviewModel
/// </summary>
public class ApplicationPreviewModel
{
    
    public ApplicationPreviewModel()
    {
        Members = new List<MemberModel>();
        Financials = new List<FinancialModel>();
        Projects = new List<ProjectModel>();
    }

    public RegistrationModel Registration { get; set; }
    public BasicDetailModel BasicDetail { get; set; }

    public List<MemberModel> Members { get; set; }
    public List<FinancialModel> Financials { get; set; }
    public List<ProjectModel> Projects { get; set; } 
}



[Serializable]
public class RegistrationModel
{
    public int Reg_Id { get; set; }
    public string Reg_Code { get; set; }

    // Organization
    public string OrgName { get; set; }

    // Contact
    public string Phone { get; set; }
    public string Email { get; set; }

    // Identity
    public string PAN { get; set; }
    public string Website { get; set; }

    // Registered Address
    public string Address { get; set; }
    public string State { get; set; }
    public string District { get; set; }
    public string PIN_Code { get; set; }

    // Authorized Person
    public string AuthName { get; set; }
    public string AuthDesig { get; set; }
    public string AuthMobile { get; set; }
    public string AuthEmail { get; set; }

    // Status
    public string Reg_Status { get; set; }
}
[Serializable]
 public class BasicDetailModel
{
    // Organization Details
    public string OrgType { get; set; }
    public string ActRegistered { get; set; }

    public string RegistrationNumber { get; set; }
    public DateTime? RegistrationDate { get; set; }

    public string TAN { get; set; }

    // Communication Address
    public string CommAddress { get; set; }
    public string CommState { get; set; }
    public string CommDistrict { get; set; }
    public string CommPIN { get; set; }
}
public class MemberModel
{
    public int MemberID { get; set; }

    public string Name { get; set; }
    public string Designation { get; set; }

    public string Email { get; set; }
    public string Phone { get; set; }
}
[Serializable]
public class FinancialModel{
    public string FinancialYear { get; set; }
    public decimal? Turnover { get; set; }
    public decimal? NetWorth { get; set; }
    public string ITR { get; set; }
}
[Serializable]
public class ProjectModel
{
    public int ProjectID { get; set; }

    public string FinancialYear { get; set; }
    public string ProjectName { get; set; }

    public string AgencyType { get; set; }

    public string ProjectStatus { get; set; }

    public decimal? SanctionAmount { get; set; }
}


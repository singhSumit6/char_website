using System;
using System.Activities;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class IA_Review : System.Web.UI.Page
{
    int reg_id;
    public ApplicationPreviewModel PreviewData
    {
        
        get
        {
            return Session["PreviewData"] as ApplicationPreviewModel;
        }
        set
        {
            Session["PreviewData"] = value;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        reg_id = ((MasterCHAR)this.Master).Get_RegId();

        if (!IsPostBack)
        {
            ((MasterCHAR)this.Master).SetActiveStep(6);

            LoadReviewData();
            LoadLocation();
        }
    }
    private void LoadReviewData()
    {
        Dictionary<string, object> prms =
            new Dictionary<string, object>();

        prms.Add("@Reg_Id", reg_id);

        DataSet ds =
            DatabaseHelper.GET_DataSet("usp_Get_IA_FullApplication", prms);

        ApplicationPreviewModel model =
            new ApplicationPreviewModel();


        /* ================= REGISTRATION ================= */

        if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
        {
            DataRow dr = ds.Tables[0].Rows[0];

            model.Registration = new RegistrationModel
            {
                Reg_Id = reg_id,
                Reg_Code = dr["Reg_Code"].ToString(),

                OrgName = dr["OrgName"].ToString(),

                Phone = dr["Phone"].ToString(),
                Email = dr["Email"].ToString(),

                PAN = dr["PAN"].ToString(),
                Website = dr["Website"].ToString(),

                Address = dr["Address"].ToString(),
                State = dr["State"].ToString(),
                District = dr["District"].ToString(),
                PIN_Code = dr["PIN_Code"].ToString(),

                AuthName = dr["AuthName"].ToString(),
                AuthDesig = dr["AuthDesig"].ToString(),
                AuthMobile = dr["AuthMobile"].ToString(),
                AuthEmail = dr["AuthEmail"].ToString(),

                Reg_Status = dr["Reg_Status"].ToString()
            };
        }


        /* ================= BASIC DETAILS ================= */

        if (ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
        {
            DataRow dr = ds.Tables[1].Rows[0];

            model.BasicDetail = new BasicDetailModel
            {
                OrgType = dr["OrgType"].ToString(),

                ActRegistered = dr["ActRegistered"].ToString(),

                RegistrationNumber =
                    dr["RegistrationNumber"].ToString(),

                RegistrationDate =
                    dr["RegistrationDate"] == DBNull.Value
                    ? null
                    : (DateTime?)Convert.ToDateTime(dr["RegistrationDate"]),

                TAN = dr["TAN"].ToString(),

                // Communication Address
                CommAddress = dr["CommAddress"].ToString(),
                CommState = dr["CommState"].ToString(),
                CommDistrict = dr["CommDistrict"].ToString(),
                CommPIN = dr["CommPIN"].ToString()
            };
        }


        /* ================= MEMBERS ================= */

        if (ds.Tables.Count > 2)
        {
            foreach (DataRow dr in ds.Tables[2].Rows)
            {
                model.Members.Add(new MemberModel
                {
                    MemberID = Convert.ToInt32(dr["MemberID"]),

                    Name = dr["Name"].ToString(),

                    Designation = dr["Designation"].ToString(),

                    Email = dr["Email"].ToString(),

                    Phone = dr["Phone"].ToString()
                });
            }
        }


        /* ================= FINANCIAL ================= */

        if (ds.Tables.Count > 3)
        {
            foreach (DataRow dr in ds.Tables[3].Rows)
            {
                model.Financials.Add(new FinancialModel
                {
                    FinancialYear = dr["FinancialYear"].ToString(),

                    Turnover =
                        dr["Turnover"] == DBNull.Value
                        ? null
                        : (decimal?)Convert.ToDecimal(dr["Turnover"]),

                    NetWorth =
                        dr["NetWorth"] == DBNull.Value
                        ? null
                        : (decimal?)Convert.ToDecimal(dr["NetWorth"]),

                    ITR = dr["ITR"].ToString()
                });
            }
        }


        /* ================= PROJECT ================= */

        if (ds.Tables.Count > 4)
        {
            foreach (DataRow dr in ds.Tables[4].Rows)
            {
                model.Projects.Add(new ProjectModel
                {
                    ProjectID = Convert.ToInt32(dr["ProjectID"]),

                    FinancialYear = dr["FinancialYear"].ToString(),

                    ProjectName = dr["ProjectName"].ToString(),

                    AgencyType = dr["AgencyType"].ToString(),

                    ProjectStatus = dr["ProjectStatus"].ToString(),

                    SanctionAmount =
                        dr["SanctionAmount"] == DBNull.Value
                        ? null
                        : (decimal?)Convert.ToDecimal(dr["SanctionAmount"])
                });
            }
        }


        PreviewData = model;
    }

    private void LoadLocation()
    {
        Dictionary<string, object> prms =
            new Dictionary<string, object>();

        prms.Add("@Reg_Id", reg_id);

        DataTable dt =
          DatabaseHelper.GET_DataTable("usp_Get_IA_ProposedLocation", prms);

        gvLocation.DataSource = dt;
        gvLocation.DataBind();
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        if(PreviewData != null)
        {
            Response.Redirect("Ngo_FinalSubmittion.aspx");
        }
    }
}

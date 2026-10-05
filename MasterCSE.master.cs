using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterCSE : System.Web.UI.MasterPage
{
    public BasicProfileDetails client_info;
    protected void Page_Load(object sender, EventArgs e)
    {
        get_client_info(Get_RegId());

    }

    public int Get_RegId()
    {
        int reg_id;

        if (Request.Cookies["Reg_Id"] != null && int.TryParse(Request.Cookies["Reg_Id"].Value, out reg_id))
        {
            return reg_id; // Logged in
        }
        else
        {            // Not logged in → Redirect
            Response.Redirect("IA_Login.aspx");
            return 0;
        }
    }

    public void SetActiveStep(int stepNumber)
    {
        // Reset all steps
        step1.Attributes["class"] = "step-circle";
        //step2.Attributes["class"] = "step-circle";
       // step3.Attributes["class"] = "step-circle";
        //step4.Attributes["class"] = "step-circle";
        step5.Attributes["class"] = "step-circle";
        step6.Attributes["class"] = "step-circle";
        step7.Attributes["class"] = "step-circle";

        // Apply status
        switch (stepNumber)
        {
            case 1:
                step1.Attributes["class"] += " active-step";
                break;

            case 2:
                step1.Attributes["class"] += " completed-step";
                //  step2.Attributes["class"] += " active-step";
                break;

            case 3:
                step1.Attributes["class"] += " completed-step";
                //   step2.Attributes["class"] += " completed-step";
              //  step3.Attributes["class"] += " active-step";
                break;

            case 4:
                step1.Attributes["class"] += " completed-step";
                //  step2.Attributes["class"] += " completed-step";
              //  step3.Attributes["class"] += " completed-step";
              //  step4.Attributes["class"] += " active-step";
                break;

            case 5:
                step1.Attributes["class"] += " completed-step";
                //  step2.Attributes["class"] += " completed-step";
               // step3.Attributes["class"] += " completed-step";
               // step4.Attributes["class"] += " completed-step";
               // step5.Attributes["class"] += " active-step";
                break;
            case 6:
                step1.Attributes["class"] += " completed-step";
                // step2.Attributes["class"] += " completed-step";
                //step3.Attributes["class"] += " completed-step";
                //step4.Attributes["class"] += " completed-step";
                step5.Attributes["class"] += " completed-step";
                step6.Attributes["class"] += " active-step";
                break;

            case 7:
                step1.Attributes["class"] += " completed-step";
                // step2.Attributes["class"] += " completed-step";
              //  step3.Attributes["class"] += " completed-step";
               // step4.Attributes["class"] += " completed-step";
                step5.Attributes["class"] += " completed-step";
                step6.Attributes["class"] += " completed-step";
                step7.Attributes["class"] += " active-step";
                break;
        }
    }

    private void get_client_info(int reg_Id)
    {
        Dictionary<string, object> prms = new Dictionary<string, object>();
        prms.Add("@Reg_Id", reg_Id);
        DataTable dt = DatabaseHelper.GET_DataTable("usp_Get_IA_BasicDetails", prms);

        if (dt.Rows.Count > 0)
        {
            DataRow dr = dt.Rows[0];

            client_info = new BasicProfileDetails();

            client_info.Reg_Id = reg_Id;
            client_info.Reg_Code = dr["Reg_Code"].ToString();
            client_info.OrgName = dr["OrgName"].ToString();
            client_info.OrgType = dr["OrgType"].ToString();
            client_info.OrgEmail = dr["OrgEmail"].ToString();
            client_info.OrgMobile = dr["OrgMobile"].ToString();
            client_info.RegState = dr["RegState"].ToString();
        }
    }

    public struct BasicProfileDetails
    {
        public int Reg_Id { get; set; }
        public string Reg_Code { get; set; }
        public string OrgName { get; set; }
        public string OrgType { get; set; }
        public string OrgEmail { get; set; }
        public string OrgMobile { get; set; }
        public string RegState { get; set; }

    }
}

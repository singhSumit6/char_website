using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class IA_Registration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            Dictionary<string, object> prms = new Dictionary<string, object>();
            // 0 = New Registration
            prms.Add("@Reg_Id", 0);
            prms.Add("@OrgName", txtOrgName.Text.Trim());
            prms.Add("@Phone", txtMobile.Text.Trim());
            prms.Add("@Email", txtEmail.Text.Trim());
            prms.Add("@Password", "123");
            prms.Add("@PAN", txtPAN.Text.Trim());
            prms.Add("@Website", txtWebsite.Text.Trim());
            prms.Add("@Address", txtAddress.Text.Trim());
            prms.Add("@State", ddlState.SelectedValue);
            prms.Add("@District", txtDistrict.Text.Trim());
            prms.Add("@PIN_Code", txtPin.Text.Trim());
            prms.Add("@AuthName", txtAuthName.Text.Trim());
            prms.Add("@AuthDesig", txtAuthDesig.Text.Trim());
            //prms.Add("@RegDate", DateTime.Now.ToString("dd-MM-yyyy"));
            prms.Add("@PaymentStatus", 1);
            prms.Add("@Reg_Status", 1);
            prms.Add("@IsActive", 1);

            DataTable response = DatabaseHelper.GET_DataTable("usp_IA_Registration", prms);

            if (response.Rows.Count > 0)
            {
                int status = Convert.ToInt32(response.Rows[0]["Status"]);
                string message = response.Rows[0]["Message"].ToString();
                //int regId = Convert.ToInt32(response.Rows[0]["Id"]);

                //MsgAlert.Visible = true;
                //MsgLiteral.Text = message;

                Response.Write(message);
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }
}
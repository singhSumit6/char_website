
using Razorpay.Api;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class IA_Registration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            rblRegistrationType.SelectedValue = "NGO";
            ConfigureRegistrationType();
        }
    }

    protected void rblRegistrationType_SelectedIndexChanged(
        object sender, EventArgs e)
    {
        ConfigureRegistrationType();
        lblMessage.Text = "";
    }

    private void ConfigureRegistrationType()
    {
        bool isNGO = rblRegistrationType.SelectedValue == "NGO";

        pnlNGO.Visible = isNGO;
        pnlCSC.Visible = !isNGO;

        btnSubmit.ValidationGroup = isNGO ? "NGOGroup" : "CSCGroup";
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            bool isNGO = rblRegistrationType.SelectedValue == "NGO";

            string registrationType = isNGO ? "NGO" : "CSC";
            string name = isNGO
                ? txtOrgName.Text.Trim()
                : txtCSCHolderName.Text.Trim();

            string mobile = isNGO
                ? txtMobile.Text.Trim()
                : txtCSCMobile.Text.Trim();

            string email = isNGO
                ? txtEmail.Text.Trim()
                : txtCSCEmail.Text.Trim();

            string pan = isNGO
                ? txtPAN.Text.Trim().ToUpperInvariant()
                : null;

            string aadhaar = isNGO
                ? null
                : txtAadhaar.Text.Trim();

            Dictionary<string, object> prms =
                new Dictionary<string, object>();

            prms.Add("@Reg_Id", 0);
            prms.Add("@RegistrationType", registrationType);
            prms.Add("@OrgName", name);
            prms.Add("@Phone", mobile);
            prms.Add("@Email", email);
        
            prms.Add("@Password", "123");

            prms.Add("@PAN", (object)pan ?? DBNull.Value);
            prms.Add("@Aadhaar", (object)aadhaar ?? DBNull.Value);

            prms.Add("@Website", DBNull.Value);
            prms.Add("@Address", DBNull.Value);
            prms.Add("@State", DBNull.Value);
            prms.Add("@District", DBNull.Value);
            prms.Add("@PIN_Code", DBNull.Value);

            prms.Add("@AuthName", isNGO
                ? (object)DBNull.Value
                : name);

            prms.Add("@AuthDesig", DBNull.Value);
            prms.Add("@AuthMobile", DBNull.Value);
            prms.Add("@AuthEmail", DBNull.Value);

            prms.Add("@PaymentStatus", "1");
            prms.Add("@Reg_Status", "1");
            prms.Add("@IsActive", true);

            DataTable response =
                DatabaseHelper.GET_DataTable(
                    "usp_IA_Registration", prms);

            if (response != null && response.Rows.Count > 0)
            {
                int status =
                    Convert.ToInt32(response.Rows[0]["Status"]);

                string message =
                    Convert.ToString(response.Rows[0]["Message"]);

                showToast(Server.HtmlEncode(message), status == 1);

                if (status == 1)
                {
                    ClearFields();
                    // Registration successful.
                    //response.Rows[0]["Id"]
                }
            }
            else
            {
                showToast("No response received from database.", false);
            }
        }
        catch (Exception)
        {
            showToast("Registration failed. Please try again.", false);
        }
    }



    private void showToast(string message, bool success)
    {
        lblMessage.Text = message;
               
        if (success)
        {
            lblMessage.CssClass = "bg-success text-white d-block mt-3 p-3 rounded fw-bold";
        }
        else
        {
            lblMessage.CssClass = "bg-danger text-white d-block mt-3 p-3 rounded fw-bold";
        }
    }



    private void ClearFields()
    {
        // NGO fields
        txtOrgName.Text = string.Empty;
        txtMobile.Text = string.Empty;
        txtEmail.Text = string.Empty;
        txtPAN.Text = string.Empty;

        // CSC fields
        txtCSCHolderName.Text = string.Empty;
        txtCSCMobile.Text = string.Empty;
        txtCSCEmail.Text = string.Empty;
        txtAadhaar.Text = string.Empty;
    }


}

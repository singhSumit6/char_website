using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AI_Financial : System.Web.UI.Page
{
    int reg_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        reg_id = ((MasterCHAR)this.Master).Get_RegId();

        if (!IsPostBack)
        {
            ((MasterCHAR)this.Master).SetActiveStep(3);

            LoadFinancial(reg_id);
        }
    }
    protected void btnSaveFinancial_Click(object sender, EventArgs e)
    {
        Page.Validate("Financial");

        if (!Page.IsValid)
        {
            ScriptManager.RegisterStartupScript(
                this, GetType(), "showFinancialModal",
                "showFinancialModal();", true);
            return;
        }

        try
        {
            int financialId = string.IsNullOrEmpty(hfFinancialID.Value)
                ? 0
                : Convert.ToInt32(hfFinancialID.Value);

            string itrFile = "";

            if (fuITRFile.HasFile)
            {
                string folder = Server.MapPath("~/Uploads/Financial/");

                if (!System.IO.Directory.Exists(folder))
                    System.IO.Directory.CreateDirectory(folder);

                string extension =
                    System.IO.Path.GetExtension(fuITRFile.FileName);

                string fileName = Guid.NewGuid().ToString("N") + extension;

                fuITRFile.SaveAs(
                    System.IO.Path.Combine(folder, fileName));

                itrFile = "Uploads/Financial/" + fileName;
            }

            Dictionary<string, object> prms =
                new Dictionary<string, object>();

            prms.Add("@FinancialID", financialId);
            prms.Add("@Reg_Id", reg_id);
            prms.Add("@FinancialYear", txtYear.Text.Trim());
            prms.Add("@Turnover", txtTurnover.Text.Trim());
            prms.Add("@NetWorth", txtNetWorth.Text.Trim());
            prms.Add("@ITR", txtITR.Text.Trim());
            prms.Add("@FinReport", txtFinReport.Text.Trim());
            prms.Add("@ITRFile", itrFile);
            prms.Add("@FinStatementFile", "");

            DataTable dt = DatabaseHelper.GET_DataTable(
                "usp_Upsert_IA_Financial", prms);

            if (dt.Rows.Count > 0 &&
                Convert.ToInt32(dt.Rows[0]["Status"]) == 1)
            {
                LoadFinancial(reg_id);

                hfFinancialID.Value = "";
                txtYear.Text = "";
                txtTurnover.Text = "";
                txtNetWorth.Text = "";
                txtITR.Text = "";
                txtFinReport.Text = "";

                showToast(Convert.ToString(dt.Rows[0]["Message"]), true);
            }
            else
            {
                lblMsg.CssClass = "text-danger";

                showToast(dt.Rows.Count > 0
                    ? Convert.ToString(dt.Rows[0]["Message"])
                    : "Unable to save financial details.", false);

                ScriptManager.RegisterStartupScript(
                    this, GetType(), "showFinancialModal",
                    "showFinancialModal();", true);
            }
        }
        catch (Exception ex)
        {
           
            showToast("Error saving financial details: " + ex.Message, false);

            ScriptManager.RegisterStartupScript(
                this, GetType(), "showFinancialModal",
                "showFinancialModal();", true);
        }
    }

    private void LoadFinancial(int regId)
    {
        try
        {
            Dictionary<string, object> prms =
                new Dictionary<string, object>();

            prms.Add("@Reg_Id", regId);

            DataTable dt = DatabaseHelper.GET_DataTable(
                "usp_Get_IA_Financial", prms);

            gvFinancial.DataSource = dt;
            gvFinancial.DataBind();
        }
        catch (Exception ex)
        {
            showToast(Server.HtmlEncode(ex.Message), false);
        }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        int finId = Convert.ToInt32(btn.CommandArgument);

        try
        {
            Dictionary<string, object> prms =
                new Dictionary<string, object>();

            prms.Add("@FinancialID", finId);
            prms.Add("@Reg_Id", reg_id);

            DataTable dt = DatabaseHelper.GET_DataTable(
                "usp_Get_IA_Financial", prms);

            if (dt.Rows.Count == 0)
            {

                showToast("Financial record not found.", false);

                return;
            }

            DataRow dr = dt.Rows[0];

            hfFinancialID.Value = dr["FinancialID"].ToString();
            txtYear.Text = dr["FinancialYear"].ToString();
            txtTurnover.Text = dr["Turnover"].ToString();
            txtNetWorth.Text = dr["NetWorth"].ToString();
            txtITR.Text = dr["ITR"].ToString();
            txtFinReport.Text = dr["FinReport"].ToString();

            lblMsg.Text = "";

            ScriptManager.RegisterStartupScript(
                 Page,
                 Page.GetType(),
                 "OpenFinancialModal",
                 "window.onload = function() { showFinancialModal(); };",
                 true
             );
        }
        catch (Exception ex)
        {
           
            showToast("Error loading record: " + ex.Message, false);
        }
    }


    protected void btnDelete_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        int finId = Convert.ToInt32(btn.CommandArgument);

        try
        {
            Dictionary<string, object> prms =
                new Dictionary<string, object>();

            prms.Add("@FinancialID", finId);
            prms.Add("@Reg_Id", reg_id);

            DataTable dt = DatabaseHelper.GET_DataTable(
                "usp_Delete_IA_Financial", prms);

            if (dt.Rows.Count > 0 &&
                Convert.ToInt32(dt.Rows[0]["Status"]) == 1)
            {
                showToast(Convert.ToString(dt.Rows[0]["Message"]), true);

                LoadFinancial(reg_id);
            }
            else
            {
                showToast(dt.Rows.Count > 0
                    ? Convert.ToString(dt.Rows[0]["Message"])
                    : "Unable to delete record.", false);
            }
        }
        catch (Exception ex)
        {
            showToast("Error deleting record: " + ex.Message, false);
        }
    }



    private void showToast(string message, bool success)
    {
        lblMsg.Text = message;

        if (success)
        {
            lblMsg.CssClass = "bg-success text-white d-block m-3 p-3 rounded fw-bold";
        }
        else
        {
            lblMsg.CssClass = "bg-danger text-white d-block m-3 p-3 rounded fw-bold";
        }
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        if(gvFinancial.Rows.Count > 0)
        {
            Response.Redirect("IA_Experience.aspx");
        }
        else
        {
            showToast("Please add at least one finicial record.", false);
        }
    }
}
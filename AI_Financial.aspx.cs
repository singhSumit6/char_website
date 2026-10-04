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
        Dictionary<string, object> prms = new Dictionary<string, object>();

        prms.Add("@FinancialID",
            string.IsNullOrEmpty(hfFinancialID.Value) ? 0 : Convert.ToInt32(hfFinancialID.Value));

        prms.Add("@Reg_Id", reg_id);
        prms.Add("@FinancialYear", txtYear.Text);
        prms.Add("@Turnover", txtTurnover.Text);
        prms.Add("@NetWorth", txtNetWorth.Text);
        prms.Add("@ITR", txtITR.Text);
        prms.Add("@FinReport", txtFinReport.Text);

        string filePath = "";
        if (fuITRFile.HasFile)
        {
            filePath = "Uploads/" + fuITRFile.FileName;
            fuITRFile.SaveAs(Server.MapPath("~/" + filePath));
        }

        prms.Add("@ITRFile", filePath);

        DataTable dt = DatabaseHelper.GET_DataTable("usp_Upsert_IA_Financial", prms);

        if (dt.Rows.Count > 0 && Convert.ToInt32(dt.Rows[0]["Status"]) == 1)
        {
            LoadFinancial(reg_id);
        }
    }
    private void LoadFinancial(int Reg_Id)
    {
        try
        {
            Dictionary<string, object> prms = new Dictionary<string, object>();

            prms.Add("@Reg_Id", Reg_Id);

            DataTable dt = DatabaseHelper.GET_DataTable("usp_Get_IA_Financial", prms);

            gvFinancial.DataSource = dt;
            gvFinancial.DataBind();
        }
        catch (Exception ex)
        {
            //lblMsg.Text = ex.Message;
            //lblMsg.CssClass = "text-danger";
        }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;

        int finId = Convert.ToInt32(btn.CommandArgument);

        Dictionary<string, object> prms = new Dictionary<string, object>();

        prms.Add("@FinancialID", finId);
        prms.Add("@Reg_Id", reg_id);

        DataTable dt =
            DatabaseHelper.GET_DataTable("usp_Get_IA_Financial", prms);

        if (dt.Rows.Count > 0)
        {
            DataRow dr = dt.Rows[0];

            hfFinancialID.Value = finId.ToString();

            txtYear.Text = dr["FinancialYear"].ToString();
            txtTurnover.Text = dr["Turnover"].ToString();
            txtNetWorth.Text = dr["NetWorth"].ToString();
            txtITR.Text = dr["ITR"].ToString();
            txtFinReport.Text = dr["FinReport"].ToString();

            ScriptManager.RegisterStartupScript(
                this, GetType(),
                "showFinModal",
                "showFinancialModal();",
                true);
        }
    }
}
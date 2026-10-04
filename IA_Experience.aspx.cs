using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class IA_Experience : System.Web.UI.Page
{
    int reg_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        reg_id = ((MasterCHAR)this.Master).Get_RegId();
        if (!IsPostBack)
        {           

            ((MasterCHAR)this.Master).SetActiveStep(4);
            LoadProjects();
        }
    }

    private void LoadProjects()
    {
        try
        {
            Dictionary<string, object> prms = new Dictionary<string, object>();
            prms.Add("@Reg_Id", reg_id);

            DataTable dt =
                DatabaseHelper.GET_DataTable("usp_Get_IA_Project", prms);

            gvProject.DataSource = dt;
            gvProject.DataBind();
        }
        catch (Exception ex)
        {
            //lblMsg.Text = ex.Message;
            //lblMsg.CssClass = "text-danger";
        }
    }
    protected void btnSaveProject_Click(object sender, EventArgs e)
    {
        try
        {
            Dictionary<string, object> prms = new Dictionary<string, object>();

            prms.Add("@ProjectID",
                string.IsNullOrEmpty(hfProjectID.Value)
                ? 0
                : Convert.ToInt32(hfProjectID.Value));

            prms.Add("@Reg_Id", reg_id);

            prms.Add("@FinancialYear", txtYear.Text.Trim());
            prms.Add("@ProjectName", txtProjectName.Text.Trim());
            prms.Add("@AgencyType", ddlAgency.SelectedValue);
            prms.Add("@ProjectLocation", txtLocation.Text.Trim());
            prms.Add("@AreaOfWork", txtArea.Text.Trim());
            prms.Add("@SanctionAmount",
                string.IsNullOrEmpty(txtAmount.Text)
                ? (object)DBNull.Value
                : Convert.ToDecimal(txtAmount.Text));

            prms.Add("@ProjectStatus", ddlStatus.SelectedValue);

            string filePath = null;

            if (fuProof.HasFile)
            {
                string folder = Server.MapPath("~/Uploads/Projects/");

                if (!Directory.Exists(folder))
                    Directory.CreateDirectory(folder);

                string fileName =
                    Guid.NewGuid().ToString() + Path.GetExtension(fuProof.FileName);

                filePath = "Uploads/Projects/" + fileName;

                fuProof.SaveAs(Path.Combine(folder, fileName));
            }

            prms.Add("@ProofFile", filePath);

            DataTable dt =
                DatabaseHelper.GET_DataTable("usp_Upsert_IA_Project", prms);

            if (dt.Rows.Count > 0)
            {
                int status = Convert.ToInt32(dt.Rows[0]["Status"]);

                if (status == 1)
                {
                    //lblMsg.Text = dt.Rows[0]["Message"].ToString();
                    //lblMsg.CssClass = "text-success";

                    Response.Write(dt.Rows[0]["Message"].ToString());

                    ClearProjectForm();
                    LoadProjects();

                    ScriptManager.RegisterStartupScript(
                        this, GetType(),
                        "closeModal",
                        "$('#projectModal').modal('hide');",
                        true);
                }
                else
                {
                    //lblMsg.Text = dt.Rows[0]["Message"].ToString();
                    //lblMsg.CssClass = "text-danger";

                    Response.Write(dt.Rows[0]["Message"].ToString());
                }
            }
        }
        catch (Exception ex)
        {
            //lblMsg.Text = ex.Message;
            //lblMsg.CssClass = "text-danger";
            Response.Write(ex.Message);
        }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;

            int projectId = Convert.ToInt32(btn.CommandArgument);

            Dictionary<string, object> prms = new Dictionary<string, object>();
            prms.Add("@ProjectID", projectId);
            prms.Add("@Reg_Id", reg_id);

            DataTable dt =
                DatabaseHelper.GET_DataTable("usp_Get_IA_Project", prms);

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];

                hfProjectID.Value = projectId.ToString();

                txtYear.Text = dr["FinancialYear"].ToString();
                txtProjectName.Text = dr["ProjectName"].ToString();
                ddlAgency.SelectedValue = dr["AgencyType"].ToString();
                txtLocation.Text = dr["ProjectLocation"].ToString();
                txtArea.Text = dr["AreaOfWork"].ToString();
                txtAmount.Text = dr["SanctionAmount"].ToString();
                ddlStatus.SelectedValue = dr["ProjectStatus"].ToString();

                ScriptManager.RegisterStartupScript(
                    this, GetType(),
                    "showModal",
                    "showProjectModal();",
                    true);
            }
        }
        catch (Exception ex)
        {
            //lblMsg.Text = ex.Message;
            //lblMsg.CssClass = "text-danger";
        }
    }

    private void ClearProjectForm()
    {
        hfProjectID.Value = "";

        txtYear.Text = "";
        txtProjectName.Text = "";
        ddlAgency.SelectedIndex = 0;
        txtLocation.Text = "";
        txtArea.Text = "";
        txtAmount.Text = "";
        ddlStatus.SelectedIndex = 0;
    }
}
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class IA_Members : System.Web.UI.Page
{
    int reg_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        reg_id = ((MasterCHAR)this.Master).Get_RegId();
        if (!IsPostBack)
        {
            ((MasterCHAR)this.Master).SetActiveStep(2);

            LoadMembers();
        }
    }


    private void LoadMembers()
    {
        Dictionary<string, object> prms = new Dictionary<string, object>();
        prms.Add("@Reg_Id", reg_id);

        DataTable dt = DatabaseHelper.GET_DataTable("usp_Get_IA_Members", prms);

        gvMembers.DataSource = dt;
        gvMembers.DataBind();
    }


    protected void btnSaveMember_Click(object sender, EventArgs e)
    {
        Dictionary<string, object> prms = new Dictionary<string, object>();

        prms.Add("@MemberID", string.IsNullOrEmpty(hfMemberID.Value) ? 0 : Convert.ToInt32(hfMemberID.Value));

        prms.Add("@Reg_Id", reg_id);

        prms.Add("@Name", txtName.Text);
        prms.Add("@Designation", txtDesignation.Text);

        prms.Add("@Aadhaar", txtAadhaar.Text);
        prms.Add("@PAN", txtPAN.Text);

        prms.Add("@Email", txtEmail.Text);
        prms.Add("@Phone", txtPhone.Text);

        prms.Add("@Address", txtAddress.Text);

        DataTable dt =
            DatabaseHelper.GET_DataTable("usp_Upsert_IA_Member", prms);

        if (dt.Rows.Count > 0 &&
            Convert.ToInt32(dt.Rows[0]["Status"]) == 1)
        {
            LoadMembers();

            // Close modal
            ScriptManager.RegisterStartupScript(
                this, GetType(),
                "closeModal",
                "$('#memberModal').modal('hide');",
                true);
        }
    }


    protected void btnEdit_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;

        int memberId = Convert.ToInt32(btn.CommandArgument);

        Dictionary<string, object> prms = new Dictionary<string, object>();
        prms.Add("@Mem_Id", memberId);

        DataTable dt = DatabaseHelper.GET_DataTable("usp_Get_IA_Members", prms);

        if (dt.Rows.Count > 0)
        {
            DataRow dr = dt.Rows[0];

            hfMemberID.Value = memberId.ToString();

            txtName.Text = dr["Name"].ToString();
            txtDesignation.Text = dr["Designation"].ToString();
            txtAadhaar.Text = dr["Aadhaar"].ToString();
            txtPAN.Text = dr["PAN"].ToString();
            txtEmail.Text = dr["Email"].ToString();
            txtPhone.Text = dr["Phone"].ToString();
            txtAddress.Text = dr["Address"].ToString();

            // Show modal
            ScriptManager.RegisterStartupScript(
                this, GetType(),
                "showModal",
                "showMemberModal();",
                true);
        }
    }
}

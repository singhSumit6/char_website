using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class IA_Basics : System.Web.UI.Page
{
     int reg_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        reg_id = ((MasterCHAR)this.Master).Get_RegId();
        if (!IsPostBack)
        {
            ((MasterCHAR)this.Master).SetActiveStep(1);
            
            GetExistingRecord(reg_id);
        }
    }

    private void GetExistingRecord(int reg_Id)
    {
        Dictionary<string, object> prms = new Dictionary<string, object>();
        prms.Add("@Reg_Id", reg_Id);

        DataTable dt = DatabaseHelper.GET_DataTable("usp_Get_IA_BasicDetails", prms);

        if (dt != null && dt.Rows.Count > 0)
        {
            DataRow dr = dt.Rows[0];

            /* ========== BASIC ID ========== */
            hfBasicId.Value = dr["Id"].ToString();


            /* ========== ORGANIZATION ========== */
            txtOrgName.Text = dr["OrgName"].ToString();
            txtPAN.Text = dr["PAN"].ToString();
            txtWebsite.Text = dr["Website"].ToString();


            /* ========== CONTACT ========== */
            txtOrgMobile.Text = dr["OrgMobile"].ToString();
            txtOrgEmail.Text = dr["OrgEmail"].ToString();


            /* ========== ORG DETAILS ========== */
            ddlOrgType.SelectedValue = dr["OrgType"].ToString();
            txtActRegistered.Text = dr["ActRegistered"].ToString();
            txtRegNo.Text = dr["RegistrationNumber"].ToString();

            if (dr["RegistrationDate"] != DBNull.Value)
            {
                txtRegDate.Text = Convert.ToDateTime(dr["RegistrationDate"])
                                    .ToString("yyyy-MM-dd").ToString();
            }
            else
            {
                txtRegDate.Text = "";
            }

            txtTAN.Text = dr["TAN"].ToString();


            /* ========== REGISTERED ADDRESS ========== */
            txtRegAddress.Text = dr["RegAddress"].ToString();
            ddlRegState.SelectedValue = dr["RegState"].ToString();
            txtRegDistrict.Text = dr["RegDistrict"].ToString();
            txtRegPIN.Text = dr["RegPIN"].ToString();


            /* ========== COMMUNICATION ADDRESS ========== */
            txtCommAddress.Text = dr["CommAddress"].ToString();
            ddlCommState.SelectedValue = dr["CommState"].ToString();
            txtCommDistrict.Text = dr["CommDistrict"].ToString();
            txtCommPIN.Text = dr["CommPIN"].ToString();


            /* ========== AUTHORIZED PERSON ========== */
            txtAuthName.Text = dr["AuthName"].ToString();
            txtAuthDesig.Text = dr["AuthDesig"].ToString();
            txtAuthMobile.Text = dr["AuthMobile"].ToString();
            txtAuthEmail.Text = dr["AuthEmail"].ToString();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            Dictionary<string, object> prms =
                new Dictionary<string, object>();


            /* ===== BASIC IDS ===== */

            prms.Add("@Id",
                string.IsNullOrEmpty(hfBasicId.Value)
                ? 0
                : Convert.ToInt32(hfBasicId.Value));

            prms.Add("@Reg_Id", reg_id);


            /* ===== BASIC INFO (BASIC DETAIL) ===== */

            prms.Add("@OrgType", ddlOrgType.SelectedValue);
            prms.Add("@ActRegistered", txtActRegistered.Text.Trim());

            prms.Add("@RegistrationNumber", txtRegNo.Text.Trim());

            prms.Add("@RegistrationDate",
                string.IsNullOrEmpty(txtRegDate.Text)
                ? (object)DBNull.Value
                : Convert.ToDateTime(txtRegDate.Text));

            prms.Add("@TAN", txtTAN.Text.Trim());


            /* ===== COMMUNICATION ADDRESS (BASIC DETAIL) ===== */

            prms.Add("@CommAddress", txtCommAddress.Text.Trim());
            prms.Add("@CommState", ddlCommState.SelectedValue);
            prms.Add("@CommDistrict", txtCommDistrict.Text.Trim());
            prms.Add("@CommPIN", txtCommPIN.Text.Trim());


            /* ===== REGISTERED ADDRESS (REGISTRATION) ===== */

            prms.Add("@RegAddress", txtRegAddress.Text.Trim());
            prms.Add("@RegState", ddlRegState.SelectedValue);
            prms.Add("@RegDistrict", txtRegDistrict.Text.Trim());
            prms.Add("@RegPIN", txtRegPIN.Text.Trim());


            /* ===== CONTACT (REGISTRATION) ===== */

            prms.Add("@OrgMobile", txtOrgMobile.Text.Trim());
            prms.Add("@OrgEmail", txtOrgEmail.Text.Trim());


            /* ===== AUTHORIZED PERSON (REGISTRATION) ===== */

            prms.Add("@AuthName", txtAuthName.Text.Trim());
            prms.Add("@AuthDesig", txtAuthDesig.Text.Trim());
            prms.Add("@AuthMobile", txtAuthMobile.Text.Trim());
            prms.Add("@AuthEmail", txtAuthEmail.Text.Trim());


            /* ===== FILE UPLOAD ===== */

            prms.Add("@RC_File", SaveFile(fuRC));
            prms.Add("@MOA_File", SaveFile(fuMOA));
            prms.Add("@PAN_File", SaveFile(fuPAN));


            /* ===== EXECUTE ===== */

            DataTable dt =
                DatabaseHelper.GET_DataTable("usp_Upsert_IA_BasicDetail", prms);


            if (dt != null && dt.Rows.Count > 0)
            {
                int status = Convert.ToInt32(dt.Rows[0]["Status"]);

                string message = dt.Rows[0]["Message"].ToString();

                if (status == 1)
                {
                    lblMsg.Text = message;
                    lblMsg.CssClass = "text-success";

                    // Reload updated data
                    GetExistingRecord(reg_id);
                }
                else
                {
                    lblMsg.Text = message;
                    lblMsg.CssClass = "text-danger";
                }
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = "Error: " + ex.Message;
            lblMsg.CssClass = "text-danger";
        }
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {

    }

    protected void chkSameAddress_CheckedChanged(object sender, EventArgs e)
    {

    }

    private string SaveFile(FileUpload fu)
    {
        if (!fu.HasFile)
            return null;

        string folder = Server.MapPath("~/Uploads/Basic/").ToString();

        if (!Directory.Exists(folder))
            Directory.CreateDirectory(folder);

        string fileName =
            Guid.NewGuid().ToString() +
            Path.GetExtension(fu.FileName);

        string path = "Uploads/Basic/" + fileName;

        fu.SaveAs(Path.Combine(folder, fileName));

        return path;
    }
}
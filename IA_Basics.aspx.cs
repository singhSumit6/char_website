
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class IA_Basics : System.Web.UI.Page
{
    private int reg_id;

    protected void Page_Load(object sender, EventArgs e)
    {
        reg_id = ((MasterCHAR)this.Master).Get_RegId();

        if (!IsPostBack)
        {
            ((MasterCHAR)this.Master).SetActiveStep(1);

            ddlRegState.DataBind();
            ddlCommState.DataBind();

            GetExistingRecord(reg_id);
        }
    }

    // =====================================================
    // LOAD EXISTING RECORD
    // =====================================================

    private void GetExistingRecord(int regId)
    {
        Dictionary<string, object> prms =
            new Dictionary<string, object>();

        prms.Add("@Reg_Id", regId);

        DataTable dt = DatabaseHelper.GET_DataTable(
            "usp_Get_IA_BasicDetails", prms);

        if (dt == null || dt.Rows.Count == 0)
            return;

        DataRow dr = dt.Rows[0];

        hfBasicId.Value = dr["Id"].ToString();

        txtOrgName.Text = dr["OrgName"].ToString();
        txtPAN.Text = dr["PAN"].ToString();
        txtWebsite.Text = dr["Website"].ToString();

        txtOrgMobile.Text = dr["OrgMobile"].ToString();
        txtOrgEmail.Text = dr["OrgEmail"].ToString();

        SelectDropDown(ddlOrgType, dr["OrgType"].ToString());

        txtRegNo.Text = dr["RegistrationNumber"].ToString();

        if (dr["RegistrationDate"] != DBNull.Value)
        {
            txtRegDate.Text = Convert.ToDateTime(
                dr["RegistrationDate"]).ToString("yyyy-MM-dd");
        }

        // Registered address
        txtRegAddress.Text = dr["RegAddress"].ToString();
      //  txtRegTehsil.Text = dr["RegTehsil"].ToString();
        txtRegPIN.Text = dr["RegPIN"].ToString();

        SelectState(ddlRegState, dr["RegState"].ToString());

        BindDistricts(
            ddlRegDistrict,
            ddlRegState.SelectedValue,
            dr["RegDistrict"].ToString());

        // Communication address
        txtCommAddress.Text = dr["CommAddress"].ToString();
        txtCommPIN.Text = dr["CommPIN"].ToString();

        SelectState(ddlCommState, dr["CommState"].ToString());

        BindDistricts(
            ddlCommDistrict,
            ddlCommState.SelectedValue,
            dr["CommDistrict"].ToString());

        // Authorized signatory
        txtAuthName.Text = dr["AuthName"].ToString();
        txtAuthDesig.Text = dr["AuthDesig"].ToString();
        txtAuthMobile.Text = dr["AuthMobile"].ToString();
        txtAuthEmail.Text = dr["AuthEmail"].ToString();
    }

    private void SelectDropDown(DropDownList ddl, string value)
    {
        ddl.ClearSelection();

        ListItem item = ddl.Items.FindByValue(value);

        if (item == null)
            item = ddl.Items.FindByText(value);

        if (item != null)
            item.Selected = true;
    }

    private void SelectState(DropDownList ddl, string savedState)
    {
        SelectDropDown(ddl, savedState);
    }

    // =====================================================
    // DISTRICT BINDING
    // =====================================================

    private void BindDistricts(
        DropDownList ddlDistrict,
        string stateId,
        string selectedDistrict = null)
    {
        ddlDistrict.Items.Clear();
        ddlDistrict.Items.Add(
            new ListItem("Select District", "0"));

        int id;

        if (!int.TryParse(stateId, out id) || id <= 0)
            return;

        Dictionary<string, object> prms =
            new Dictionary<string, object>();

        prms.Add("@StateId", id);

        DataTable dt = DatabaseHelper.GET_DataTable(
            "sp_GetAllDistricts", prms);

        if (dt != null && dt.Rows.Count > 0)
        {
            foreach (DataRow row in dt.Rows)
            {
                string value = Convert.ToString(row["ID"]);
                string name = Convert.ToString(row["Name"]);

                // Avoid adding the placeholder twice.
                if (value == "0")
                    continue;

                ddlDistrict.Items.Add(new ListItem(name, value));
            }
        }

        if (!string.IsNullOrWhiteSpace(selectedDistrict))
        {
            ListItem item =
                ddlDistrict.Items.FindByValue(selectedDistrict);

            if (item == null)
                item = ddlDistrict.Items.FindByText(selectedDistrict);

            if (item != null)
                ddlDistrict.SelectedValue = item.Value;
        }
    }

    protected void ddlRegState_SelectedIndexChanged(
        object sender, EventArgs e)
    {
        BindDistricts(
            ddlRegDistrict,
            ddlRegState.SelectedValue);
    }

    protected void ddlCommState_SelectedIndexChanged(
        object sender, EventArgs e)
    {
        BindDistricts(
            ddlCommDistrict,
            ddlCommState.SelectedValue);
    }

    // =====================================================
    // SAME ADDRESS
    // =====================================================

    protected void chkSameAddress_CheckedChanged(
        object sender, EventArgs e)
    {
        if (!chkSameAddress.Checked)
            return;

        txtCommAddress.Text = txtRegAddress.Text;
        txtCommPIN.Text = txtRegPIN.Text;

        SelectState(
            ddlCommState,
            ddlRegState.SelectedValue);

        BindDistricts(
            ddlCommDistrict,
            ddlCommState.SelectedValue,
            ddlRegDistrict.SelectedValue);
    }

    // =====================================================
    // FILE VALIDATION
    // =====================================================

    protected void ValidateRequiredFile(
        object source, ServerValidateEventArgs args)
    {
        CustomValidator validator = (CustomValidator)source;

        FileUpload upload = null;

        if (validator.ID == "cvRC")
            upload = fuRC;
        else if (validator.ID == "cvMOA")
            upload = fuMOA;
        else if (validator.ID == "cvPAN")
            upload = fuPAN;

        // A new upload is required by this implementation.
        args.IsValid = upload != null && upload.HasFile;
    }

    private string SaveFile(FileUpload fu)
    {
        if (!fu.HasFile)
            throw new Exception("Please select all required documents.");

        string extension =
            Path.GetExtension(fu.FileName).ToLowerInvariant();

        string[] allowedExtensions =
            { ".pdf", ".jpg", ".jpeg", ".png" };

        if (Array.IndexOf(allowedExtensions, extension) < 0)
            throw new Exception(
                "Only PDF, JPG, JPEG and PNG files are allowed.");

        // Limit each upload to 5 MB.
        if (fu.PostedFile.ContentLength > 5 * 1024 * 1024)
            throw new Exception("Each document must be 5 MB or smaller.");

        string folder = Server.MapPath("~/Uploads/Basic/");

        if (!Directory.Exists(folder))
            Directory.CreateDirectory(folder);

        string fileName = Guid.NewGuid().ToString("N") + extension;

        fu.SaveAs(Path.Combine(folder, fileName));

        return "Uploads/Basic/" + fileName;
    }

    // =====================================================
    // SAVE
    // =====================================================

    protected void btnSave_Click(object sender, EventArgs e)
    {
        Page.Validate("BasicDetails");

        if (!Page.IsValid)
            return;

        try
        {
            Dictionary<string, object> prms =
                new Dictionary<string, object>();

            int basicId = 0;

            if (!string.IsNullOrWhiteSpace(hfBasicId.Value))
                int.TryParse(hfBasicId.Value, out basicId);

            prms.Add("@Id", basicId);
            prms.Add("@Reg_Id", reg_id);

            // Organization details
            prms.Add("@OrgType", ddlOrgType.SelectedValue);
            prms.Add("@RegistrationNumber", txtRegNo.Text.Trim());
            prms.Add("@RegistrationDate",
                Convert.ToDateTime(txtRegDate.Text));

            // Communication address
            prms.Add("@CommAddress", txtCommAddress.Text.Trim());
            prms.Add("@CommState", ddlCommState.SelectedItem.Text);
            prms.Add("@CommDistrict", ddlCommDistrict.SelectedValue);
            prms.Add("@CommPIN", txtCommPIN.Text.Trim());

            // Registered address
            prms.Add("@RegAddress", txtRegAddress.Text.Trim());
            prms.Add("@RegState", ddlRegState.SelectedItem.Text);
            prms.Add("@RegDistrict", ddlRegDistrict.SelectedValue);
            prms.Add("@RegPIN", txtRegPIN.Text.Trim());

            // Contact details
            prms.Add("@OrgMobile", txtOrgMobile.Text.Trim());
            prms.Add("@OrgEmail", txtOrgEmail.Text.Trim());

            // Authorized signatory
            prms.Add("@AuthName", txtAuthName.Text.Trim());
            prms.Add("@AuthDesig", txtAuthDesig.Text.Trim());
            prms.Add("@AuthMobile", txtAuthMobile.Text.Trim());
            prms.Add("@AuthEmail", txtAuthEmail.Text.Trim());
     
            //prms.Add("@RegTehsil", txtRegTehsil.Text.Trim());

            // Save uploaded documents
            prms.Add("@RC_File", SaveFile(fuRC));
            prms.Add("@MOA_File", SaveFile(fuMOA));
            prms.Add("@PAN_File", SaveFile(fuPAN));

            DataTable dt = DatabaseHelper.GET_DataTable(
                "usp_Upsert_IA_BasicDetail", prms);

            if (dt != null && dt.Rows.Count > 0)
            {
                int status = Convert.ToInt32(dt.Rows[0]["Status"]);
                string message = Convert.ToString(dt.Rows[0]["Message"]);

                lblMsg.Text = Server.HtmlEncode(message);
                lblMsg.CssClass =
                    status == 1 ? "text-success" : "text-danger";

                if (status == 1)
                    GetExistingRecord(reg_id);
            }
            else
            {
                lblMsg.Text = "No response received from database.";
                lblMsg.CssClass = "text-danger";
            }
        }
        catch (Exception)
        {
            // Log the actual exception securely on the server.
            lblMsg.Text = "Unable to save details. Please check your data and try again.";
            lblMsg.CssClass = "text-danger";
        }
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        Page.Validate("BasicDetails");

        if (!Page.IsValid)
            return;

        // Add next-step navigation here if required.
    }
}

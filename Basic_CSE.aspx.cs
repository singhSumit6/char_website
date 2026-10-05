using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Basic_CSE : System.Web.UI.Page
{
    private int reg_id;

    private string existingRCFile = "";
    private string existingMOAFile = "";
    private string existingPANFile = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        reg_id = ((MasterCSE)this.Master).Get_RegId();

        // Load saved file paths on every request for validation.
        LoadExistingFilePaths(reg_id);

        if (!IsPostBack)
        {
            ((MasterCSE)this.Master).SetActiveStep(1);

            ddlRegState.DataBind();
            ddlCommState.DataBind();

            GetExistingRecord(reg_id);
        }
    }

    // =====================================================
    // LOAD EXISTING RECORD
    // =====================================================

    private void LoadExistingFilePaths(int regId)
    {
        existingRCFile = "";
        existingMOAFile = "";
        existingPANFile = "";

        Dictionary<string, object> prms =
            new Dictionary<string, object>();

        prms.Add("@Reg_Id", regId);

        DataTable dt = DatabaseHelper.GET_DataTable(
            "usp_Get_IA_BasicDetails", prms);

        if (dt == null || dt.Rows.Count == 0)
            return;

        DataRow dr = dt.Rows[0];

        existingRCFile = dr["RC_File"] == DBNull.Value
            ? ""
            : Convert.ToString(dr["RC_File"]);

        existingMOAFile = dr["MOA_File"] == DBNull.Value
            ? ""
            : Convert.ToString(dr["MOA_File"]);

        existingPANFile = dr["PAN_File"] == DBNull.Value
            ? ""
            : Convert.ToString(dr["PAN_File"]);
    }

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


        // If already saved, move to the next step 


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

        // Files 
        existingRCFile = dr["RC_File"] == DBNull.Value
                        ? ""
                        : dr["RC_File"].ToString();

        existingMOAFile = dr["MOA_File"] == DBNull.Value
            ? ""
            : dr["MOA_File"].ToString();

        existingPANFile = dr["PAN_File"] == DBNull.Value
            ? ""
            : dr["PAN_File"].ToString();
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
     object source,
     ServerValidateEventArgs args)
    {
        CustomValidator validator = (CustomValidator)source;

        switch (validator.ID)
        {
            case "cvRC":
                args.IsValid =
                    fuRC.HasFile ||
                    !string.IsNullOrWhiteSpace(existingRCFile);
                break;

            case "cvMOA":
                args.IsValid =
                    fuMOA.HasFile ||
                    !string.IsNullOrWhiteSpace(existingMOAFile);
                break;

            case "cvPAN":
                args.IsValid =
                    fuPAN.HasFile ||
                    !string.IsNullOrWhiteSpace(existingPANFile);
                break;

            default:
                args.IsValid = false;
                break;
        }
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
            prms.Add("@Website", txtWebsite.Text.Trim());

            // Authorized signatory
            prms.Add("@AuthName", txtAuthName.Text.Trim());
            prms.Add("@AuthDesig", txtAuthDesig.Text.Trim());
            prms.Add("@AuthMobile", txtAuthMobile.Text.Trim());
            prms.Add("@AuthEmail", txtAuthEmail.Text.Trim());

            //prms.Add("@RegTehsil", txtRegTehsil.Text.Trim());
            string rcFile = fuRC.HasFile
                    ? SaveFile(fuRC)
                    : existingRCFile;

            string moaFile = fuMOA.HasFile
                ? SaveFile(fuMOA)
                : existingMOAFile;

            string panFile = fuPAN.HasFile
                ? SaveFile(fuPAN)
                : existingPANFile;

            // Save uploaded documents
            prms.Add("@RC_File", rcFile);
            prms.Add("@MOA_File", moaFile);
            prms.Add("@PAN_File", panFile);

            DataTable dt = DatabaseHelper.GET_DataTable(
                "usp_Upsert_IA_BasicDetail", prms);

            if (dt != null && dt.Rows.Count > 0)
            {
                int status = Convert.ToInt32(dt.Rows[0]["Status"]);
                string message = Convert.ToString(dt.Rows[0]["Message"]);

                showToast(Server.HtmlEncode(message), status == 1);

                if (status == 1)
                    GetExistingRecord(reg_id);
            }
            else
            {
                showToast("No response received from database.", false);
            }
        }
        catch (Exception)
        {
            showToast("Unable to save details. Please check your data and try again.", false);
        }
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        Page.Validate("BasicDetails");

        if (!Page.IsValid)
            return;

        Response.Redirect("Location_CSE.aspx");
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
}
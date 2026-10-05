using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Location_CSE : System.Web.UI.Page
{
    int reg_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        reg_id = ((MasterCSE)this.Master).Get_RegId();
        if (!IsPostBack)
        {
            LoadLocation();
            ((MasterCSE)this.Master).SetActiveStep(5);
        }
    }

    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(ddlState.SelectedValue))
        {
            BindDistricts(Convert.ToInt32(ddlState.SelectedValue));
        }

        ScriptManager.RegisterStartupScript(
               Page,
               Page.GetType(),
               "reopenLocationModal",
               "window.onload = function() { showFinancialModal(); };",
               true
         );
    }


    private void BindDistricts(int stateId)
    {
        Dictionary<string, object> prms = new Dictionary<string, object>();
        prms.Add("@StateId", stateId);

        DataTable dt = DatabaseHelper.GET_DataTable(
            "sp_GetAllDistricts",
            prms
        );

        ddlDistrict.DataSource = dt;
        ddlDistrict.DataTextField = "Name";
        ddlDistrict.DataValueField = "ID";
        ddlDistrict.DataBind();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(
       this, GetType(),
       "open",
       "$('#locationModal').modal('show');",
       true);
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (gvLocation.Rows.Count > 0)
        {
            Response.Redirect("Review_CSE.aspx");
        }
        else
        {
            showToast("Please add at least one location.", false);
        }
    }

    protected void btnSaveLocation_Click(object sender, EventArgs e)
    {
        try
        {
            Dictionary<string, object> prms =
                new Dictionary<string, object>();

            prms.Add("@LocationID",
                string.IsNullOrEmpty(hfLocationID.Value)
                    ? 0
                    : Convert.ToInt32(hfLocationID.Value));

            prms.Add("@Reg_Id", reg_id);
            prms.Add("@State", ddlState.SelectedValue);
            prms.Add("@District", ddlDistrict.SelectedValue);
            prms.Add("@Tehsil", txtTehsil.Text.Trim());
            prms.Add("@Block", txtBlock.Text.Trim());
            prms.Add("@PIN_Code", txtPIN.Text.Trim());

            prms.Add("@VillageMohalla1", txtVillageMohalla1.Text.Trim());
            prms.Add("@VillageMohalla2", txtVillageMohalla2.Text.Trim());
            prms.Add("@VillageMohalla3", txtVillageMohalla3.Text.Trim());
            prms.Add("@VillageMohalla4", txtVillageMohalla4.Text.Trim());
            prms.Add("@VillageMohalla5", txtVillageMohalla5.Text.Trim());

            DataTable dt = DatabaseHelper.GET_DataTable(
                "usp_Upsert_IA_ProposedLocation", prms);

            if (dt.Rows.Count > 0 &&
                Convert.ToInt32(dt.Rows[0]["Status"]) == 1)
            {
                LoadLocation();
                ClearLocationForm();

                ScriptManager.RegisterStartupScript(
                    this, GetType(), "closeLocationModal",
                    "bootstrap.Modal.getOrCreateInstance(" +
                    "document.getElementById('locationModal')).hide();",
                    true);

                showToast("Location saved successfully.", true);
            }
            else
            {
                string message = dt.Rows.Count > 0
                    ? Convert.ToString(dt.Rows[0]["Message"])
                    : "Unable to save location.";

                showToast(message, false);
            }
        }
        catch (Exception ex)
        {
            string safeMessage =
                HttpUtility.JavaScriptStringEncode(ex.Message);

            showToast(safeMessage, false);
        }
    }


    protected void btnEdit_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        int locationId = Convert.ToInt32(btn.CommandArgument);

        Dictionary<string, object> prms = new Dictionary<string, object>();
        prms.Add("@Reg_Id", reg_id);

        DataTable dt = DatabaseHelper.GET_DataTable(
            "usp_Get_IA_ProposedLocation", prms);

        DataRow[] rows = dt.Select("LocationID = " + locationId);

        if (rows.Length == 0)
            return;

        DataRow dr = rows[0];

        ClearLocationForm();
        hfLocationID.Value = locationId.ToString();

        string stateName = dr["State"].ToString().Trim();
        ListItem stateItem = ddlState.Items.FindByText(stateName);

        if (stateItem != null)
        {
            ddlState.SelectedValue = stateItem.Value;

            BindDistricts(Convert.ToInt32(stateItem.Value));

            string districtName = dr["District"].ToString().Trim();
            ListItem districtItem = ddlDistrict.Items.FindByText(districtName);

            if (districtItem != null)
                ddlDistrict.SelectedValue = districtItem.Value;
        }

        txtTehsil.Text = dr["Tehsil"].ToString();
        txtBlock.Text = dr["Block"].ToString();
        txtPIN.Text = dr["PIN_Code"].ToString();

        txtVillageMohalla1.Text = dr["VillageMohalla1"].ToString();
        txtVillageMohalla2.Text = dr["VillageMohalla2"].ToString();
        txtVillageMohalla3.Text = dr["VillageMohalla3"].ToString();
        txtVillageMohalla4.Text = dr["VillageMohalla4"].ToString();
        txtVillageMohalla5.Text = dr["VillageMohalla5"].ToString();

        ScriptManager.RegisterStartupScript(
            Page,
            Page.GetType(),
            "openLocationModal",
            "window.onload = function() { showFinancialModal(); };",
            true
      );
    }


    private void LoadLocation()
    {
        Dictionary<string, object> prms =
            new Dictionary<string, object>();

        prms.Add("@Reg_Id", reg_id);

        DataTable dt =
          DatabaseHelper.GET_DataTable("usp_Get_IA_ProposedLocation", prms);

        gvLocation.DataSource = dt;
        gvLocation.DataBind();
    }

    protected void btnDeleteLocation_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;
            int locationId = Convert.ToInt32(btn.CommandArgument);

            Dictionary<string, object> prms =
                new Dictionary<string, object>();

            prms.Add("@LocationID", locationId);
            prms.Add("@Reg_Id", reg_id);

            DataTable dt = DatabaseHelper.GET_DataTable(
                "usp_Delete_IA_ProposedLocation", prms);

            if (dt.Rows.Count > 0 &&
                Convert.ToInt32(dt.Rows[0]["Status"]) == 1)
            {
                LoadLocation();
                ClearLocationForm();
            }

            string message = dt.Rows.Count > 0
                ? Convert.ToString(dt.Rows[0]["Message"])
                : "Unable to delete location.";

            showToast(message, false);
        }
        catch (Exception ex)
        {
            string safeMessage =
                HttpUtility.JavaScriptStringEncode(ex.Message);

            showToast(safeMessage, false);
        }
    }

    private void ClearLocationForm()
    {
        hfLocationID.Value = "";

        if (ddlState.Items.Count > 0)
            ddlState.SelectedIndex = 0;

        ddlDistrict.Items.Clear();
        ddlDistrict.Items.Add(
            new ListItem("-- Select District --", ""));

        txtTehsil.Text = "";
        txtBlock.Text = "";
        txtPIN.Text = "";

        txtVillageMohalla1.Text = "";
        txtVillageMohalla2.Text = "";
        txtVillageMohalla3.Text = "";
        txtVillageMohalla4.Text = "";
        txtVillageMohalla5.Text = "";
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
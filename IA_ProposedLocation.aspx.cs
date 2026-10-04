using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class IA_ProposedLocation : System.Web.UI.Page
{
    int reg_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        reg_id = ((MasterCHAR)this.Master).Get_RegId();
        if (!IsPostBack)
        {
            LoadLocation();
            ((MasterCHAR)this.Master).SetActiveStep(5);
        }
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

    }

    protected void btnSaveLocation_Click(object sender, EventArgs e)
    {
       

        Dictionary<string, object> prms =
            new Dictionary<string, object>();

        prms.Add("@LocationID",
            string.IsNullOrEmpty(hfLocationID.Value)
            ? 0
            : Convert.ToInt32(hfLocationID.Value));

        prms.Add("@Reg_Id", reg_id);

        prms.Add("@LocationName", txtLocationName.Text);
        prms.Add("@FullAddress", txtAddress.Text);

        prms.Add("@Block", txtBlock.Text);
        prms.Add("@Tehsil", txtTehsil.Text);

        prms.Add("@State", ddlState.SelectedValue);
        prms.Add("@District", ddlDistrict.SelectedValue);

        prms.Add("@PIN_Code", txtPIN.Text);


        DataTable dt =
         DatabaseHelper.GET_DataTable("usp_Upsert_IA_ProposedLocation", prms);


        LoadLocation();


        ScriptManager.RegisterStartupScript(
            this, GetType(),
            "close",
            "$('#locationModal').modal('hide');",
            true);
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
}
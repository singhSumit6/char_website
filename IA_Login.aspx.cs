using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class IA_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Dictionary<string, object> prms = new Dictionary<string, object>();

        prms.Add("@UserId", txtUser.Text.Trim());
        prms.Add("@Password", txtPassword.Text.Trim());

        DataTable dt = DatabaseHelper.GET_DataTable("sp_CAHR_Login", prms);

        if (dt != null && dt.Rows.Count > 0)
        {
            DataRow dr = dt.Rows[0];

            if (dr["Status"].ToString() == "1")
            {
                // Create Cookie
                HttpCookie cookie = new HttpCookie("Reg_Id", dr["UserId"].ToString());
                cookie.Expires = DateTime.Now.AddDays(1); // Optional

                // Add Cookie
                Response.Cookies.Add(cookie);

                // Redirect
                Response.Redirect("IA_Basics.aspx");
            }
            else
            {
                lblMsg.Text = dr["Message"].ToString();
            }
        }
        else
        {
            lblMsg.Text = "Login failed. Please try again.";
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class sms : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btn_sendsms_Click(object sender, EventArgs e)
    {
        string temp_ID = "1707177798051989251";
        string msg = "Your OTP for registration with COUNCIL FOR ADVANCEMENT OF HEALTH & RESEARCH is {#var#}. It is valid for {#var#} minutes. Do not share this OTP with anyone.";
       Response.Write(Send_SMS.send_dlt_msg(msg, "9170392853", temp_ID));
    }
}
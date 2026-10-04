using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;

/// <summary>
/// Summary description for Send_SMS
/// </summary>
public class Send_SMS
{
     

    public static string send_dlt_msg(String msg, String Mobile, String Temp_Id)
    {
        string strUrl = "";         
        GeneralClass general = new GeneralClass();
        string responce = "";
        string username = "abhinavsrivastwa@1";
        string sendername = "CFAOHR";
        string smstype = "TRANS";
        string apikey = "1acfe62c-407a-4b35-b331-ec8724661716";
        string peid = "1701177745860784484";
        string encodedMessage = Uri.EscapeDataString(msg);
        strUrl =
           "http://sms.messageindia.in/v2/sendSMS?" +
           "username=" + username +
           "&message=" + encodedMessage +
           "&sendername=" + sendername +
           "&smstype=" + smstype +
           "&numbers=" + Mobile +
           "&apikey=" + apikey +
           "&peid=" + peid +
           "&templateid=" + Temp_Id;
         
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(strUrl);
        request.Method = "POST";
        request.Accept = "application/json";
        request.ContentType = "application/x-www-form-urlencoded";

        try
        {
            using (HttpWebResponse response =
                   (HttpWebResponse)request.GetResponse())
            using (StreamReader reader =
                   new StreamReader(response.GetResponseStream()))
            {
                responce = reader.ReadToEnd();
            }
        }
        catch (WebException ex)
        {
            using (var reader =
                   new StreamReader(ex.Response.GetResponseStream()))
            {
                string error = reader.ReadToEnd();
                throw new Exception(error); // shows real issue
            }
        }
        return responce;
    }
}
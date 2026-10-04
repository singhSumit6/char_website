using iTextSharp.text;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.UI.WebControls;


public class GeneralClass
{
    String query, pr, msg;
    public SqlConnection cn;
    SqlCommand cmd;
    SqlDataReader dr;
    Special_Class spcl;
    DataTable qua_dt;
    
    public struct SessionData
    {
        public String UserId;
        public String UserName;
        public String UserRole;
        public String Status;
        public String MobileNo;
        public int School_Code;
        public String AY;
        public int Session_Id;
    }

    [Serializable]
    public class pdf_data
    {
        public DataTable dt;
        public DataSet ds;
           
        public string Title;
        public Rectangle PageSize;
        public int FontSize;
        public int FooterColspan;
        public string CalcColumns;
        public int Clg_Id;
    }


    public String Connect()
    {
        try
        {
            pr = "" + System.Configuration.ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;

            cn = new System.Data.SqlClient.SqlConnection(pr);
            cn.Open();
            return "Connection Successful";
        }
        catch (Exception e)
        {
            return "Server Not Found !!!!! Contact: Db Amin for Assistance" + e;
        }
    }
    public void closeConnection()
    {
        cn.Close();
    }     
    public string Encrypt(string clearText)
    {
        string EncryptionKey = "SAINATH27111986";
        byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(clearBytes, 0, clearBytes.Length);
                    cs.Close();
                }
                clearText = Convert.ToBase64String(ms.ToArray());
            }
        }
        return clearText;
    }
    public string Decrypt(string cipherText)
    {
        string EncryptionKey = "SAINATH27111986";
        cipherText = cipherText.Replace(" ", "+");
        byte[] cipherBytes = Convert.FromBase64String(cipherText);
        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(cipherBytes, 0, cipherBytes.Length);
                    cs.Close();
                }
                cipherText = Encoding.Unicode.GetString(ms.ToArray());
            }
        }
        return cipherText;
    }         
    public string RandumNumber(int lenght)
    {
        String pass = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        var stringChars = new char[lenght];
        Random r = new Random();
        for (int i = 0; i < stringChars.Length; i++)
        {
            stringChars[i] = pass[r.Next(pass.Length)];
        }
        return new String(stringChars);
    }

    internal static readonly char[] chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890".ToCharArray();
    public string GetUniqueKey(int size)
    {
        byte[] data = new byte[4 * size];
        using (var crypto = RandomNumberGenerator.Create())
        {
            crypto.GetBytes(data);
        }
        StringBuilder result = new StringBuilder(size);
        for (int i = 0; i < size; i++)
        {
            var rnd = BitConverter.ToUInt32(data, i * 4);
            var idx = rnd % chars.Length;

            result.Append(chars[idx]);
        }

        return result.ToString();
    }
    public static string GetUniqueKeyOriginal_BIASED(int size)
    {
        char[] chars =
            "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890".ToCharArray();
        byte[] data = new byte[size];
        using (RNGCryptoServiceProvider crypto = new RNGCryptoServiceProvider())
        {
            crypto.GetBytes(data);
        }
        StringBuilder result = new StringBuilder(size);
        foreach (byte b in data)
        {
            result.Append(chars[b % (chars.Length)]);
        }
        return result.ToString();
    }       
    
     
    public void Delete(string query)
    {
        this.Connect();
        SqlCommand cmd = new SqlCommand(query, cn);
        cmd.ExecuteNonQuery();
        this.closeConnection();
    }
    public static void SetDropdownValue(DropDownList dropdown, string value)
    {
        if (dropdown.Items.FindByValue(value) != null)
        {
            dropdown.SelectedValue = value;
        }
    }
    public static void SetRadioButtonListValue(RadioButtonList rbl_id, string value)
    {
        if (rbl_id.Items.FindByValue(value) != null)
        {
            rbl_id.SelectedValue = value;
        }
    }
}




using System;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for Special_Class
/// </summary>
public class Special_Class
{
    public SqlConnection cn;
    SqlCommand cmd;
    SqlDataReader dr;
    String query;
    GeneralClass obj;
    public Special_Class()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    //////////////////////////
    public DataTable GetData(string query)
    {
        cmd = new SqlCommand(query);
        GeneralClass obj = new GeneralClass(); obj.Connect();
        using (SqlConnection con = obj.cn)
        {
            using (SqlDataAdapter sda = new SqlDataAdapter())
            {
                cmd.Connection = con;

                sda.SelectCommand = cmd;
                using (DataTable dt = new DataTable())
                {
                    sda.Fill(dt);
                    return dt;
                }
            }
        }
    }
}
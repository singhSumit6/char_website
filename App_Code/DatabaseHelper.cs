using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public static class DatabaseHelper
{
    private static readonly string pr = WebConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;

     


    public static DataTable GET_DataTable(string sp_name, Dictionary<string, object> parameters)
    {
        DataTable dt = new DataTable();
        try
        {
            using (SqlConnection con = new SqlConnection(pr))
            {
                using (SqlCommand cmd = new SqlCommand(sp_name, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (parameters != null)
                    {
                        foreach (var param in parameters)
                        {
                            cmd.Parameters.AddWithValue(param.Key, param.Value ?? DBNull.Value);
                        }
                    }

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                        da.Dispose();
                    }
                }
            }
             
        }
        catch (Exception ex)
        {
            // Ensure dt has the expected columns
            dt.Columns.Add("Status", typeof(int));
            dt.Columns.Add("Message", typeof(string));

            // Add an error row
            DataRow dr = dt.NewRow();
            dr["Status"] = 0; // Indicating failure
            dr["Message"] = ex.Message;
            dt.Rows.Add(dr);
        }

        return dt;

    }
    public static DataTable GET_DataTable(string spName, string ParemeterName, string ParemeterValue)
    {
        DataTable dt = new DataTable();
        try
        {
            using (SqlConnection con = new SqlConnection(pr))
            {
                using (SqlCommand cmd = new SqlCommand(spName, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    // Add the parameter properly
                    cmd.Parameters.AddWithValue(ParemeterName, ParemeterValue);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Logging can be added here
            return GenerateErrorDataTable(ex.Message);
        }

        return dt;
    }

    public static DataSet GET_DataSet(string spName, Dictionary<string, object> parameters)
    {
        DataSet ds = new DataSet();

        try
        {
            using (SqlConnection con = new SqlConnection(pr))
            {
                using (SqlCommand cmd = new SqlCommand(spName, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (parameters != null)
                    {
                        foreach (var param in parameters)
                        {
                            cmd.Parameters.AddWithValue(param.Key, param.Value ?? DBNull.Value);
                        }
                    }

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(ds);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ds.Tables.Add(GenerateErrorDataTable(ex.Message));
        }

        return ds;
    }

    public static DataSet GET_DataSet(string spName, string parameterName, string parameterValue)
    {
        DataSet ds = new DataSet();
        try
        {
            using (SqlConnection con = new SqlConnection(pr))
            {
                using (SqlCommand cmd = new SqlCommand(spName, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue(parameterName, parameterValue);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(ds);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ds.Tables.Add(GenerateErrorDataTable(ex.Message));
        }

        return ds;
    }    

    private static DataTable GenerateErrorDataTable(string errorMessage)
    {
        DataTable dtError = new DataTable("Error");
        dtError.Columns.Add("Status", typeof(int));
        dtError.Columns.Add("Message", typeof(string));

        DataRow dr = dtError.NewRow();
        dr["Status"] = 0;
        dr["Message"] = errorMessage;
        dtError.Rows.Add(dr);

        return dtError;
    }

    public static List<string> StateList()
    {
        return new List<string>
    {
        "Andhra Pradesh",
        "Arunachal Pradesh",
        "Assam",
        "Bihar",
        "Chhattisgarh",
        "Goa",
        "Gujarat",
        "Haryana",
        "Himachal Pradesh",
        "Jharkhand",
        "Karnataka",
        "Kerala",
        "Madhya Pradesh",
        "Maharashtra",
        "Manipur",
        "Meghalaya",
        "Mizoram",
        "Nagaland",
        "Odisha",
        "Punjab",
        "Rajasthan",
        "Sikkim",
        "Tamil Nadu",
        "Telangana",
        "Tripura",
        "Uttar Pradesh",
        "Uttarakhand",
        "West Bengal"
    };
    }

}

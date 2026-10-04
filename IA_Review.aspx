<%@ Page Title="" Language="C#" MasterPageFile="~/MasterCHAR.master" AutoEventWireup="true" CodeFile="IA_Review.aspx.cs" Inherits="IA_Review" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
   <div id="printArea">

<% if (PreviewData != null) { %>

<div class="container bg-white p-4 shadow rounded">

    <!-- HEADER -->
    <div class="text-center mb-4 border-bottom pb-3">

        <h3 class="text-primary fw-bold">
            CAHR Application Review
        </h3>

        <span class="badge bg-success fs-6">
            Reg Code :
            <%= PreviewData.Registration.Reg_Code %>
        </span>

    </div>


    <!-- ================= ORGANIZATION ================= -->

    <div class="card mb-4">

        <div class="card-header bg-primary text-white fw-bold">
            Organization Information
        </div>

        <table class="table table-bordered mb-0">

            <tr>
                <th>Name</th>
                <td><%= PreviewData.Registration.OrgName %></td>

                <th>PAN</th>
                <td><%= PreviewData.Registration.PAN %></td>
            </tr>

            <tr>
                <th>Phone</th>
                <td><%= PreviewData.Registration.Phone %></td>

                <th>Email</th>
                <td><%= PreviewData.Registration.Email %></td>
            </tr>

            <tr>
                <th>Website</th>
                <td><%= PreviewData.Registration.Website %></td>

                <th>Status</th>
                <td>
                    <span class="badge bg-info">
                        <%= PreviewData.Registration.Reg_Status %>
                    </span>
                </td>
            </tr>

        </table>

    </div>


    <!-- ================= AUTHORIZED PERSON ================= -->

    <div class="card mb-4">

        <div class="card-header bg-dark text-white fw-bold">
            Authorized Person
        </div>

        <table class="table table-bordered mb-0">

            <tr>
                <th>Name</th>
                <td><%= PreviewData.Registration.AuthName %></td>

                <th>Designation</th>
                <td><%= PreviewData.Registration.AuthDesig %></td>
            </tr>

            <tr>
                <th>Mobile</th>
                <td><%= PreviewData.Registration.AuthMobile %></td>

                <th>Email</th>
                <td><%= PreviewData.Registration.AuthEmail %></td>
            </tr>

        </table>

    </div>


    <!-- ================= REGISTERED ADDRESS ================= -->

    <div class="card mb-4">

        <div class="card-header bg-secondary text-white fw-bold">
            Registered Address
        </div>

        <table class="table table-bordered mb-0">

            <tr>
                <th>Address</th>
                <td colspan="3">
                    <%= PreviewData.Registration.Address %>,
                    <%= PreviewData.Registration.District %>,
                    <%= PreviewData.Registration.State %>
                    - <%= PreviewData.Registration.PIN_Code %>
                </td>
            </tr>

        </table>

    </div>


    <!-- ================= BASIC DETAILS ================= -->

    <div class="card mb-4">

        <div class="card-header bg-secondary text-white fw-bold">
            Registration & Legal Details
        </div>

        <table class="table table-bordered mb-0">

            <tr>
                <th>Org Type</th>
                <td><%= PreviewData.BasicDetail.OrgType %></td>

                <th>Act</th>
                <td><%= PreviewData.BasicDetail.ActRegistered %></td>
            </tr>

            <tr>
                <th>Reg. No</th>
                <td><%= PreviewData.BasicDetail.RegistrationNumber %></td>

                <th>Reg. Date</th>
                <td><%= PreviewData.BasicDetail.RegistrationDate %></td>
            </tr>

            <tr>
                <th>TAN</th>
                <td colspan="3"><%= PreviewData.BasicDetail.TAN %></td>
            </tr>

        </table>

    </div>


    <!-- ================= COMMUNICATION ADDRESS ================= -->

    <div class="card mb-4">

        <div class="card-header bg-secondary text-white fw-bold">
            Communication Address
        </div>

        <table class="table table-bordered mb-0">

            <tr>
                <th>Address</th>
                <td colspan="3">
                    <%= PreviewData.BasicDetail.CommAddress %>,
                    <%= PreviewData.BasicDetail.CommDistrict %>,
                    <%= PreviewData.BasicDetail.CommState %>
                    - <%= PreviewData.BasicDetail.CommPIN %>
                </td>
            </tr>

        </table>

    </div>


    <!-- ================= MEMBERS ================= -->

    <div class="card mb-4">

        <div class="card-header bg-info text-white fw-bold">
            Members
        </div>

        <table class="table table-bordered mb-0">

            <tr class="bg-light fw-bold text-center">
                <td>Name</td>
                <td>Designation</td>
                <td>Email</td>
                <td>Phone</td>
            </tr>

            <% foreach (var m in PreviewData.Members) { %>

            <tr>
                <td><%= m.Name %></td>
                <td><%= m.Designation %></td>
                <td><%= m.Email %></td>
                <td><%= m.Phone %></td>
            </tr>

            <% } %>

        </table>

    </div>


    <!-- ================= FINANCIAL ================= -->

    <div class="card mb-4">

        <div class="card-header bg-success text-white fw-bold">
            Financial Summary
        </div>

        <table class="table table-bordered mb-0">

            <tr class="bg-light fw-bold text-center">
                <td>Year</td>
                <td>Turnover</td>
                <td>Net Worth</td>
                <td>ITR</td>
            </tr>

            <% foreach (var f in PreviewData.Financials) { %>

            <tr>
                <td><%= f.FinancialYear %></td>
                <td><%= f.Turnover %></td>
                <td><%= f.NetWorth %></td>
                <td><%= f.ITR %></td>
            </tr>

            <% } %>

        </table>

    </div>


    <!-- ================= PROJECT EXPERIENCE ================= -->

    <div class="card mb-4">

        <div class="card-header bg-warning fw-bold">
            Project Experience
        </div>

        <table class="table table-bordered mb-0">

            <tr class="bg-light fw-bold text-center">
                <td>Year</td>
                <td>Project</td>
                <td>Agency</td>
                <td>Status</td>
                <td>Amount</td>
            </tr>

            <% foreach (var p in PreviewData.Projects) { %>

            <tr>
                <td><%= p.FinancialYear %></td>
                <td><%= p.ProjectName %></td>
                <td><%= p.AgencyType %></td>
                <td><%= p.ProjectStatus %></td>
                <td><%= p.SanctionAmount %></td>
            </tr>

            <% } %>

        </table>

    </div>

</div>

<% } %>

</div>
</asp:Content>


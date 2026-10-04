<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="IA_Registration.aspx.cs" Inherits="IA_Registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class=" bg-body-secondary" style="padding: 150px 0 60px;">
        <div class="container">
            <div class="card shadow">

                <div class="card-header bg-primary text-white text-center">
                    <h4>Implementing Agency (IA) Registration</h4>
                </div>

                <div class="container-fluid">

                    <!-- ================= BASIC INFO ================= -->
                    <div class="card mb-4 shadow-sm mt-2">

                        <div class="card-header bg-light">
                            <h6 class="mb-0 text-primary">
                                <i class="fa fa-building"></i>Organization Details
                            </h6>
                        </div>

                        <div class="card-body">

                            <div class="row">

                                <div class="col-md-12 mb-3">
                                    <label class="font-weight-bold">Organization Name</label>
                                    <asp:TextBox ID="txtOrgName" runat="server"
                                        CssClass="form-control form-control-lg" />
                                </div>

                                <div class="col-md-3 mb-3">
                                    <label>Mobile</label>
                                    <asp:TextBox ID="txtMobile" runat="server"
                                        CssClass="form-control" />
                                </div>

                                <div class="col-md-3 mb-3">
                                    <label>Email</label>
                                    <asp:TextBox ID="txtEmail" runat="server"
                                        TextMode="Email"
                                        CssClass="form-control" />
                                </div>

                                <div class="col-md-3 mb-3">
                                    <label>PAN No</label>
                                    <asp:TextBox ID="txtPAN" runat="server"
                                        CssClass="form-control" />
                                </div>

                                <div class="col-md-3 mb-3">
                                    <label>Website</label>
                                    <asp:TextBox ID="txtWebsite" runat="server"
                                        CssClass="form-control" />
                                </div>

                            </div>

                        </div>
                    </div>





                    <!-- ================= ADDRESS ================= -->
                    <div class="card mb-4 shadow-sm">

                        <div class="card-header bg-light">
                            <h6 class="mb-0 text-primary">
                                <i class="fa fa-map-marker-alt"></i>Registered Address
                            </h6>
                        </div>

                        <div class="card-body">

                            <div class="row">

                                <div class="col-md-12 mb-3">
                                    <label>Full Address</label>
                                    <asp:TextBox ID="txtAddress" runat="server"
                                        TextMode="MultiLine"
                                        Rows="2"
                                        CssClass="form-control" />
                                </div>

                                <div class="col-md-4 mb-3">
                                    <label>State</label>
                                    <asp:DropDownList ID="ddlState" runat="server"
                                        CssClass="form-control" />
                                </div>

                                <div class="col-md-4 mb-3">
                                    <label>District</label>
                                    <asp:TextBox ID="txtDistrict" runat="server"
                                        CssClass="form-control" />
                                </div>

                                <div class="col-md-4 mb-3">
                                    <label>PIN Code</label>
                                    <asp:TextBox ID="txtPin" runat="server"
                                        CssClass="form-control" />
                                </div>

                            </div>

                        </div>
                    </div>


                    <!-- ================= AUTHORIZED PERSON ================= -->
                    <div class="card mb-4 shadow-sm">

                        <div class="card-header bg-light">
                            <h6 class="mb-0 text-primary">
                                <i class="fa fa-user-tie"></i>Authorized Signatory
                            </h6>
                        </div>

                        <div class="card-body">

                            <div class="row">

                                <div class="col-md-3 mb-3">
                                    <label>Name</label>
                                    <asp:TextBox ID="txtAuthName" runat="server"
                                        CssClass="form-control" />
                                </div>

                                <div class="col-md-3 mb-3">
                                    <label>Designation</label>
                                    <asp:TextBox ID="txtAuthDesig" runat="server"
                                        CssClass="form-control" />
                                </div>

                                <div class="col-md-3 mb-3">
                                    <label>Mobile</label>
                                    <asp:TextBox ID="txtAuthMobile" runat="server"
                                        CssClass="form-control" />
                                </div>

                                <div class="col-md-3 mb-3">
                                    <label>Email</label>
                                    <asp:TextBox ID="txtAuthEmail" runat="server"
                                        TextMode="Email"
                                        CssClass="form-control" />
                                </div>

                            </div>

                        </div>
                    </div>




                    <!-- ================= SUBMIT ================= -->
                    <div class="text-center mt-4 mb-4">

                        <asp:Button ID="btnSubmit" runat="server"
                            Text="Submit Registration"
                            CssClass="btn btn-primary btn-lg px-5"
                            OnClick="btnSubmit_Click" />

                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>


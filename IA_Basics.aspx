<%@ Page Title="" Language="C#" MasterPageFile="~/MasterCHAR.master" AutoEventWireup="true" CodeFile="IA_Basics.aspx.cs" Inherits="IA_Basics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
  
    <div class="card shadow-sm mb-4">
        <asp:HiddenField ID="hfBasicId" runat="server" />
        <div class="card-header bg-light">
            <h5 class="mb-0 text-primary">
                <i class="fa fa-building"></i>Organization Details
            </h5>
        </div>

        <div class="card-body">
            <div class="row">

                <div class="col-md-12 mb-3">
                    <label class="mb-1">Organization Name</label>
                    <asp:TextBox ID="txtOrgName" runat="server"
                        CssClass="form-control form-control-lg" />
                </div>

                <div class="col-md-4 mb-3">
                    <label class="mb-1">Organization Type</label>
                    <asp:DropDownList ID="ddlOrgType" runat="server"
                        CssClass="form-control">
                        <asp:ListItem Value="">-- Select --</asp:ListItem>
                        <asp:ListItem>NGO</asp:ListItem>
                        <asp:ListItem>Trust</asp:ListItem>
                        <asp:ListItem>Society</asp:ListItem>
                        <asp:ListItem>Section 8 Company</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-md-4 mb-3">
                    <label class="mb-1">Act Registered Under</label>
                    <asp:TextBox ID="txtActRegistered" runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                    <label class="mb-1">Registration Number</label>
                    <asp:TextBox ID="txtRegNo" runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                    <label class="mb-1">Registration Date</label>
                    <asp:TextBox ID="txtRegDate" runat="server"
                        TextMode="Date"
                        CssClass="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                    <label class="mb-1">PAN</label>
                    <asp:TextBox ID="txtPAN" runat="server"
                        CssClass="form-control"
                        MaxLength="10" />
                </div>

                <div class="col-md-4 mb-3">
                    <label class="mb-1">TAN</label>
                    <asp:TextBox ID="txtTAN" runat="server"
                        CssClass="form-control" />
                </div>

            </div>
        </div>
    </div>

    <div class="card shadow-sm mb-4">
        <div class="card-header bg-light">
            <h5 class="mb-0 text-primary">
                <i class="fa fa-map-marker-alt"></i>Registered Address
            </h5>
        </div>

        <div class="card-body">
            <div class="row">

                <div class="col-md-12 mb-3">
                    <label class="mb-1">Full Address</label>
                    <asp:TextBox ID="txtRegAddress" runat="server"
                        TextMode="MultiLine" Rows="2"
                        CssClass="form-control" />
                </div>

                <div class="col-md-3 mb-3">
                    <label class="mb-1">State</label>
                    <asp:DropDownList ID="ddlRegState" runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-3 mb-3">
                    <label class="mb-1">District</label>
                    <asp:TextBox ID="txtRegDistrict" runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-3 mb-3">
                    <label class="mb-1">Tehsil</label>
                    <asp:TextBox ID="txtRegTehsil" runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-3 mb-3">
                    <label class="mb-1">PIN</label>
                    <asp:TextBox ID="txtRegPIN" runat="server"
                        CssClass="form-control"
                        MaxLength="6" />
                </div>

            </div>
        </div>
    </div>

    <div class="card shadow-sm mb-4">
        <div class="card-header bg-light d-flex justify-content-between">
            <h5 class="mb-0 text-primary">
                <i class="fa fa-home"></i>Communication Address
            </h5>

            <asp:CheckBox ID="chkSameAddress" runat="server"
                Text=" Same as Registered"
                AutoPostBack="true"
                OnCheckedChanged="chkSameAddress_CheckedChanged" />
        </div>

        <div class="card-body">
            <div class="row">

                <div class="col-md-12 mb-3">
                    <label class="mb-1">Full Address</label>
                    <asp:TextBox ID="txtCommAddress" runat="server"
                        TextMode="MultiLine" Rows="2"
                        CssClass="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                    <label class="mb-1">State</label>
                    <asp:DropDownList ID="ddlCommState" runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                    <label class="mb-1">District</label>
                    <asp:TextBox ID="txtCommDistrict" runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                    <label class="mb-1">PIN</label>
                    <asp:TextBox ID="txtCommPIN" runat="server"
                        CssClass="form-control" />
                </div>

            </div>
        </div>
    </div>

    <div class="card shadow-sm mb-4">
        <div class="card-header bg-light">
            <h5 class="mb-0 text-primary">
                <i class="fa fa-phone"></i>Contact Details
            </h5>
        </div>

        <div class="card-body">
            <div class="row">

                <div class="col-md-4 mb-3">
                    <label class="mb-1">Organization Mobile</label>
                    <asp:TextBox ID="txtOrgMobile" runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                    <label class="mb-1">Organization Email</label>
                    <asp:TextBox ID="txtOrgEmail" runat="server"
                        TextMode="Email"
                        CssClass="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                    <label class="mb-1">Website</label>
                    <asp:TextBox ID="txtWebsite" runat="server"
                        CssClass="form-control" />
                </div>

            </div>
        </div>
    </div>

    <div class="card shadow-sm mb-4">
        <div class="card-header bg-light">
            <h5 class="mb-0 text-primary">
                <i class="fa fa-user-tie"></i>Authorized Signatory
            </h5>
        </div>

        <div class="card-body">
            <div class="row">

                <div class="col-md-3 mb-3">
                    <label class="mb-1">Name</label>
                    <asp:TextBox ID="txtAuthName" runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-3 mb-3">
                    <label class="mb-1">Designation</label>
                    <asp:TextBox ID="txtAuthDesig" runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-3 mb-3">
                    <label class="mb-1">Mobile</label>
                    <asp:TextBox ID="txtAuthMobile" runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-3 mb-3">
                    <label class="mb-1">Email</label>
                    <asp:TextBox ID="txtAuthEmail" runat="server"
                        TextMode="Email"
                        CssClass="form-control" />
                </div>

            </div>
        </div>
    </div>

    <div class="card shadow-sm mb-4">
        <div class="card-header bg-light">
            <h5 class="mb-0 text-primary">
                <i class="fa fa-file-upload"></i>Upload Documents
            </h5>
        </div>

        <div class="card-body">
            <div class="row">

                <div class="col-md-4 mb-3">
                    <label class="mb-1">Registration Certificate</label>
                    <asp:FileUpload ID="fuRC" runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                    <label class="mb-1">MOA / Trust Deed</label>
                    <asp:FileUpload ID="fuMOA" runat="server"
                        CssClass="form-control" />
                </div>

                <div class="col-md-4 mb-3">
                    <label class="mb-1">PAN Card</label>
                    <asp:FileUpload ID="fuPAN" runat="server"
                        CssClass="form-control" />
                </div>

            </div>
        </div>
    </div>

    <asp:Label ID="lblMsg" runat="server" />
    <asp:Button ID="btn_save" runat="server" OnClick="btnSave_Click" Text="Save" />

</asp:Content>


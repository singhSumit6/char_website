<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="IA_Registration.aspx.cs" Inherits="IA_Registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
          .field-label {
            font-weight: 600;
            margin-bottom: 7px;
        }

        .required-star {
            color: #dc3545;
        }

        .field-error {
            color: #dc3545;
            font-size: 12px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="bg-body-secondary" style="padding: 150px 0 60px;">


        <div class="row">
          
            <div class="col-md-6 offset-md-3 ">
                <div class="card shadow">

                    <div class="card-header bg-primary text-white text-center">
                        <h4 class="mb-1">Implementing IP Registration</h4>
                        <small>Register as NGO or CSC</small>
                    </div>

                    <div class="card-body">

                        <div class="form-group mb-4">
                            <label class="field-label">
                                Registration Type
                 <span class="required-star">*</span>
                            </label>

                            <asp:RadioButtonList ID="rblRegistrationType"
                                runat="server"
                                RepeatDirection="Horizontal"
                                RepeatLayout="Flow"
                                CssClass="registration-types"
                                AutoPostBack="true"
                                OnSelectedIndexChanged="rblRegistrationType_SelectedIndexChanged">

                                <asp:ListItem Text=" NGO" Value="NGO"
                                    Selected="True" />
                                <asp:ListItem Text=" CSC" Value="CSC" />

                            </asp:RadioButtonList>
                        </div>

                        <asp:Panel ID="pnlNGO" runat="server">

                            <h5 class="text-primary mb-3">
                                <i class="fa fa-building"></i>
                                NGO Registration Details
                            </h5>

                            <div class="form-group mb-3">
                                <label class="field-label">
                                    Organization Name <span class="required-star">*</span>
                                </label>

                                <asp:TextBox ID="txtOrgName" runat="server"
                                    CssClass="form-control"
                                    MaxLength="200"
                                    placeholder="Enter organization name" />

                                <asp:RequiredFieldValidator
                                    ID="rfvOrgName" runat="server"
                                    ControlToValidate="txtOrgName"
                                    ErrorMessage="Organization name is required."
                                    CssClass="field-error"
                                    Display="Dynamic"
                                    ValidationGroup="NGOGroup" />
                            </div>

                            <div class="form-group mb-3">
                                <label class="field-label">
                                    Mobile Number <span class="required-star">*</span>
                                </label>

                                <asp:TextBox ID="txtMobile" runat="server"
                                    CssClass="form-control"
                                    MaxLength="10"
                                    TextMode="Phone"
                                    placeholder="Enter 10-digit mobile number" />

                                <asp:RequiredFieldValidator
                                    ID="rfvMobile" runat="server"
                                    ControlToValidate="txtMobile"
                                    ErrorMessage="Mobile number is required."
                                    CssClass="field-error"
                                    Display="Dynamic"
                                    ValidationGroup="NGOGroup" />

                                <asp:RegularExpressionValidator
                                    ID="revMobile" runat="server"
                                    ControlToValidate="txtMobile"
                                    ValidationExpression="^[6-9][0-9]{9}$"
                                    ErrorMessage="Enter a valid 10-digit mobile number."
                                    CssClass="field-error"
                                    Display="Dynamic"
                                    ValidationGroup="NGOGroup" />
                            </div>

                            <div class="form-group mb-3">
                                <label class="field-label">
                                    Email <span class="required-star">*</span>
                                </label>

                                <asp:TextBox ID="txtEmail" runat="server"
                                    CssClass="form-control"
                                    TextMode="Email"
                                    MaxLength="254"
                                    placeholder="Enter email address" />

                                <asp:RequiredFieldValidator
                                    ID="rfvEmail" runat="server"
                                    ControlToValidate="txtEmail"
                                    ErrorMessage="Email is required."
                                    CssClass="field-error"
                                    Display="Dynamic"
                                    ValidationGroup="NGOGroup" />

                                <asp:RegularExpressionValidator
                                    ID="revEmail" runat="server"
                                    ControlToValidate="txtEmail"
                                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                                    ErrorMessage="Enter a valid email address."
                                    CssClass="field-error"
                                    Display="Dynamic"
                                    ValidationGroup="NGOGroup" />
                            </div>

                            <div class="form-group mb-3">
                                <label class="field-label">
                                    Organization PAN Number
                     <span class="required-star">*</span>
                                </label>

                                <asp:TextBox ID="txtPAN" runat="server"
                                    CssClass="form-control"
                                    MaxLength="10"
                                    placeholder="Enter organization PAN" />

                                <asp:RequiredFieldValidator
                                    ID="rfvPAN" runat="server"
                                    ControlToValidate="txtPAN"
                                    ErrorMessage="Organization PAN is required."
                                    CssClass="field-error"
                                    Display="Dynamic"
                                    ValidationGroup="NGOGroup" />

                                <asp:RegularExpressionValidator
                                    ID="revPAN" runat="server"
                                    ControlToValidate="txtPAN"
                                    ValidationExpression="^[A-Za-z]{5}[0-9]{4}[A-Za-z]$"
                                    ErrorMessage="Enter a valid PAN number."
                                    CssClass="field-error"
                                    Display="Dynamic"
                                    ValidationGroup="NGOGroup" />
                            </div>

                        </asp:Panel>

                        <asp:Panel ID="pnlCSC" runat="server" Visible="false">

                            <h5 class="text-primary mb-3">
                                <i class="fa fa-id-card"></i>
                                CSC Registration Details
                            </h5>

                            <div class="form-group mb-3">
                                <label class="field-label">
                                    CSC Holder Name
                     <span class="required-star">*</span>
                                </label>

                                <asp:TextBox ID="txtCSCHolderName" runat="server"
                                    CssClass="form-control"
                                    MaxLength="200"
                                    placeholder="Enter CSC holder name" />

                                <asp:RequiredFieldValidator
                                    ID="rfvCSCHolderName" runat="server"
                                    ControlToValidate="txtCSCHolderName"
                                    ErrorMessage="CSC holder name is required."
                                    CssClass="field-error"
                                    Display="Dynamic"
                                    ValidationGroup="CSCGroup" />
                            </div>

                            <div class="form-group mb-3">
                                <label class="field-label">
                                    Mobile Number <span class="required-star">*</span>
                                </label>

                                <asp:TextBox ID="txtCSCMobile" runat="server"
                                    CssClass="form-control"
                                    MaxLength="10"
                                    TextMode="Phone"
                                    placeholder="Enter 10-digit mobile number" />

                                <asp:RequiredFieldValidator
                                    ID="rfvCSCMobile" runat="server"
                                    ControlToValidate="txtCSCMobile"
                                    ErrorMessage="Mobile number is required."
                                    CssClass="field-error"
                                    Display="Dynamic"
                                    ValidationGroup="CSCGroup" />

                                <asp:RegularExpressionValidator
                                    ID="revCSCMobile" runat="server"
                                    ControlToValidate="txtCSCMobile"
                                    ValidationExpression="^[6-9][0-9]{9}$"
                                    ErrorMessage="Enter a valid 10-digit mobile number."
                                    CssClass="field-error"
                                    Display="Dynamic"
                                    ValidationGroup="CSCGroup" />
                            </div>

                            <div class="form-group mb-3">
                                <label class="field-label">
                                    Email <span class="required-star">*</span>
                                </label>

                                <asp:TextBox ID="txtCSCEmail" runat="server"
                                    CssClass="form-control"
                                    TextMode="Email"
                                    MaxLength="254"
                                    placeholder="Enter email address" />

                                <asp:RequiredFieldValidator
                                    ID="rfvCSCEmail" runat="server"
                                    ControlToValidate="txtCSCEmail"
                                    ErrorMessage="Email is required."
                                    CssClass="field-error"
                                    Display="Dynamic"
                                    ValidationGroup="CSCGroup" />

                                <asp:RegularExpressionValidator
                                    ID="revCSCEmail" runat="server"
                                    ControlToValidate="txtCSCEmail"
                                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                                    ErrorMessage="Enter a valid email address."
                                    CssClass="field-error"
                                    Display="Dynamic"
                                    ValidationGroup="CSCGroup" />
                            </div>

                            <div class="form-group mb-3">
                                <label class="field-label">
                                    Aadhaar Number <span class="required-star">*</span>
                                </label>

                                <asp:TextBox ID="txtAadhaar" runat="server"
                                    CssClass="form-control"
                                    MaxLength="12"
                                    TextMode="Password"
                                    placeholder="Enter 12-digit Aadhaar number" />

                                <asp:RequiredFieldValidator
                                    ID="rfvAadhaar" runat="server"
                                    ControlToValidate="txtAadhaar"
                                    ErrorMessage="Aadhaar number is required."
                                    CssClass="field-error"
                                    Display="Dynamic"
                                    ValidationGroup="CSCGroup" />

                                <asp:RegularExpressionValidator
                                    ID="revAadhaar" runat="server"
                                    ControlToValidate="txtAadhaar"
                                    ValidationExpression="^[0-9]{12}$"
                                    ErrorMessage="Aadhaar must contain 12 digits."
                                    CssClass="field-error"
                                    Display="Dynamic"
                                    ValidationGroup="CSCGroup" />
                            </div>

                        </asp:Panel>

                        <asp:Label ID="lblMessage" runat="server"
                            EnableViewState="false" />

                        <div class="text-center mt-4">
                            <asp:Button ID="btnSubmit" runat="server"
                                Text="Submit Registration"
                                CssClass="btn btn-primary btn-lg px-5"
                                OnClick="btnSubmit_Click" />
                        </div>

                    </div>
                </div>
            </div>
           
        </div>

    </div>
</asp:Content>

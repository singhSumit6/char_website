<%@ Page Title="" Language="C#" MasterPageFile="~/MasterCSE.master" AutoEventWireup="true" CodeFile="Basic_CSE.aspx.cs" Inherits="Basic_CSE" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <style>
     .field-error {
         color: #dc3545;
         font-size: 12px;
         display: block;
         margin-top: 4px;
     }

     .required-star {
         color: #dc3545;
     }
 </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
     <asp:HiddenField ID="hfBasicId" runat="server" />

 <!-- ORGANIZATION DETAILS -->
 <div class="card shadow-sm mb-4">
     <div class="card-header bg-light">
         <h5 class="mb-0 text-primary">Organization Details</h5>
     </div>
     <div class="card-body">
         <div class="row">

             <div class="col-md-12 mb-3">
                 <label>Organization Name <span class="required-star">*</span></label>
                 <asp:TextBox ID="txtOrgName" runat="server" CssClass="form-control form-control-lg" />
                 <asp:RequiredFieldValidator ID="rfvOrgName" runat="server"
                     ControlToValidate="txtOrgName" ErrorMessage="Organization name is required."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

             <div class="col-md-4 mb-3">
                 <label>Organization Type <span class="required-star">*</span></label>
                 <asp:DropDownList ID="ddlOrgType" runat="server" CssClass="form-control">
                     <asp:ListItem Value="">-- Select --</asp:ListItem>
                     <asp:ListItem Value="NGO">NGO</asp:ListItem>
                     <asp:ListItem Value="Trust">Trust</asp:ListItem>
                     <asp:ListItem Value="Society">Society</asp:ListItem>
                     <asp:ListItem Value="Section 8 Company">Section 8 Company</asp:ListItem>
                 </asp:DropDownList>
                 <asp:RequiredFieldValidator ID="rfvOrgType" runat="server"
                     ControlToValidate="ddlOrgType" InitialValue=""
                     ErrorMessage="Select organization type."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

           
             <div class="col-md-4 mb-3">
                 <label>Registration Number <span class="required-star">*</span></label>
                 <asp:TextBox ID="txtRegNo" runat="server" CssClass="form-control" />
                 <asp:RequiredFieldValidator ID="rfvRegNo" runat="server"
                     ControlToValidate="txtRegNo" ErrorMessage="Registration number is required."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

             <div class="col-md-4 mb-3">
                 <label>Registration Date <span class="required-star">*</span></label>
                 <asp:TextBox ID="txtRegDate" runat="server" TextMode="Date" CssClass="form-control" />
                 <asp:RequiredFieldValidator ID="rfvRegDate" runat="server"
                     ControlToValidate="txtRegDate" ErrorMessage="Registration date is required."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

             <div class="col-md-4 mb-3">
                 <label>PAN <span class="required-star">*</span></label>
                 <asp:TextBox ID="txtPAN" runat="server" CssClass="form-control" MaxLength="10" />
                 <asp:RequiredFieldValidator ID="rfvPAN" runat="server"
                     ControlToValidate="txtPAN" ErrorMessage="PAN is required."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
                 <asp:RegularExpressionValidator ID="revPAN" runat="server"
                     ControlToValidate="txtPAN" ValidationExpression="^[A-Za-z]{5}[0-9]{4}[A-Za-z]$"
                     ErrorMessage="Enter a valid PAN." CssClass="field-error"
                     Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

           

         </div>
     </div>
 </div>

 <!-- REGISTERED ADDRESS -->
 <div class="card shadow-sm mb-4">
     <div class="card-header bg-light">
         <h5 class="mb-0 text-primary">Registered Address</h5>
     </div>
     <div class="card-body">
         <div class="row">

             <div class="col-md-12 mb-3">
                 <label>Full Address <span class="required-star">*</span></label>
                 <asp:TextBox ID="txtRegAddress" runat="server"
                     TextMode="MultiLine" Rows="2" CssClass="form-control" />
                 <asp:RequiredFieldValidator ID="rfvRegAddress" runat="server"
                     ControlToValidate="txtRegAddress" ErrorMessage="Registered address is required."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

             <div class="col-md-3 mb-3">
                 <label>State <span class="required-star">*</span></label>
                 <asp:DropDownList ID="ddlRegState" runat="server"
                     CssClass="form-control" DataSourceID="DS_States"
                     DataTextField="State_Name" DataValueField="State_Id"
                     AppendDataBoundItems="true" AutoPostBack="true"
                     OnSelectedIndexChanged="ddlRegState_SelectedIndexChanged">
                     <asp:ListItem Value="0">Select State</asp:ListItem>
                 </asp:DropDownList>
                 <asp:RequiredFieldValidator ID="rfvRegState" runat="server"
                     ControlToValidate="ddlRegState" InitialValue="0"
                     ErrorMessage="Select registered state."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

             <div class="col-md-3 mb-3">
                 <label>District <span class="required-star">*</span></label>
                 <asp:DropDownList ID="ddlRegDistrict" runat="server" CssClass="form-control">
                     <asp:ListItem Value="0">Select District</asp:ListItem>
                 </asp:DropDownList>
                 <asp:RequiredFieldValidator ID="rfvRegDistrict" runat="server"
                     ControlToValidate="ddlRegDistrict" InitialValue="0"
                     ErrorMessage="Select registered district."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

            
             <div class="col-md-3 mb-3">
                 <label>PIN <span class="required-star">*</span></label>
                 <asp:TextBox ID="txtRegPIN" runat="server" CssClass="form-control" MaxLength="6" />
                 <asp:RequiredFieldValidator ID="rfvRegPIN" runat="server"
                     ControlToValidate="txtRegPIN" ErrorMessage="PIN is required."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
                 <asp:RegularExpressionValidator ID="revRegPIN" runat="server"
                     ControlToValidate="txtRegPIN" ValidationExpression="^[0-9]{6}$"
                     ErrorMessage="Enter a valid 6-digit PIN."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

         </div>
     </div>
 </div>

 <!-- COMMUNICATION ADDRESS -->
 <div class="card shadow-sm mb-4">
     <div class="card-header bg-light d-flex justify-content-between">
         <h5 class="mb-0 text-primary">Communication Address</h5>
         <div>
         <asp:CheckBox ID="chkSameAddress" runat="server"
             Text=" Same as Registered" AutoPostBack="true"
             OnCheckedChanged="chkSameAddress_CheckedChanged" />
         </div>
     </div>
     <div class="card-body">
         <div class="row">

             <div class="col-md-12 mb-3">
                 <label>Full Address <span class="required-star">*</span></label>
                 <asp:TextBox ID="txtCommAddress" runat="server"
                     TextMode="MultiLine" Rows="2" CssClass="form-control" />
                 <asp:RequiredFieldValidator ID="rfvCommAddress" runat="server"
                     ControlToValidate="txtCommAddress" ErrorMessage="Communication address is required."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

             <div class="col-md-4 mb-3">
                 <label>State <span class="required-star">*</span></label>
                 <asp:DropDownList ID="ddlCommState" runat="server"
                     CssClass="form-control" DataSourceID="DS_States"
                     DataTextField="State_Name" DataValueField="State_Id"
                     AppendDataBoundItems="true" AutoPostBack="true"
                     OnSelectedIndexChanged="ddlCommState_SelectedIndexChanged">
                     <asp:ListItem Value="0">Select State</asp:ListItem>
                 </asp:DropDownList>
                 <asp:RequiredFieldValidator ID="rfvCommState" runat="server"
                     ControlToValidate="ddlCommState" InitialValue="0"
                     ErrorMessage="Select communication state."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

             <div class="col-md-4 mb-3">
                 <label>District <span class="required-star">*</span></label>
                 <asp:DropDownList ID="ddlCommDistrict" runat="server" CssClass="form-control">
                     <asp:ListItem Value="0">Select District</asp:ListItem>
                 </asp:DropDownList>
                 <asp:RequiredFieldValidator ID="rfvCommDistrict" runat="server"
                     ControlToValidate="ddlCommDistrict" InitialValue="0"
                     ErrorMessage="Select communication district."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

             <div class="col-md-4 mb-3">
                 <label>PIN <span class="required-star">*</span></label>
                 <asp:TextBox ID="txtCommPIN" runat="server" CssClass="form-control" MaxLength="6" />
                 <asp:RequiredFieldValidator ID="rfvCommPIN" runat="server"
                     ControlToValidate="txtCommPIN" ErrorMessage="Communication PIN is required."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
                 <asp:RegularExpressionValidator ID="revCommPIN" runat="server"
                     ControlToValidate="txtCommPIN" ValidationExpression="^[0-9]{6}$"
                     ErrorMessage="Enter a valid 6-digit PIN."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

         </div>
     </div>
 </div>

 <!-- CONTACT DETAILS -->
 <div class="card shadow-sm mb-4">
     <div class="card-header bg-light">
         <h5 class="mb-0 text-primary">Contact Details</h5>
     </div>
     <div class="card-body">
         <div class="row">

             <div class="col-md-4 mb-3">
                 <label>Organization Mobile <span class="required-star">*</span></label>
                 <asp:TextBox ID="txtOrgMobile" runat="server"
                     CssClass="form-control" MaxLength="10" />
                 <asp:RequiredFieldValidator ID="rfvOrgMobile" runat="server"
                     ControlToValidate="txtOrgMobile" ErrorMessage="Mobile is required."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
                 <asp:RegularExpressionValidator ID="revOrgMobile" runat="server"
                     ControlToValidate="txtOrgMobile" ValidationExpression="^[6-9][0-9]{9}$"
                     ErrorMessage="Enter a valid 10-digit mobile number."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

             <div class="col-md-4 mb-3">
                 <label>Organization Email <span class="required-star">*</span></label>
                 <asp:TextBox ID="txtOrgEmail" runat="server"
                     TextMode="Email" CssClass="form-control" />
                 <asp:RequiredFieldValidator ID="rfvOrgEmail" runat="server"
                     ControlToValidate="txtOrgEmail" ErrorMessage="Organization email is required."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

             <div class="col-md-4 mb-3">
                 <label>Website <span class="required-star">*</span></label>
                 <asp:TextBox ID="txtWebsite" runat="server" CssClass="form-control" />
                 <asp:RequiredFieldValidator ID="rfvWebsite" runat="server"
                     ControlToValidate="txtWebsite" ErrorMessage="Website is required."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

         </div>
     </div>
 </div>

 <!-- AUTHORIZED SIGNATORY -->
 <div class="card shadow-sm mb-4">
     <div class="card-header bg-light">
         <h5 class="mb-0 text-primary">Authorized Signatory</h5>
     </div>
     <div class="card-body">
         <div class="row">

             <div class="col-md-3 mb-3">
                 <label>Name <span class="required-star">*</span></label>
                 <asp:TextBox ID="txtAuthName" runat="server" CssClass="form-control" />
                 <asp:RequiredFieldValidator ID="rfvAuthName" runat="server"
                     ControlToValidate="txtAuthName" ErrorMessage="Name is required."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

             <div class="col-md-3 mb-3">
                 <label>Designation <span class="required-star">*</span></label>
                 <asp:TextBox ID="txtAuthDesig" runat="server" CssClass="form-control" />
                 <asp:RequiredFieldValidator ID="rfvAuthDesig" runat="server"
                     ControlToValidate="txtAuthDesig" ErrorMessage="Designation is required."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

             <div class="col-md-3 mb-3">
                 <label>Mobile <span class="required-star">*</span></label>
                 <asp:TextBox ID="txtAuthMobile" runat="server"
                     CssClass="form-control" MaxLength="10" />
                 <asp:RequiredFieldValidator ID="rfvAuthMobile" runat="server"
                     ControlToValidate="txtAuthMobile" ErrorMessage="Authorized mobile is required."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
                 <asp:RegularExpressionValidator ID="revAuthMobile" runat="server"
                     ControlToValidate="txtAuthMobile" ValidationExpression="^[6-9][0-9]{9}$"
                     ErrorMessage="Enter a valid 10-digit mobile number."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

             <div class="col-md-3 mb-3">
                 <label>Email <span class="required-star">*</span></label>
                 <asp:TextBox ID="txtAuthEmail" runat="server"
                     TextMode="Email" CssClass="form-control" />
                 <asp:RequiredFieldValidator ID="rfvAuthEmail" runat="server"
                     ControlToValidate="txtAuthEmail" ErrorMessage="Authorized email is required."
                     CssClass="field-error" Display="Dynamic" ValidationGroup="BasicDetails" />
             </div>

         </div>
     </div>
 </div>

 <!-- DOCUMENTS -->
 <div class="card shadow-sm mb-4">
     <div class="card-header bg-light">
         <h5 class="mb-0 text-primary">Upload Documents</h5>
     </div>
     <div class="card-body">
         <div class="row">

             <div class="col-md-4 mb-3">
                 <label>Registration Certificate <span class="required-star">*</span></label>
                 <asp:FileUpload ID="fuRC" runat="server" CssClass="form-control" />
                <asp:CustomValidator ID="cvRC" runat="server"
 ErrorMessage="Registration certificate is required."
 CssClass="field-error"
 Display="Dynamic"
 ValidationGroup="BasicDetails"
 ValidateEmptyText="true"
 OnServerValidate="ValidateRequiredFile" />
             </div>

             <div class="col-md-4 mb-3">
                 <label>MOA / Trust Deed <span class="required-star">*</span></label>
                 <asp:FileUpload ID="fuMOA" runat="server" CssClass="form-control" />
                 <asp:CustomValidator ID="cvMOA" runat="server"
                     ErrorMessage="MOA / Trust Deed is required."
                     CssClass="field-error" Display="Dynamic"
                     ValidationGroup="BasicDetails"
                     OnServerValidate="ValidateRequiredFile" />
             </div>

             <div class="col-md-4 mb-3">
                 <label>PAN Card <span class="required-star">*</span></label>
                 <asp:FileUpload ID="fuPAN" runat="server" CssClass="form-control" />
                 <asp:CustomValidator ID="cvPAN" runat="server"
                     ErrorMessage="PAN card is required."
                     CssClass="field-error" Display="Dynamic"
                     ValidationGroup="BasicDetails"
                     OnServerValidate="ValidateRequiredFile" />
             </div>

         </div>
     </div>
 </div>

 <asp:ValidationSummary ID="vsBasicDetails" runat="server"
     ValidationGroup="BasicDetails" CssClass="text-danger mb-3" />

 <asp:Label ID="lblMsg" runat="server" />

 <div class="row mb-2">
     <div class="col-md-1">
         <asp:Button ID="btn_save" runat="server"
             Text="Save" CssClass="btn btn-primary"
             ValidationGroup="BasicDetails"
             OnClick="btnSave_Click" />
     </div>

     <div class="col-md-10"></div>


     <div class="col-md-1">
         <asp:Button ID="Button1" runat="server"
             Text="Next" CssClass="btn btn-success"
             ValidationGroup="BasicDetails"
             OnClick="btnNext_Click" />
     </div>
 </div>

 <asp:SqlDataSource
     ID="DS_States"
     runat="server"
     ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
     SelectCommand="Select * From Loc_States Where IsActive = 1" SelectCommandType="Text"></asp:SqlDataSource>

</asp:Content>


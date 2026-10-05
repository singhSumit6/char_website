<%@ Page Title="" Language="C#" MasterPageFile="~/MasterCSE.master" AutoEventWireup="true" CodeFile="Location_CSE.aspx.cs" Inherits="Location_CSE" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
     <!-- HEADER -->

 <div class="card shadow-sm mb-4">

     <div class="card-header d-flex justify-content-between bg-light">

         <h5 class="mb-0 text-primary">
             <i class="fa fa-chart-line"></i>Proposed Location
         </h5>

         <asp:Button ID="btnAddFinancial" runat="server"
             Text="+ Add Record"
             CssClass="btn btn-primary"
             OnClientClick="showFinancialModal(); return false;" />
     </div>
     <div class="card-body">


         <!-- GRID -->


         <asp:GridView ID="gvLocation"
             runat="server"
             CssClass="table table-bordered table-striped"
             AutoGenerateColumns="false"
             EmptyDataText="No proposed locations added yet.">

             <Columns>
                 <asp:TemplateField HeaderText="No.">
                     <ItemTemplate>
                         <%# Container.DataItemIndex + 1 %>
                     </ItemTemplate>
                 </asp:TemplateField>

                 <asp:BoundField DataField="State" HeaderText="State" />
                 <asp:BoundField DataField="District" HeaderText="District" />
                 <asp:BoundField DataField="Tehsil" HeaderText="Tehsil" />
                 <asp:BoundField DataField="Block" HeaderText="Block" />
                 <asp:BoundField DataField="PIN_Code" HeaderText="PIN" />

                 <asp:TemplateField HeaderText="Action">
                     <ItemTemplate>
                         <asp:LinkButton ID="btnEditLocation"
                             runat="server"
                             Text="Edit"
                             CssClass="btn btn-sm btn-warning me-1"
                             CommandArgument='<%# Eval("LocationID") %>'
                             CausesValidation="false"
                             OnClick="btnEdit_Click" />

                         <asp:LinkButton ID="btnDeleteLocation"
                             runat="server"
                             Text="Delete"
                             CssClass="btn btn-sm btn-danger"
                             CommandArgument='<%# Eval("LocationID") %>'
                             CausesValidation="false"
                             OnClick="btnDeleteLocation_Click"
                             OnClientClick="return confirm('Are you sure you want to delete this location?');" />
                     </ItemTemplate>
                 </asp:TemplateField>
             </Columns>
         </asp:GridView>


         
         <asp:Label runat="server" ID="lblMsg"></asp:Label>

         
         <div class="row">
             <div class="col-md-2 offset-md-10">
                 <asp:Button runat="server" ID="Button1" Width="90%" CssClass="btn btn-success" Text="Next" OnClick="btnNext_Click" />
             </div>
         </div>

     </div>

 </div>

 <!-- Modal -->

 <div class="modal fade" id="locationModal">

     <div class="modal-dialog modal-lg">

         <div class="modal-content">

             <div class="modal-header bg-primary text-white">

                 <h5>Add Proposed Location</h5>

                 <button type="button"
                     class="btn-close"
                     data-bs-dismiss="modal">
                 </button>

             </div>



             <div class="modal-body">
                 <asp:HiddenField ID="hfLocationID" runat="server" />

                 <div class="row">

                     <div class="col-md-6 mb-3">
                         <label>State <span class="text-danger">*</span></label>
                         <asp:DropDownList ID="ddlState" runat="server"
                             CssClass="form-control" DataSourceID="DS_States"
                             DataTextField="State_Name" DataValueField="State_Id"
                             AppendDataBoundItems="true"  AutoPostBack="true"
                              OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                             <asp:ListItem Value="0">Select State</asp:ListItem>
                         </asp:DropDownList>
                     </div>

                     <div class="col-md-6 mb-3">
                         <label>District <span class="text-danger">*</span></label>
                         <asp:DropDownList ID="ddlDistrict" runat="server"
                             CssClass="form-select">
                             <asp:ListItem Value="">-- Select District --</asp:ListItem>
                         </asp:DropDownList>
                     </div>

                     <div class="col-md-4 mb-3">
                         <label>Tehsil <span class="text-danger">*</span></label>
                         <asp:TextBox ID="txtTehsil" runat="server"
                             CssClass="form-control" />
                     </div>

                     <div class="col-md-4 mb-3">
                         <label>Block <span class="text-danger">*</span></label>
                         <asp:TextBox ID="txtBlock" runat="server"
                             CssClass="form-control" />
                     </div>

                     <div class="col-md-4 mb-3">
                         <label>PIN <span class="text-danger">*</span></label>
                         <asp:TextBox ID="txtPIN" runat="server"
                             CssClass="form-control"
                             MaxLength="6"
                             TextMode="Number" />
                     </div>

                 </div>
             </div>
             <div class="modal-footer">

                 <asp:Button ID="btnSaveLocation"
                     runat="server"
                     Text="Save"
                     CssClass="btn btn-success"
                     OnClick="btnSaveLocation_Click" />

             </div>

         </div>

     </div>
 </div>

 <asp:SqlDataSource
     ID="DS_States"
     runat="server"
     ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
     SelectCommand="Select * From Loc_States Where IsActive = 1" SelectCommandType="Text"></asp:SqlDataSource>


 <script>
     function showFinancialModal() {
         var modal = new bootstrap.Modal(
             document.getElementById('locationModal')
         );
         modal.show();
     }
 </script>
</asp:Content>


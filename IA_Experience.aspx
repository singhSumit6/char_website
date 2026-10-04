<%@ Page Title="" Language="C#" MasterPageFile="~/MasterCHAR.master" AutoEventWireup="true" CodeFile="IA_Experience.aspx.cs" Inherits="IA_Experience" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="card shadow-sm mb-4">

    <div class="card-header bg-light d-flex justify-content-between">

        <h5 class="mb-0 text-primary">
            <i class="fa fa-briefcase"></i> Project / Experience Details
        </h5>

        <asp:Button ID="btnAddProject" runat="server"
            Text="+ Add Project"
            CssClass="btn btn-primary"
            OnClientClick="showProjectModal(); return false;" />
    </div>

    <div class="card-body">

        <asp:GridView ID="gvProject" runat="server"
            CssClass="table table-bordered table-striped"
            AutoGenerateColumns="false">

            <Columns>

                <asp:BoundField DataField="FinancialYear" HeaderText="Year" />
                <asp:BoundField DataField="ProjectName" HeaderText="Project" />
                <asp:BoundField DataField="AgencyType" HeaderText="Agency" />
                <asp:BoundField DataField="ProjectStatus" HeaderText="Status" />
                <asp:BoundField DataField="SanctionAmount" HeaderText="Amount" />

                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>

                        <asp:LinkButton ID="btnEdit" runat="server"
                            Text="Edit"
                            CssClass="btn btn-sm btn-warning"
                            CommandArgument='<%# Eval("ProjectID") %>'
                            OnClick="btnEdit_Click" />

                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

        </asp:GridView>

    </div>

</div>


    <div class="modal fade" id="projectModal" tabindex="-1">

    <div class="modal-dialog modal-lg">

        <div class="modal-content">

            <!-- Header -->
            <div class="modal-header bg-primary text-white">

                <h5 class="modal-title">
                    <i class="fa fa-folder-open"></i> Project Details
                </h5>

                <button type="button"
                    class="btn-close"
                    data-bs-dismiss="modal"></button>

            </div>


            <!-- Body -->
            <div class="modal-body">

                <asp:HiddenField ID="hfProjectID" runat="server" />

                <div class="row">

                    <!-- Financial Year -->
                    <div class="col-md-4 mb-3">
                        <label class="mb-1">Financial Year</label>
                        <asp:TextBox ID="txtYear" runat="server"
                            CssClass="form-control"
                            Placeholder="2023-24" />
                    </div>

                    <!-- Project Name -->
                    <div class="col-md-8 mb-3">
                        <label class="mb-1">Project Name</label>
                        <asp:TextBox ID="txtProjectName" runat="server"
                            CssClass="form-control" />
                    </div>

                    <!-- Agency Type -->
                    <div class="col-md-6 mb-3">
                        <label class="mb-1">Sanctioning Agency</label>
                        <asp:DropDownList ID="ddlAgency" runat="server"
                            CssClass="form-control">

                            <asp:ListItem Value="">-- Select --</asp:ListItem>
                            <asp:ListItem>Central Government Department/Ministry</asp:ListItem>
                            <asp:ListItem>State Government Department</asp:ListItem>
                            <asp:ListItem>Public Sector Undertaking (PSU)</asp:ListItem>
                            <asp:ListItem>Corporate (CSR Funding Agency)</asp:ListItem>
                            <asp:ListItem>Self-Sponsored</asp:ListItem>
                            <asp:ListItem>Others</asp:ListItem>

                        </asp:DropDownList>
                    </div>

                    <!-- Project Location -->
                    <div class="col-md-6 mb-3">
                        <label class="mb-1">Project Location</label>
                        <asp:TextBox ID="txtLocation" runat="server"
                            CssClass="form-control" />
                    </div>

                    <!-- Area of Work -->
                    <div class="col-md-12 mb-3">
                        <label class="mb-1">Area of Work</label>
                        <asp:TextBox ID="txtArea" runat="server"
                            CssClass="form-control" />
                    </div>

                    <!-- Sanction Amount -->
                    <div class="col-md-4 mb-3">
                        <label class="mb-1">Sanction Amount (₹)</label>
                        <asp:TextBox ID="txtAmount" runat="server"
                            CssClass="form-control" />
                    </div>

                    <!-- Project Status -->
                    <div class="col-md-4 mb-3">
                        <label class="mb-1">Project Status</label>
                        <asp:DropDownList ID="ddlStatus" runat="server"
                            CssClass="form-control">

                            <asp:ListItem Value="">-- Select --</asp:ListItem>
                            <asp:ListItem>Ongoing</asp:ListItem>
                            <asp:ListItem>Completed</asp:ListItem>

                        </asp:DropDownList>
                    </div>

                    <!-- Proof Upload -->
                    <div class="col-md-4 mb-3">
                        <label class="mb-1">Upload Proof</label>
                        <asp:FileUpload ID="fuProof" runat="server"
                            CssClass="form-control" />
                    </div>

                </div>

            </div>


            <!-- Footer -->
            <div class="modal-footer">

                <button type="button"
                    class="btn btn-secondary"
                    data-bs-dismiss="modal">
                    Close
                </button>

                <asp:Button ID="btnSaveProject"
                    runat="server"
                    Text="Save"
                    CssClass="btn btn-success"
                    OnClick="btnSaveProject_Click" />

            </div>

        </div>

    </div>

</div>
    <script>
    function showProjectModal() {

        var modal = new bootstrap.Modal(
            document.getElementById('projectModal')
        );

        modal.show();
    }
    </script>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/MasterCHAR.master" AutoEventWireup="true" CodeFile="IA_Experience.aspx.cs" Inherits="IA_Experience" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .required-mark {
            color: #dc3545;
            font-weight: bold;
            margin-left: 3px;
        }

        .field-validation {
            display: block;
            color: #dc3545;
            font-size: 12px;
            margin-top: 4px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="card shadow-sm mb-4">

        <div class="card-header bg-light d-flex justify-content-between">

            <h5 class="mb-0 text-primary">
                <i class="fa fa-briefcase"></i>Project / Experience Details
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


                            <asp:LinkButton
                                ID="btnDelete"
                                runat="server"
                                Text="Delete"
                                CssClass="btn btn-sm btn-danger"
                                CommandArgument='<%# Eval("ProjectID") %>'
                                CausesValidation="false"
                                OnClick="btnDelete_Click"
                                OnClientClick="return confirm('Are you sure you want to delete this project?');" />

                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>

            </asp:GridView>


            <asp:Label runat="server" ID="lblMsg"></asp:Label>

            
            <div class="row">
                <div class="col-md-2 offset-md-10">
                    <asp:Button runat="server" ID="btnNext" Width="90%" CssClass="btn btn-success" Text="Next" OnClick="btnNext_Click" />
                </div>
            </div>

        </div>

    </div>


    <div class="modal fade" id="projectModal" tabindex="-1">

        <div class="modal-dialog modal-lg">

            <div class="modal-content">

                <!-- Header -->
                <div class="modal-header bg-primary text-white">

                    <h5 class="modal-title">
                        <i class="fa fa-folder-open"></i>Project Details
                    </h5>

                    <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal">
                    </button>

                </div>


                <!-- Body -->
                <div class="modal-body">

                    <asp:HiddenField ID="hfProjectID" runat="server" />


                    <div class="row">

                        <!-- Financial Year -->
                        <div class="col-md-4 mb-3">
                            <label class="mb-1">
                                Financial Year <span class="required-mark">*</span>
                            </label>
                            <asp:TextBox ID="txtYear" runat="server"
                                CssClass="form-control"
                                Placeholder="2023-24" />

                            <asp:RequiredFieldValidator ID="rfvYear" runat="server"
                                ControlToValidate="txtYear"
                                ErrorMessage="Financial year is required."
                                ValidationGroup="Project"
                                CssClass="field-validation"
                                Display="Dynamic" />
                        </div>

                        <!-- Project Name -->
                        <div class="col-md-8 mb-3">
                            <label class="mb-1">
                                Project Name <span class="required-mark">*</span>
                            </label>
                            <asp:TextBox ID="txtProjectName" runat="server"
                                CssClass="form-control" />

                            <asp:RequiredFieldValidator ID="rfvProjectName" runat="server"
                                ControlToValidate="txtProjectName"
                                ErrorMessage="Project name is required."
                                ValidationGroup="Project"
                                CssClass="field-validation"
                                Display="Dynamic" />
                        </div>

                        <!-- Agency -->
                        <div class="col-md-6 mb-3">
                            <label class="mb-1">
                                Sanctioning Agency <span class="required-mark">*</span>
                            </label>
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

                            <asp:RequiredFieldValidator ID="rfvAgency" runat="server"
                                ControlToValidate="ddlAgency"
                                InitialValue=""
                                ErrorMessage="Please select a sanctioning agency."
                                ValidationGroup="Project"
                                CssClass="field-validation"
                                Display="Dynamic" />
                        </div>

                        <!-- Location -->
                        <div class="col-md-6 mb-3">
                            <label class="mb-1">
                                Project Location <span class="required-mark">*</span>
                            </label>
                            <asp:TextBox ID="txtLocation" runat="server"
                                CssClass="form-control" />

                            <asp:RequiredFieldValidator ID="rfvLocation" runat="server"
                                ControlToValidate="txtLocation"
                                ErrorMessage="Project location is required."
                                ValidationGroup="Project"
                                CssClass="field-validation"
                                Display="Dynamic" />
                        </div>

                        <!-- Area of Work -->
                        <div class="col-md-12 mb-3">
                            <label class="mb-1">
                                Area of Work <span class="required-mark">*</span>
                            </label>
                            <asp:TextBox ID="txtArea" runat="server"
                                CssClass="form-control" />

                            <asp:RequiredFieldValidator ID="rfvArea" runat="server"
                                ControlToValidate="txtArea"
                                ErrorMessage="Area of work is required."
                                ValidationGroup="Project"
                                CssClass="field-validation"
                                Display="Dynamic" />
                        </div>

                        <!-- Sanction Amount -->
                        <div class="col-md-4 mb-3">
                            <label class="mb-1">
                                Sanction Amount (₹) <span class="required-mark">*</span>
                            </label>
                            <asp:TextBox ID="txtAmount" runat="server"
                                CssClass="form-control" />

                            <asp:RequiredFieldValidator ID="rfvAmount" runat="server"
                                ControlToValidate="txtAmount"
                                ErrorMessage="Sanction amount is required."
                                ValidationGroup="Project"
                                CssClass="field-validation"
                                Display="Dynamic" />

                            <asp:RegularExpressionValidator ID="revAmount" runat="server"
                                ControlToValidate="txtAmount"
                                ValidationExpression="^\d+(\.\d{1,2})?$"
                                ErrorMessage="Enter a valid non-negative amount."
                                ValidationGroup="Project"
                                CssClass="field-validation"
                                Display="Dynamic" />
                        </div>

                        <!-- Status -->
                        <div class="col-md-4 mb-3">
                            <label class="mb-1">
                                Project Status <span class="required-mark">*</span>
                            </label>
                            <asp:DropDownList ID="ddlStatus" runat="server"
                                CssClass="form-control">
                                <asp:ListItem Value="">-- Select --</asp:ListItem>
                                <asp:ListItem>Ongoing</asp:ListItem>
                                <asp:ListItem>Completed</asp:ListItem>
                            </asp:DropDownList>

                            <asp:RequiredFieldValidator ID="rfvStatus" runat="server"
                                ControlToValidate="ddlStatus"
                                InitialValue=""
                                ErrorMessage="Please select project status."
                                ValidationGroup="Project"
                                CssClass="field-validation"
                                Display="Dynamic" />
                        </div>

                        <!-- Proof -->
                        <div class="col-md-4 mb-3">
                            <label class="mb-1">
                                Upload Proof <span class="required-mark">*</span>
                            </label>
                            <asp:FileUpload ID="fuProof" runat="server"
                                CssClass="form-control" />

                        </div>

                    </div>

                    <asp:ValidationSummary ID="vsProject" runat="server"
                        ValidationGroup="Project"
                        CssClass="alert alert-danger mt-2"
                        HeaderText="Please correct the following:"
                        DisplayMode="BulletList" />


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
                          ValidationGroup="Project"
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


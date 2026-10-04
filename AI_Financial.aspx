<%@ Page Title="" Language="C#" MasterPageFile="~/MasterCHAR.master" AutoEventWireup="true" CodeFile="AI_Financial.aspx.cs" Inherits="AI_Financial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .required-star {
            color: #dc3545;
        }

        .field-error {
            color: #dc3545;
            font-size: 12px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">


    <div class="card shadow-sm mb-4">

        <div class="card-header d-flex justify-content-between bg-light">

            <h5 class="mb-0 text-primary">
                <i class="fa fa-chart-line"></i>Financial Records
            </h5>

            <asp:Button ID="btnAddFinancial" runat="server"
                Text="+ Add Record"
                CssClass="btn btn-primary"
                OnClientClick="showFinancialModal(); return false;" />
        </div>

        <div class="card-body">

            <asp:GridView ID="gvFinancial" runat="server"
                CssClass="table table-bordered table-striped"
                AutoGenerateColumns="false">

                <Columns>

                    <asp:BoundField
                        DataField="FinancialYear"
                        HeaderText="Financial Year" />

                    <asp:BoundField
                        DataField="Turnover"
                        HeaderText="Turnover" />

                    <asp:BoundField
                        DataField="NetWorth"
                        HeaderText="Net Worth" />

                    <asp:BoundField
                        DataField="ITR"
                        HeaderText="ITR" />

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton
                                ID="btnEdit"
                                runat="server"
                                Text="Edit"
                                CssClass="btn btn-sm btn-primary"
                                CommandArgument='<%# Eval("FinancialID") %>'
                                CausesValidation="false"
                                OnClick="btnEdit_Click" />

                            <asp:LinkButton
                                ID="btnDelete"
                                runat="server"
                                Text="Delete"
                                CssClass="btn btn-sm btn-danger"
                                CommandArgument='<%# Eval("FinancialID") %>'
                                CausesValidation="false"
                                OnClick="btnDelete_Click"
                                OnClientClick="return confirm('Are you sure you want to delete this financial record?');" />
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>

            </asp:GridView>

            <asp:Label ID="lblMsg" runat="server" />


            <div class="row">
                <div class="col-md-2 offset-md-10">
                    <asp:Button runat="server" ID="btnNext" Width="90%" CssClass="btn btn-success" Text="Next" OnClick="btnNext_Click" />
                </div>
            </div>

        </div>

    </div>


    <div class="modal fade" id="financialModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">
                        <i class="fa fa-chart-line"></i>Financial Details
                    </h5>
                    <button type="button" class="btn-close"
                        data-bs-dismiss="modal">
                    </button>
                </div>

                <div class="modal-body">

                    <asp:HiddenField ID="hfFinancialID" runat="server" />

                    <div class="row">

                        <div class="col-md-4 mb-3">
                            <label class="mb-1">Financial Year  <span class="required-star">*</span></label>
                            <asp:TextBox ID="txtYear" runat="server"
                                CssClass="form-control"
                                Placeholder="2023-24" />

                            <asp:RequiredFieldValidator
                                ID="rfvYear"
                                runat="server"
                                ControlToValidate="txtYear"
                                ErrorMessage="Financial year is required."
                                ValidationGroup="Financial"
                                CssClass="text-danger"
                                Display="Dynamic" />
                        </div>

                        <div class="col-md-4 mb-3">
                            <label class="mb-1">Turnover  <span class="required-star">*</span></label>
                            <asp:TextBox ID="txtTurnover" runat="server"
                                CssClass="form-control" />

                            <asp:RequiredFieldValidator
                                ID="rfvTurnover"
                                runat="server"
                                ControlToValidate="txtTurnover"
                                ErrorMessage="Turnover is required."
                                ValidationGroup="Financial"
                                CssClass="text-danger"
                                Display="Dynamic" />

                            <asp:RegularExpressionValidator
                                ID="revTurnover"
                                runat="server"
                                ControlToValidate="txtTurnover"
                                ValidationExpression="^\d+(\.\d{1,2})?$"
                                ErrorMessage="Enter a valid non-negative turnover amount."
                                ValidationGroup="Financial"
                                CssClass="text-danger"
                                Display="Dynamic" />
                        </div>

                        <div class="col-md-4 mb-3">
                            <label class="mb-1">Net Worth  <span class="required-star">*</span></label>
                            <asp:TextBox ID="txtNetWorth" runat="server"
                                CssClass="form-control" />

                            <asp:RequiredFieldValidator
                                ID="rfvNetWorth"
                                runat="server"
                                ControlToValidate="txtNetWorth"
                                ErrorMessage="Net worth is required."
                                ValidationGroup="Financial"
                                CssClass="text-danger"
                                Display="Dynamic" />

                            <asp:RegularExpressionValidator
                                ID="revNetWorth"
                                runat="server"
                                ControlToValidate="txtNetWorth"
                                ValidationExpression="^-?\d+(\.\d{1,2})?$"
                                ErrorMessage="Enter a valid net worth amount."
                                ValidationGroup="Financial"
                                CssClass="text-danger"
                                Display="Dynamic" />
                        </div>

                        <div class="col-md-4 mb-3">
                            <label class="mb-1">ITR No  <span class="required-star">*</span></label>
                            <asp:TextBox ID="txtITR" runat="server"
                                CssClass="form-control" />

                            <asp:RequiredFieldValidator
                                ID="rfvITR"
                                runat="server"
                                ControlToValidate="txtITR"
                                ErrorMessage="ITR details are required."
                                ValidationGroup="Financial"
                                CssClass="text-danger"
                                Display="Dynamic" />
                        </div>

                        <div class="col-md-4 mb-3">
                            <label class="mb-1">Financial Report No   <span class="required-star">*</span></label>
                            <asp:TextBox ID="txtFinReport" runat="server"
                                CssClass="form-control" />

                            <asp:RequiredFieldValidator
                                ID="rfvFinReport"
                                runat="server"
                                ControlToValidate="txtFinReport"
                                ErrorMessage="Financial report details are required."
                                ValidationGroup="Financial"
                                CssClass="text-danger"
                                Display="Dynamic" />
                        </div>

                        <div class="col-md-4 mb-3">
                            <label class="mb-1">Upload ITR File   <span class="required-star">*</span></label>
                            <asp:FileUpload ID="fuITRFile" runat="server"
                                CssClass="form-control" />
                        </div>

                    </div>

                </div>

                <div class="modal-footer">
                    <button type="button"
                        class="btn btn-secondary"
                        data-bs-dismiss="modal">
                        Close
                    </button>

                    <asp:Button ID="btnSaveFinancial"
                        runat="server"
                        Text="Save"
                        CssClass="btn btn-success"
                        ValidationGroup="Financial"
                        OnClick="btnSaveFinancial_Click" />
                </div>

            </div>
        </div>


    </div>
    <script>
        function showFinancialModal() {
                    var modal = new bootstrap.Modal(
                        document.getElementById('financialModal')
                    );
                    modal.show();
                }
    </script>
</asp:Content>


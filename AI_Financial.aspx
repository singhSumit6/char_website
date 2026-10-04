<%@ Page Title="" Language="C#" MasterPageFile="~/MasterCHAR.master" AutoEventWireup="true" CodeFile="AI_Financial.aspx.cs" Inherits="AI_Financial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">


    <div class="card shadow-sm mb-4">

    <div class="card-header d-flex justify-content-between bg-light">

        <h5 class="mb-0 text-primary">
            <i class="fa fa-chart-line"></i> Financial Records
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

                <asp:BoundField DataField="FinancialYear" HeaderText="Year" />
                <asp:BoundField DataField="Turnover" HeaderText="Turnover" />
                <asp:BoundField DataField="NetWorth" HeaderText="Net Worth" />
                <asp:BoundField DataField="ITR" HeaderText="ITR No" />

                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>

                        <asp:LinkButton ID="btnEdit" runat="server"
                            Text="Edit"
                            CssClass="btn btn-sm btn-warning"
                            CommandArgument='<%# Eval("FinancialID") %>'
                            OnClick="btnEdit_Click" />

                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

        </asp:GridView>

    </div>

</div>


    <div class="modal fade" id="financialModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">
                    <i class="fa fa-chart-line"></i> Financial Details
                </h5>
                <button type="button" class="btn-close"
                    data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <asp:HiddenField ID="hfFinancialID" runat="server" />

                <div class="row">

                    <div class="col-md-4 mb-3">
                        <label class="mb-1">Financial Year</label>
                        <asp:TextBox ID="txtYear" runat="server"
                            CssClass="form-control"
                            Placeholder="2023-24" />
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="mb-1">Turnover</label>
                        <asp:TextBox ID="txtTurnover" runat="server"
                            CssClass="form-control" />
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="mb-1">Net Worth</label>
                        <asp:TextBox ID="txtNetWorth" runat="server"
                            CssClass="form-control" />
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="mb-1">ITR No</label>
                        <asp:TextBox ID="txtITR" runat="server"
                            CssClass="form-control" />
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="mb-1">Financial Report No</label>
                        <asp:TextBox ID="txtFinReport" runat="server"
                            CssClass="form-control" />
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="mb-1">Upload ITR File</label>
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


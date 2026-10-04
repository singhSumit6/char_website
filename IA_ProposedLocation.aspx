<%@ Page Title="" Language="C#" MasterPageFile="~/MasterCHAR.master" AutoEventWireup="true" CodeFile="IA_ProposedLocation.aspx.cs" Inherits="IA_ProposedLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
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
                CssClass="table table-bordered"
                AutoGenerateColumns="false">

                <Columns>

                    <asp:TemplateField HeaderText="No">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="LocationName" HeaderText="Location Name" />
                    <asp:BoundField DataField="FullAddress" HeaderText="Address" />
                    <asp:BoundField DataField="Block" HeaderText="Block" />
                    <asp:BoundField DataField="Tehsil" HeaderText="Tehsil" />
                    <asp:BoundField DataField="State" HeaderText="State" />
                    <asp:BoundField DataField="District" HeaderText="District" />
                    <asp:BoundField DataField="PIN_Code" HeaderText="PIN" />

                </Columns>

            </asp:GridView>

        </div>

    </div>



    <!-- SAVE NEXT -->

    <div class="text-end">

        <asp:Button ID="btnNext"
            runat="server"
            Text="Save & Next"
            CssClass="btn btn-primary"
            OnClick="btnNext_Click" />

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

                        <div class="col-md-6 mb-2">
                            <label class="mb-1">Location Name</label>
                            <asp:TextBox ID="txtLocationName" runat="server" CssClass="form-control" />
                        </div>

                        <div class="col-md-6 mb-2">
                            <label class="mb-1">Block</label>
                            <asp:TextBox ID="txtBlock" runat="server" CssClass="form-control" />
                        </div>

                        <div class="col-md-12 mb-2">
                            <label class="mb-1">Full Address</label>
                            <asp:TextBox ID="txtAddress" runat="server"
                                TextMode="MultiLine"
                                Rows="2"
                                CssClass="form-control" />
                        </div>

                        <div class="col-md-4 mb-2">
                            <label class="mb-1">Tehsil</label>
                            <asp:TextBox ID="txtTehsil" runat="server" CssClass="form-control" />
                        </div>

                        <div class="col-md-4 mb-2">
                            <label class="mb-1">State</label>
                            <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" />
                        </div>

                        <div class="col-md-4 mb-2">
                            <label class="mb-1">District</label>
                            <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control" />
                        </div>

                        <div class="col-md-4 mb-2">
                            <label class="mb-1">PIN</label>
                            <asp:TextBox ID="txtPIN" runat="server" CssClass="form-control" />
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
        <script>
    function showFinancialModal() {
        var modal = new bootstrap.Modal(
            document.getElementById('locationModal')
        );
        modal.show();
    }
        </script>

</asp:Content>


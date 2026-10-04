<%@ Page Title="" Language="C#" MasterPageFile="~/MasterCHAR.master" AutoEventWireup="true" CodeFile="IA_Members.aspx.cs" Inherits="IA_Members" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


     <div class="card shadow-sm mb-4">

        <!-- Header -->
         <div class="card-header d-flex justify-content-between bg-light">

            <h4 class="text-primary">
                <i class="fa fa-users"></i>Members Details
            </h4>

            <asp:Button ID="btnAddMember" runat="server"
                Text="+ Add Member"
                CssClass="btn btn-primary"
                OnClientClick="showMemberModal(); return false;" />
        </div>


        <!-- Members Grid -->
         <div class="card-body">

            <div class="card-body">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">

                    <ContentTemplate>


                        <asp:GridView ID="gvMembers" runat="server"
                            CssClass="table table-bordered table-striped"
                            AutoGenerateColumns="false">

                            <Columns>

                                <asp:BoundField DataField="Name" HeaderText="Name" />
                                <asp:BoundField DataField="Designation" HeaderText="Designation" />
                                <asp:BoundField DataField="Phone" HeaderText="Phone" />
                                <asp:BoundField DataField="Email" HeaderText="Email" />

                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>

                                        <asp:LinkButton ID="btnEdit" runat="server"
                                            Text="Edit"
                                            CssClass="btn btn-sm btn-warning me-1"
                                            CommandArgument='<%# Eval("MemberID") %>'
                                            OnClick="btnEdit_Click" />

                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>

                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

        </div>

    </div>


    <!-- ================= MEMBER MODAL ================= -->

    <div class="modal fade" id="memberModal" tabindex="-1">

        <div class="modal-dialog modal-lg">

            <div class="modal-content">

                <!-- Header -->
                <div class="modal-header bg-primary text-white">

                    <h5 class="modal-title">
                        <i class="fa fa-user"></i>Member Details
                    </h5>

                    <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal">
                    </button>

                </div>


                <!-- Body -->
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>


                        <div class="modal-body">

                            <asp:HiddenField ID="hfMemberID" runat="server" />

                            <div class="row">

                                <div class="col-md-6 mb-3">
                                    <label class="mb-1">Name</label>
                                    <asp:TextBox ID="txtName" runat="server"
                                        CssClass="form-control" />
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label class="mb-1">Designation</label>
                                    <asp:TextBox ID="txtDesignation" runat="server"
                                        CssClass="form-control" />
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label class="mb-1">Aadhaar</label>
                                    <asp:TextBox ID="txtAadhaar" runat="server"
                                        CssClass="form-control"
                                        MaxLength="12" />
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label class="mb-1">PAN</label>
                                    <asp:TextBox ID="txtPAN" runat="server"
                                        CssClass="form-control"
                                        MaxLength="10" />
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label class="mb-1">Email</label>
                                    <asp:TextBox ID="txtEmail" runat="server"
                                        TextMode="Email"
                                        CssClass="form-control" />
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label class="mb-1">Phone</label>
                                    <asp:TextBox ID="txtPhone" runat="server"
                                        CssClass="form-control"
                                        MaxLength="10" />
                                </div>

                                <div class="col-md-12 mb-3">
                                    <label class="mb-1">Address</label>
                                    <asp:TextBox ID="txtAddress" runat="server"
                                        TextMode="MultiLine"
                                        Rows="2"
                                        CssClass="form-control" />
                                </div>

                            </div>

                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <!-- Footer -->
                <div class="modal-footer">

                    <button type="button"
                        class="btn btn-secondary"
                        data-bs-dismiss="modal">
                        Close
               
                    </button>

                    <asp:Button ID="btnSaveMember" runat="server"
                        Text="Save"
                        CssClass="btn btn-success"
                        OnClick="btnSaveMember_Click" />

                </div>

            </div>

        </div>

    </div>


    <!-- ================= SCRIPT ================= -->

    <script>

        function showMemberModal() {

            var modal = new bootstrap.Modal(
                document.getElementById('memberModal')
            );

            modal.show();
        }

    </script>
</asp:Content>


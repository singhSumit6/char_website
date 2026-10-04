<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="IA_Login.aspx.cs" Inherits="IA_Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <title>CAHR | IA Login</title>

    <!-- Bootstrap -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            background: linear-gradient(to right, #0d6efd, #4facfe);
            min-height: 100vh;
        }

       
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">

    <div class="row justify-content-center align-items-center"
         style="min-height:100vh;">

        <div class="col-md-5">

            <div class="card login-card shadow">

                <!-- Header -->
                <div class="card-header login-header text-center">

                    <h4 class="mb-1">CAHR Portal</h4>
                    <small>Implementing Agency Login</small>

                </div>

                <!-- Body -->
                <div class="card-body p-4">

                    <!-- Email -->
                    <div class="form-group mb-3">

                        <label>Email / User ID</label>

                        <div class="input-group">

                            <span class="input-group-text">
                                <i class="fa fa-user"></i>
                            </span>

                            <asp:TextBox ID="txtUser" runat="server"
                                CssClass="form-control"
                                placeholder="Enter Email or User ID" />

                        </div>

                    </div>


                    <!-- Password -->
                    <div class="form-group mb-3">

                        <label>Password</label>

                        <div class="input-group">

                            <span class="input-group-text">
                                <i class="fa fa-lock"></i>
                            </span>

                            <asp:TextBox ID="txtPassword" runat="server"
                                TextMode="Password"
                                CssClass="form-control"
                                placeholder="Enter Password" />

                        </div>

                    </div>


                    <!-- Remember -->
                    <div class="form-group mb-3 d-flex justify-content-between">

                        <div>
                            <asp:CheckBox ID="chkRemember" runat="server" />
                            Remember Me
                        </div>

                        <a href="ForgotPassword.aspx"
                           class="text-primary small">
                            Forgot Password?
                        </a>

                    </div>
                    <asp:Label ID="lblMsg" runat="server" Text=""/>

                    <!-- Button -->
                    <div class="d-grid">

                        <asp:Button ID="btnLogin" runat="server"
                            Text="Login"
                            CssClass="btn btn-primary btn-lg"
                            OnClick="btnLogin_Click" />

                    </div>


                    <!-- Register -->
                    <div class="text-center mt-3">

                        <small>
                            New User?
                            <a href="IA_Registration.aspx" class="text-primary">
                                Register Here
                            </a>
                        </small>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

</asp:Content>


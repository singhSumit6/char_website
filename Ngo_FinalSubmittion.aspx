
<%@ Page Title="Final Submission" Language="C#" MasterPageFile="~/MasterCHAR.master" AutoEventWireup="true" CodeFile="Ngo_FinalSubmittion.aspx.cs" Inherits="Ngo_FinalSubmittion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .submission-wrapper {
            max-width: 850px;
            margin: 40px auto;
            padding: 20px;
        }

        .submission-card {
            background: #fff;
            border-radius: 20px;
            padding: 45px 35px;
            text-align: center;
            box-shadow: 0 8px 35px rgba(0, 0, 128, 0.08);
            border: 1px solid #e8e8f5;
        }

        .success-icon {
            width: 100px;
            height: 100px;
            margin: 0 auto 25px;
            border-radius: 50%;
            background: #e8f8ef;
            color: #198754;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
        }

        .submission-title {
            color: #000080;
            font-size: 30px;
            font-weight: 700;
            margin-bottom: 15px;
        }

        .submission-description {
            color: #667085;
            font-size: 16px;
            line-height: 1.8;
            max-width: 650px;
            margin: 0 auto 25px;
        }

        .status-badge {
            display: inline-block;
            background: #e7e7f5;
            color: #000080;
            padding: 9px 20px;
            border-radius: 30px;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 25px;
        }

        .payment-notice {
            background: #fff8ed;
            border: 1px solid #ffe0b2;
            border-radius: 12px;
            padding: 20px;
            text-align: left;
            margin-top: 20px;
        }

        .payment-notice h5 {
            color: #a85d00;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .payment-notice p {
            color: #79552c;
            margin-bottom: 0;
            line-height: 1.7;
        }

        .submission-footer {
            color: #98a2b3;
            font-size: 13px;
            margin-top: 30px;
        }

        @media (max-width: 576px) {
            .submission-wrapper {
                margin: 15px auto;
                padding: 10px;
            }

            .submission-card {
                padding: 35px 20px;
            }

            .submission-title {
                font-size: 24px;
            }

            .success-icon {
                width: 80px;
                height: 80px;
                font-size: 38px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <div class="submission-wrapper">
        <div class="submission-card">

            <div class="success-icon">
                <i class="fa fa-check-circle"></i>
            </div>

            <div class="status-badge">
                <i class="fa fa-check-circle"></i>
                &nbsp; Application Submitted
            </div>

            <h2 class="submission-title">
                Congratulations!
            </h2>

            <p class="submission-description">
                Your application submission process has been completed successfully.
                Thank you for providing the required information and documents.
                Your application will be processed as per the applicable procedure.
            </p>

            <div class="payment-notice">
                <h5>
                    <i class="fa fa-info-circle"></i>
                    &nbsp; Payment Details
                </h5>
                <p>
                    Payment-related information and further instructions will be
                    made available here shortly. Please check this page for updates
                    and follow the instructions once the details are announced.
                </p>
            </div>

            <p class="submission-footer">
                Thank you for your cooperation.
                <br />
                Please keep this page bookmarked for future reference.
            </p>

        </div>
    </div>

</asp:Content>

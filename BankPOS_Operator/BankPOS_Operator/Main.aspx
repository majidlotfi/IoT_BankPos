<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Main.aspx.vb" Inherits="BankPOS_Operator.Main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>سامانه مديريت و تجميع گزارش دستگاه هاي كارتخوان</title>
    <style>
        body {
            font-family: Tahoma;
            direction: rtl;
            margin-left: 10%;
            margin-right: 10%;
            vertical-align: top;
        }
        fieldset input[type=text] {
            font-size:12px;
            background-color:#FFFFCC;
            font-family:Tahoma;
            height:15px;
            margin:2px;
        }
        fieldset input[type=button] {
            text-align:center;
            font-size:10px;
            height:25px;
            margin:2px;
            background-color:lightgray;
            font-family:Tahoma;
        }
        fieldset legend {
            font-size:12px;
            font-weight:bold;
            color:rebeccapurple;
        }
        fieldset {
            width:270px;
            font-size:10px;
        }
    </style>
    <script src="Scripts/jquery-3.6.0.min.js"></script>
    <script src="Scripts/persian-date.js"></script>
    <script type="text/javascript">
        function ReadPCPos() {
            var tarikh = new persianDate();
            var dt = prompt('لطفا تاريخ را وارد نمائيد', tarikh.toLocale('en').format().substring(0, 10));
            if (dt.length != 10) { alert('تاريخ صحيح نمي باشد'); return; }
            confirm("پس از تائيد عمليات شروع مي شود ، لطفا تا پيام پايان منتظر بمانيد");
            $.ajax({
                url: "/MainOpr.aspx?Dater=" & dt & "&op=GetPCPosData",
                context: document.body
            }).done(function () {
                alert("عمليات پايان يافت");
            });
        }
        function ReadOprs() {
            var tarikh = new persianDate();
            var dt = prompt('لطفا تاريخ را وارد نمائيد', tarikh.toLocale('en').format().substring(0, 10));
            if (dt.length != 10) { alert('تاريخ صحيح نمي باشد'); return; }
            confirm("پس از تائيد عمليات شروع مي شود ، لطفا تا پيام پايان منتظر بمانيد");
            $.ajax({
                url: "/MainOpr.aspx?Dater=" & dt & "&op=GetSumData",
                context: document.body
            }).done(function () {
                alert("عمليات پايان يافت");
            });
        }
    </script>
</head>
<body>
    <form id="frmMain" runat="server">
        <input id="Opr" name="Op" type="hidden" />
        <div align="center" class="Titr" style="border: thin double #800000; padding: 10px; background-color: #FFFFCC;">
            سامانه تجميع و خدمات گزارش پايانه هاي بانكي
        </div>
        <div style="margin: 10px;">
            <div class="Blocks" style="border: 1px solid #808080; width: 300px; float: right;">
                <p class="Titr" style="text-align: center; padding: 5px; background-color: beige; margin: 0px">
                    عملياتهاي قابل پردازش
                </p>
                <fieldset id="grpNewPCPos" runat="server" style="display: block">
                    <legend class="Titr">افزودن كارتخوان شبكه</legend>
                    <asp:FormView ID="frmNewPcPos" runat="server" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" DataKeyNames="PCPosId" DataSourceID="AdpPcPos" DefaultMode="Insert" CellSpacing="1" Font-Bold="False">
                        <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
                        <InsertItemTemplate>
                            عنوان دستگاه :
                            <asp:TextBox ID="TitleTextBox" runat="server" Height="16px" Text='<%# Bind("Title") %>' Width="200px" />
                            <br />
                            آدرس دسترسي (URL):
                            <asp:TextBox ID="AddrTextBox" runat="server" Height="16px" Text='<%# Bind("Addr") %>' Width="200px" />
                            <br />
                            پورت:
                            <asp:TextBox ID="PortTextBox" runat="server" Height="16px" Text='<%# Bind("Port") %>' Width="56px" />
                            <br />
                            سريال دستگاه:
                            <asp:TextBox ID="SerialTextBox" runat="server" Height="16px" Text='<%# Bind("Serial") %>' Width="94px" />
                            <br />
                            ترمينال:
                            <asp:TextBox ID="TerminalTextBox" runat="server" Text='<%# Bind("Terminal") %>' />
                            <br />
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="ثبت" />
                            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="انصراف" />
                        </InsertItemTemplate>
                        <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                        <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                    </asp:FormView>

                </fieldset>
                <fieldset id="grpNewOpr" runat="server" style="display: block">
                    <legend class="Titr">افزودن اپراتور</legend>
                    <asp:FormView ID="frmNewOpr" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="OperatorId" DataSourceID="AdpOprList" DefaultMode="Insert" GridLines="Vertical" Font-Bold="False">
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                        <InsertItemTemplate>
                            عنوان اپراتور:
                            <asp:TextBox ID="TitleTextBox" runat="server" CssClass="frmTxtBox" Height="16px" Text='<%# Bind("Title") %>' Width="200px" />
                            <br />
                            آدرس دسترسي (URL):
                            <asp:TextBox ID="AddrTextBox" runat="server" CssClass="frmTxtBox" Text='<%# Bind("Addr") %>' Width="200px" />
                            <br />
                            پورت:
                            <asp:TextBox ID="PortTextBox" runat="server" CssClass="frmTxtBox" Text='<%# Bind("Port") %>' />
                            <br />
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="ثبت" />
                            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="انصراف" />
                        </InsertItemTemplate>
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    </asp:FormView>
                </fieldset>
                <fieldset id="grpOthOpr" runat="server" style="display: block">
                    <legend class="Titr">ساير عمليات ها</legend>
                    <input id="btnReadPCPos" type="button" style="width:220px" value="دريافت اطلاعات از دستگاه هاي پوز" onclick="ReadPCPos()" />
                    <input id="btnReadOprs" type="button" style="width:220px" value="دريافت اطلاعات از اپراتورها" onclick="ReadOprs()" />
                </fieldset>
            </div>
            <div class="Blocks" style="width: auto; margin-right: 310px; overflow: scroll; height: 400px;">
                <fieldset id="pnlPreview" runat="server" style="float: right; width: 200px; height: 200px; overflow: scroll;">
                    <legend class="Titr">دستگاه هاي كارتخوان</legend>
                    <asp:ListView ID="lstPcPos" runat="server" DataKeyNames="PCPosId" DataSourceID="AdpPcPos">
                        <AlternatingItemTemplate>
                            <li style="background-color: #FFFFFF; color: #284775;">پوز :
                                <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                            </li>
                        </AlternatingItemTemplate>
                        <EmptyDataTemplate>
                            هيچ دستگاه كارتخواني معرفي نشده است - ليست خالي مي باشد.
                        </EmptyDataTemplate>
                        <ItemSeparatorTemplate>
                            <br />
                        </ItemSeparatorTemplate>
                        <ItemTemplate>
                            <li style="background-color: #E0FFFF; color: #333333;">پوز :
                                <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                            </li>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <ul id="itemPlaceholderContainer" runat="server" style="font-family: Verdana, Arial, Helvetica, sans-serif;">
                                <li runat="server" id="itemPlaceholder" />
                            </ul>
                            <div style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF;">
                            </div>
                        </LayoutTemplate>
                        <SelectedItemTemplate>
                            <li style="background-color: #E2DED6; font-weight: bold; color: #333333;">PCPosId:
                                <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                            </li>
                        </SelectedItemTemplate>
                    </asp:ListView>
                </fieldset>
                <fieldset id="grpOprList" runat="server" style="float: right; width: 200px; height: 200px; overflow: scroll;">
                    <legend class="Titr">اپراتور ها</legend>
                    <asp:ListView ID="lstOprList" runat="server" DataKeyNames="OperatorId" DataSourceID="AdpOprList">
                        <AlternatingItemTemplate>
                            <li style="background-color: #FFFFFF; color: #284775;">اپراتور :
                                <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                            </li>
                        </AlternatingItemTemplate>
                        <EmptyDataTemplate>
                            هيچ اپراتوري معرفي نشده است - ليست خالي مي باشد.
                        </EmptyDataTemplate>
                        <ItemSeparatorTemplate>
                            <br />
                        </ItemSeparatorTemplate>
                        <ItemTemplate>
                            <li style="background-color: #E0FFFF; color: #333333;">اپراتور :
                                <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                            </li>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <ul id="itemPlaceholderContainer" runat="server" style="font-family: Verdana, Arial, Helvetica, sans-serif;">
                                <li runat="server" id="itemPlaceholder" />
                            </ul>
                            <div style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF;">
                            </div>
                        </LayoutTemplate>
                        <SelectedItemTemplate>
                            <li style="background-color: #E2DED6; font-weight: bold; color: #333333;">PCPosId:
                                <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                            </li>
                        </SelectedItemTemplate>
                    </asp:ListView>
                </fieldset>
            </div>
        </div>
        <asp:SqlDataSource ID="AdpPcPos" runat="server" ConnectionString="<%$ ConnectionStrings:DbConStr %>" DeleteCommand="DELETE FROM [PCPosList] WHERE [PCPosId] = @PCPosId" InsertCommand="INSERT INTO [PCPosList] ([PCPosId], [Title], [Addr], [Port], [Serial], [Terminal]) VALUES (@PCPosId, @Title, @Addr, @Port, @Serial, @Terminal)" SelectCommand="SELECT [PCPosId], [Title], [Addr], [Port], [Serial], [Terminal] FROM [PCPosList]" UpdateCommand="UPDATE [PCPosList] SET [Title] = @Title, [Addr] = @Addr, [Port] = @Port, [Serial] = @Serial, [Terminal] = @Terminal WHERE [PCPosId] = @PCPosId">
            <DeleteParameters>
                <asp:Parameter Name="PCPosId" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="PCPosId" Type="Int32" />
                <asp:Parameter Name="Title" Type="String" />
                <asp:Parameter Name="Addr" Type="String" />
                <asp:Parameter Name="Port" Type="Int32" />
                <asp:Parameter Name="Serial" Type="String" />
                <asp:Parameter Name="Terminal" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Title" Type="String" />
                <asp:Parameter Name="Addr" Type="String" />
                <asp:Parameter Name="Port" Type="Int32" />
                <asp:Parameter Name="Serial" Type="String" />
                <asp:Parameter Name="Terminal" Type="String" />
                <asp:Parameter Name="PCPosId" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="AdpOprList" runat="server" ConnectionString="<%$ ConnectionStrings:DbConStr %>" DeleteCommand="DELETE FROM [OprList] WHERE [OperatorId] = @OperatorId" InsertCommand="INSERT INTO [OprList] ([OperatorId], [Title], [Addr], [Port]) VALUES (@OperatorId, @Title, @Addr, @Port)" ProviderName="<%$ ConnectionStrings:DbConStr.ProviderName %>" SelectCommand="SELECT [OperatorId], [Title], [Addr], [Port] FROM [OprList]" UpdateCommand="UPDATE [OprList] SET [Title] = @Title, [Addr] = @Addr, [Port] = @Port WHERE [OperatorId] = @OperatorId">
            <DeleteParameters>
                <asp:Parameter Name="OperatorId" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="OperatorId" Type="Int32" />
                <asp:Parameter Name="Title" Type="String" />
                <asp:Parameter Name="Addr" Type="String" />
                <asp:Parameter Name="Port" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Title" Type="String" />
                <asp:Parameter Name="Addr" Type="String" />
                <asp:Parameter Name="Port" Type="Int32" />
                <asp:Parameter Name="OperatorId" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>

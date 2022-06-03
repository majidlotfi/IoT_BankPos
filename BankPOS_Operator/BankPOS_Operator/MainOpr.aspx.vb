Imports System.Data.SqlClient
Imports SSP1126.PcPos.BaseClasses
Imports SSP1126.PcPos.Infrastructure

Public Class MainOpr
    Inherits System.Web.UI.Page
    Dim SqlCon As SqlConnection, SqlCom As SqlCommand, SqlAdp As New SqlDataAdapter
    Dim pcMod As PcPosFactory
    Sub InitSqlCon()
        SqlCon = New SqlConnection(ConfigurationManager.ConnectionStrings("DbConStr").ConnectionString)
        SqlCon.Open()
        SqlCom = SqlCon.CreateCommand
        SqlAdp.SelectCommand = SqlCom
    End Sub
    Function GetTbl(QryStr As String) As DataTable
        Dim rt As New DataTable
        SqlCom.CommandText = QryStr
        SqlAdp.Fill(rt)
        Return rt
    End Function
    Sub DoQuert(QryStr As String)
        SqlCom.CommandText = QryStr
        SqlCom.ExecuteNonQuery()
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim DateVal As String = GetParam("Dater")
        If GetParam("op") = "GetPCPosData" Then
            InitSqlCon()
            Dim SpcPcPos As String = GetParam("SelDevice")
            Using tbl As DataTable = GetTbl("Select * From PCPosList " + IIf(Len(SpcPcPos) > 0, "Where PcPosId in (" + SpcPcPos + ")", ""))
                For Each Rw As DataRow In tbl.Rows
                    Using pcMod As New PcPosFactory
                        pcMod.SetLan(Rw("Addr"))
                        Dim posResult As PosResult = pcMod.GetReport(ReportAction.Sum, ReportFilterType.ByDate, DateVal, DateVal, Rw("Serial"), Rw("Terminal"), "", "")
                        DoQuert("Delete RepData Where OprRef=0 And PCPosRef=" + CStr(Rw("PcPosId")) + " And Dater='" + DateVal + "'")
                        DoQuert("Insert Into RepData (OprRef,PCPosRef,Dater,Amount) Select 0," + CStr(Rw("PcPosId")) + ",'" + DateVal + "'," + CStr(posResult.BillAmount))
                    End Using
                Next
            End Using
        End If
        If GetParam("op") = "GetSumData" Then
            InitSqlCon()
            Response.Clear()
            Response.ContentType = "text/xml"
            Using tblOpr As DataTable = GetTbl("Select * From RepData Where Dater='" + DateVal + "'")
                tblOpr.WriteXml(Response.OutputStream)
            End Using
            Response.End()
        End If
    End Sub
    Function GetParam(PrmName As String) As String
        Return Request.QueryString(PrmName)
    End Function
End Class
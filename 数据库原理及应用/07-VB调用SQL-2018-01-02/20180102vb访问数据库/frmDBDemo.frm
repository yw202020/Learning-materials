VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{CDE57A40-8B86-11D0-B3C6-00A0C90AEA82}#1.0#0"; "MSDATGRD.OCX"
Begin VB.Form frmDBDemo 
   Caption         =   "西南石油大学--数据库原理与应用--添加、删除、查询(含存储过程)"
   ClientHeight    =   5385
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   9120
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   5385
   ScaleWidth      =   9120
   StartUpPosition =   3  '窗口缺省
   Begin MSDataGridLib.DataGrid DataGrid1 
      Height          =   3015
      Left            =   0
      TabIndex        =   1
      Top             =   2160
      Width           =   8895
      _ExtentX        =   15690
      _ExtentY        =   5318
      _Version        =   393216
      HeadLines       =   1
      RowHeight       =   15
      BeginProperty HeadFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ColumnCount     =   2
      BeginProperty Column00 
         DataField       =   ""
         Caption         =   ""
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column01 
         DataField       =   ""
         Caption         =   ""
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      SplitCount      =   1
      BeginProperty Split0 
         BeginProperty Column00 
         EndProperty
         BeginProperty Column01 
         EndProperty
      EndProperty
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   2055
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8925
      _ExtentX        =   15743
      _ExtentY        =   3625
      _Version        =   393216
      TabHeight       =   520
      TabCaption(0)   =   "学生表"
      TabPicture(0)   =   "frmDBDemo.frx":0000
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Option1"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "Option2"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "Option3"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "txtStuNo"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "Combo1"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).Control(5)=   "Combo2"
      Tab(0).Control(5).Enabled=   0   'False
      Tab(0).Control(6)=   "txtStuName"
      Tab(0).Control(6).Enabled=   0   'False
      Tab(0).Control(7)=   "cmdQuery"
      Tab(0).Control(7).Enabled=   0   'False
      Tab(0).Control(8)=   "cmdExit"
      Tab(0).Control(8).Enabled=   0   'False
      Tab(0).ControlCount=   9
      TabCaption(1)   =   "专业表"
      TabPicture(1)   =   "frmDBDemo.frx":001C
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "Label1"
      Tab(1).Control(1)=   "Label2"
      Tab(1).Control(2)=   "txtMajorNo"
      Tab(1).Control(3)=   "txtMajorName"
      Tab(1).Control(4)=   "cmdAddMajor"
      Tab(1).Control(5)=   "cmdDeleteMajor"
      Tab(1).ControlCount=   6
      TabCaption(2)   =   "成绩表"
      TabPicture(2)   =   "frmDBDemo.frx":0038
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "Label3"
      Tab(2).Control(1)=   "Label4"
      Tab(2).Control(2)=   "txtNo"
      Tab(2).Control(3)=   "txtName"
      Tab(2).Control(4)=   "cmdFindScore"
      Tab(2).ControlCount=   5
      Begin VB.CommandButton cmdFindScore 
         Caption         =   "查询成绩"
         Height          =   375
         Left            =   -68160
         TabIndex        =   21
         Top             =   960
         Width           =   1455
      End
      Begin VB.TextBox txtName 
         Height          =   495
         Left            =   -70800
         TabIndex        =   20
         Top             =   960
         Width           =   1815
      End
      Begin VB.TextBox txtNo 
         Height          =   495
         Left            =   -73560
         TabIndex        =   18
         Top             =   960
         Width           =   1575
      End
      Begin VB.CommandButton cmdDeleteMajor 
         Caption         =   "删除专业"
         Height          =   495
         Left            =   -70800
         TabIndex        =   16
         Top             =   1320
         Width           =   1695
      End
      Begin VB.CommandButton cmdAddMajor 
         Caption         =   "添加专业"
         Height          =   495
         Left            =   -70800
         TabIndex        =   15
         Top             =   600
         Width           =   1695
      End
      Begin VB.TextBox txtMajorName 
         Height          =   375
         Left            =   -73320
         TabIndex        =   14
         Top             =   1080
         Width           =   1815
      End
      Begin VB.TextBox txtMajorNo 
         Height          =   375
         Left            =   -73320
         TabIndex        =   13
         Top             =   600
         Width           =   1935
      End
      Begin VB.CommandButton cmdExit 
         Caption         =   "退出"
         Height          =   375
         Left            =   6960
         TabIndex        =   10
         Top             =   1320
         Width           =   1575
      End
      Begin VB.CommandButton cmdQuery 
         Caption         =   "查询"
         Default         =   -1  'True
         Height          =   495
         Left            =   6960
         TabIndex        =   9
         Top             =   600
         Width           =   1695
      End
      Begin VB.TextBox txtStuName 
         Height          =   375
         Left            =   2400
         TabIndex        =   8
         Top             =   1440
         Width           =   1575
      End
      Begin VB.ComboBox Combo2 
         Height          =   300
         ItemData        =   "frmDBDemo.frx":0054
         Left            =   3960
         List            =   "frmDBDemo.frx":0064
         TabIndex        =   7
         Top             =   1080
         Width           =   1575
      End
      Begin VB.ComboBox Combo1 
         Height          =   300
         ItemData        =   "frmDBDemo.frx":0088
         Left            =   2400
         List            =   "frmDBDemo.frx":009E
         TabIndex        =   6
         Top             =   1080
         Width           =   1455
      End
      Begin VB.TextBox txtStuNo 
         Height          =   375
         Left            =   2400
         TabIndex        =   5
         Top             =   480
         Width           =   2175
      End
      Begin VB.OptionButton Option3 
         Caption         =   "姓名子查询"
         Height          =   255
         Left            =   360
         TabIndex        =   4
         Top             =   1440
         Width           =   1695
      End
      Begin VB.OptionButton Option2 
         Caption         =   "按照院系专业查询"
         Height          =   375
         Left            =   360
         TabIndex        =   3
         Top             =   960
         Width           =   1935
      End
      Begin VB.OptionButton Option1 
         Caption         =   "按学号模糊查询"
         Height          =   375
         Left            =   360
         TabIndex        =   2
         Top             =   480
         Value           =   -1  'True
         Width           =   1695
      End
      Begin VB.Label Label4 
         Caption         =   "姓名"
         Height          =   495
         Left            =   -71520
         TabIndex        =   19
         Top             =   960
         Width           =   1335
      End
      Begin VB.Label Label3 
         Caption         =   "学号"
         Height          =   495
         Left            =   -74760
         TabIndex        =   17
         Top             =   960
         Width           =   975
      End
      Begin VB.Label Label2 
         Caption         =   "专业名称"
         Height          =   375
         Left            =   -74640
         TabIndex        =   12
         Top             =   1080
         Width           =   1215
      End
      Begin VB.Label Label1 
         Caption         =   "专业编号"
         Height          =   375
         Left            =   -74640
         TabIndex        =   11
         Top             =   600
         Width           =   1575
      End
   End
End
Attribute VB_Name = "frmDBDemo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub executeSearch(sql As String)
    On Error GoTo errH
    Dim cnToMsSQL As New ADODB.Connection '定义数据库的连接
    Dim rsQuery As New ADODB.Recordset
    
   cnToMsSQL.ConnectionString = "Provider=SQLOLEDB.1;Server=127.0.0.1;User ID=stormstone;Password=stormstone;Persist Security Info=True;Initial Catalog=SwpuStu"
    cnToMsSQL.Open
    
    rsQuery.CursorLocation = adUseClient
    
    rsQuery.Open sql, cnToMsSQL, adOpenDynamic, adLockOptimistic
    
    Set DataGrid1.DataSource = rsQuery
    Exit Sub:
errH:
     MsgBox Err.Number & Err.Description, vbExclamation, "错误"
End Sub

Private Sub executeUpdate(sql As String)
    On Error GoTo errH
    Dim cnToMsSQL As New ADODB.Connection '定义数据库的连接
    
   cnToMsSQL.ConnectionString = "Provider=SQLOLEDB.1;Server=127.0.0.1;User ID=stormstone;Password=stormstone;Persist Security Info=True;Initial Catalog=SwpuStu"
    cnToMsSQL.Open
    Dim iRows As Integer
    cnToMsSQL.Execute sql, iRows
    If (iRows >= 0) Then
      MsgBox "成功插入/删除" & iRows & "行记录！", vbInformation, "提示"
    End If
    Exit Sub:
errH:
     MsgBox Err.Number & Err.Description, vbExclamation, "错误"
End Sub

Private Sub cmdAddMajor_Click()
  '添加专业
  Dim sSQL As String
  Dim searchSQL As String
  MsgBox txtMajorNo.Text & "  " & txtMajorName.Text
  sSQL = "Insert into Major values('" & txtMajorNo.Text & "','" & txtMajorName.Text & "')"
  Call executeUpdate(sSQL)
   searchSQL = "Select * From Major"
   Call executeSearch(searchSQL)
End Sub

Private Sub cmdDeleteMajor_Click()
  '删除专业
   MsgBox txtMajorNo.Text
  Dim sSQL As String
  Dim searchSQL As String
   sSQL = "Delete From Major Where cMajorNo ='" & txtMajorNo.Text & "' and vName = '" & txtMajorName.Text & "'"
   Call executeUpdate(sSQL)
   searchSQL = "Select * From Major"
   Call executeSearch(searchSQL)
End Sub

Private Sub cmdExit_Click()
   End
End Sub

Private Sub cmdFindScore_Click()
   Dim sSQL As String
  txtNo.Text = Trim(txtNo.Text)
  txtName.Text = Trim(txtName.Text)
  If Len(txtNo.Text) > 0 And Len(txtName.Text) > 0 Then
    '调用传姓名和学号的存储过程
    sSQL = "exec  prcFindByNoName  '" & txtNo.Text & "','" & txtName.Text & "'"
  ElseIf Len(txtNo.Text) > 0 Then
    '调用传入学号的存储过程
    MsgBox "学号" & txtNo.Text
    sSQL = "exec  prcFindByNo  '" & txtNo.Text & "'"
  ElseIf Len(txtName.Text) > 0 Then
    '调用传入姓名的存储过程
  MsgBox "姓名" & txtName.Text
    sSQL = "exec  prcFindByName  '" & txtName.Text & "'"
  End If
  
  '下面去调用executeUpdate
  Call executeUpdate(sSQL)
End Sub

Private Sub cmdQuery_Click()
   Dim strSQL As String
   If Option1.Value = True Then
     '按照学号查询
     MsgBox "学号" & txtStuNo.Text
     strSQL = "Select * from Student where cNo like '%" & txtStuNo.Text & "%'"
   ElseIf Option2.Value = True Then
     '按照院系专业
     MsgBox Combo1.Text & "  " & Combo2.Text
     strSQL = "Select * From Student Where cDepartNo = '" & Combo1.Text & "' and cMajorNo = '" & Combo2.Text & "'"
   Else
     '按照姓名查询
     MsgBox txtStuName.Text
     strSQL = "Select * From Student Where cMajorNo=(Select cMajorNo From Student Where vName='" & txtStuName.Text & "')and iGrade = (Select iGrade From Student Where vName='" & txtStuName.Text & "')"
   End If
     
   Call executeSearch(strSQL)
End Sub

Private Sub Form_Load()
  Combo1.ListIndex = 0
  Combo2.ListIndex = 0
End Sub

Private Sub Form_Resize()
  If Me.Width < 9900 Or Me.Height < 6900 Then
     Me.Width = 9900
     Me.Height = 6900
     Exit Sub
   End If
   DataGrid1.Width = Me.Width - DataGrid1.Left - 300
   DataGrid1.Height = Me.Height - DataGrid1.Top - 600
End Sub


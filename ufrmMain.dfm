object frmMain: TfrmMain
  Left = 192
  Top = 114
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '32'#20301'PE'#25991#20214#22320#22336#36716#25442#24037#20855
  ClientHeight = 447
  ClientWidth = 351
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 337
    Height = 49
    Caption = 'File'
    TabOrder = 0
    object Edit1: TEdit
      Left = 8
      Top = 16
      Width = 281
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ReadOnly = True
      TabOrder = 0
    end
    object Button1: TButton
      Left = 296
      Top = 16
      Width = 33
      Height = 21
      Caption = '------'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 64
    Width = 337
    Height = 137
    Caption = 'Section'
    TabOrder = 1
    object ListView1: TListView
      Left = 8
      Top = 16
      Width = 321
      Height = 113
      Columns = <
        item
          Caption = 'Name'
        end
        item
          Caption = 'VSize'
        end
        item
          Caption = 'VAddress'
        end
        item
          Caption = 'ROffset'
        end
        item
          Caption = 'RSize'
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 208
    Width = 337
    Height = 113
    Caption = 'Arg'
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 53
      Height = 13
      Caption = 'ImageBase'
    end
    object Label2: TLabel
      Left = 8
      Top = 56
      Width = 82
      Height = 13
      Caption = 'SectionAlignment'
    end
    object Label3: TLabel
      Left = 8
      Top = 88
      Width = 63
      Height = 13
      Caption = 'FileAlignment'
    end
    object Edit2: TEdit
      Left = 96
      Top = 16
      Width = 233
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 0
    end
    object Edit3: TEdit
      Left = 96
      Top = 48
      Width = 233
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ReadOnly = True
      TabOrder = 1
    end
    object Edit4: TEdit
      Left = 96
      Top = 80
      Width = 233
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ReadOnly = True
      TabOrder = 2
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 328
    Width = 337
    Height = 113
    Caption = 'Conver'
    TabOrder = 3
    object Label5: TLabel
      Left = 8
      Top = 24
      Width = 26
      Height = 13
      Caption = 'Offet'
    end
    object Label6: TLabel
      Left = 8
      Top = 56
      Width = 20
      Height = 13
      Caption = 'RVA'
    end
    object Label7: TLabel
      Left = 8
      Top = 88
      Width = 13
      Height = 13
      Caption = 'VA'
    end
    object Edit5: TEdit
      Left = 96
      Top = 16
      Width = 97
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 0
      Text = '1ABC'
    end
    object Edit6: TEdit
      Left = 96
      Top = 48
      Width = 97
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 1
      Text = '1ABC'
    end
    object Edit7: TEdit
      Left = 96
      Top = 80
      Width = 97
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 2
      Text = '1ABC'
    end
    object Button2: TButton
      Left = 200
      Top = 16
      Width = 33
      Height = 21
      Caption = 'Do'
      TabOrder = 3
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 200
      Top = 48
      Width = 33
      Height = 21
      Caption = 'Do'
      TabOrder = 4
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 200
      Top = 80
      Width = 33
      Height = 21
      Caption = 'Do'
      TabOrder = 5
      OnClick = Button4Click
    end
    object Edit8: TEdit
      Left = 240
      Top = 16
      Width = 89
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 6
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 88
    Top = 120
  end
end

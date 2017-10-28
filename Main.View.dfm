object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Main'
  ClientHeight = 191
  ClientWidth = 429
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 429
    Height = 191
    Align = alClient
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 240
      Top = 66
      Width = 30
      Height = 19
      Caption = 'Host'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Sitka Text'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 361
      Top = 66
      Width = 34
      Height = 19
      Caption = 'Porta'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Sitka Text'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 27
      Top = 66
      Width = 51
      Height = 19
      Caption = 'Usu'#225'rio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Sitka Text'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 27
      Top = 119
      Width = 38
      Height = 19
      Caption = 'Senha'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Sitka Text'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button1: TButton
      Left = 240
      Top = 135
      Width = 161
      Height = 28
      Caption = 'Iniciar'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edt_Porta: TEdit
      Left = 361
      Top = 85
      Width = 40
      Height = 21
      MaxLength = 3
      TabOrder = 4
    end
    object Edt_Senha: TEdit
      Left = 27
      Top = 138
      Width = 121
      Height = 21
      MaxLength = 16
      PasswordChar = '*'
      TabOrder = 2
    end
    object Edt_User: TEdit
      Left = 27
      Top = 85
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 427
      Height = 41
      Align = alTop
      Caption = 'DADOS PARA ENVIO'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 5
    end
    object Panel3: TPanel
      Left = 1
      Top = 42
      Width = 427
      Height = 7
      Align = alTop
      Color = clMaroon
      ParentBackground = False
      TabOrder = 6
    end
    object Edt_Host: TEdit
      Left = 240
      Top = 85
      Width = 121
      Height = 21
      TabOrder = 3
    end
  end
end

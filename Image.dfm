object ImageFromFolder: TImageFromFolder
  Left = 0
  Top = 0
  Caption = #169' '#1055#1077#1090#1088#1086#1074' '#1040#1085#1076#1088#1077#1081' '#1076#1083#1103' C&R Systems '
  ClientHeight = 540
  ClientWidth = 580
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl2: TLabel
    Left = 59
    Top = 112
    Width = 83
    Height = 13
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1072#1087#1082#1091
  end
  object lst1: TListBox
    Left = 48
    Top = 144
    Width = 233
    Height = 241
    ItemHeight = 13
    TabOrder = 0
    OnDblClick = lst1DblClick
  end
  object btnSelectFolder: TButton
    Left = 176
    Top = 76
    Width = 89
    Height = 25
    Caption = #1042#1099#1073#1088#1072#1090#1100' '#1087#1072#1087#1082#1091
    TabOrder = 1
    OnClick = btnSelectFolderClick
  end
end

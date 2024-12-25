object pageTask: TpageTask
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Tarefa'
  ClientHeight = 137
  ClientWidth = 874
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 19
    Width = 39
    Height = 15
    Caption = 'C'#243'digo'
  end
  object Label2: TLabel
    Left = 152
    Top = 19
    Width = 45
    Height = 15
    Caption = 'Desri'#231#227'o'
  end
  object Label3: TLabel
    Left = 16
    Top = 67
    Width = 54
    Height = 15
    Caption = 'Prioridade'
  end
  object Label4: TLabel
    Left = 152
    Top = 67
    Width = 32
    Height = 15
    Caption = 'Status'
  end
  object Edit_id: TEdit
    Left = 16
    Top = 40
    Width = 121
    Height = 23
    ImeName = 'Edit_id'
    NumbersOnly = True
    TabOrder = 0
  end
  object Edit_description: TEdit
    Left = 152
    Top = 40
    Width = 721
    Height = 23
    ImeName = 'Edit_description'
    TabOrder = 1
  end
  object ComboBox1_priority: TComboBox
    Left = 16
    Top = 88
    Width = 121
    Height = 23
    Style = csDropDownList
    TabOrder = 2
    Items.Strings = (
      'Baixa'
      'Media'
      'Alta'
      '')
  end
  object ComboBox_status: TComboBox
    Left = 152
    Top = 88
    Width = 121
    Height = 23
    Style = csDropDownList
    TabOrder = 3
  end
  object Button_salvar: TButton
    Left = 798
    Top = 87
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 4
    OnClick = Button_salvarClick
  end
end

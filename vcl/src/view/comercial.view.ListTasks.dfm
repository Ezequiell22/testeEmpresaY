object pageListTasks: TpageListTasks
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Listagem de tarefas'
  ClientHeight = 612
  ClientWidth = 462
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object Button_buscar: TButton
    Left = 250
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Buscar'
    TabOrder = 0
    OnClick = Button_buscarClick
  end
  object Button_novo: TButton
    Left = 1
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Nova'
    TabOrder = 1
    OnClick = Button_novoClick
  end
  object Button_deletar: TButton
    Left = 169
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Deletar'
    TabOrder = 2
    OnClick = Button_deletarClick
  end
  object Button_editar: TButton
    Left = 84
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Editar'
    TabOrder = 3
    OnClick = Button_editarClick
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 50
    Width = 462
    Height = 562
    Align = alBottom
    TabOrder = 4
  end
end

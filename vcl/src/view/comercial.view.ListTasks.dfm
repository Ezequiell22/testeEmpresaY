object pageListTasks: TpageListTasks
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Listagem de tarefas'
  ClientHeight = 612
  ClientWidth = 783
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object Label1: TLabel
    Left = 64
    Top = 63
    Width = 125
    Height = 15
    Caption = 'N'#250'mero total de tarefas'
  end
  object Label2: TLabel
    Left = 64
    Top = 87
    Width = 223
    Height = 15
    Caption = 'M'#233'dia de prioridade das tarefas pendentes'
  end
  object Label3: TLabel
    Left = 64
    Top = 111
    Width = 274
    Height = 15
    Caption = 'Quantidade de tarefas conclu'#237'das nos '#250'ltimos 7 dias'
  end
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
    Top = 146
    Width = 785
    Height = 466
    TabOrder = 4
  end
  object Edit_allQtd: TEdit
    Left = 9
    Top = 60
    Width = 49
    Height = 23
    TabOrder = 5
  end
  object Edit_avgPriority: TEdit
    Left = 9
    Top = 84
    Width = 49
    Height = 23
    TabOrder = 6
  end
  object Edit3_qtdDone: TEdit
    Left = 9
    Top = 108
    Width = 49
    Height = 23
    TabOrder = 7
  end
end

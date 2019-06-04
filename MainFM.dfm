object fmUntrackMe: TfmUntrackMe
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'Untrack Me'
  ClientHeight = 48
  ClientWidth = 1117
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesigned
  OnShow = FormShow
  DesignSize = (
    1117
    48)
  PixelsPerInch = 96
  TextHeight = 13
  object mFrom: TMemo
    Left = 0
    Top = 0
    Width = 1117
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object mTo: TMemo
    Left = 0
    Top = 24
    Width = 1117
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object jcm: TJvClipboardMonitor
    OnChange = jcmChange
    Left = 304
    Top = 6
  end
end

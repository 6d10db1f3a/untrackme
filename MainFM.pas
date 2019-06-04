unit MainFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  JvComponentBase, JvClipboardMonitor;

type
  TfmUntrackMe = class(TForm)
    mFrom: TMemo;
    mTo: TMemo;
    jcm: TJvClipboardMonitor;
    procedure jcmChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Source: String;
    { Private declarations }
    function has(s: String; in_s: String = ''): Integer; // return pos s in_s
    function has_(s: String; in_s: String = ''): Integer; // return pos s in_s + length(s)
    function has_b(s: String; in_s: String = ''): boolean; // return pos (s in_s) > 0
    procedure setto(s: String); // set Source to s
    function getfrom(s: string = ''; i: integer = 1): string; // Copy(from [Source[i]] to end)
    function getto(s:String = ''; i: integer = -1): string; // Copy(from 1 to [Source[i]])
  public
    { Public declarations }
  end;

var
  fmUntrackMe: TfmUntrackMe;

implementation

uses ClipBrd, IdUri;

{$R *.dfm}


function DesktopSize: TRect;
var
  r : TRect;
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, @r, 0);
  Result := r;
end;

procedure TfmUntrackMe.FormShow(Sender: TObject);
begin
  Top := DesktopSize.Bottom - Height;
  Left := DesktopSize.Right - Width;
end;

function TfmUntrackMe.getfrom(s: string = ''; i: integer = 1): string;
begin
  if s = '' then  s := Source;
  Result := Copy(s, i, length(Source) - i);
end;

function TfmUntrackMe.getto(s: string = ''; i: integer = -1): string;
begin
  if s = '' then  s := Source;
  if i = -1 then  i := length(s);
  Result := Copy(s, 1, i);
end;

function TfmUntrackMe.has(s: String; in_s: String): Integer;
begin
  if in_s = '' then  in_s := Source;
  Result := pos(s, in_s);
end;

function TfmUntrackMe.has_(s: String; in_s: String): Integer;
begin
  Result := 0;
  if in_s = '' then  in_s := Source;
  if has(s) > 0 then
    Result := has(s) + length(s)
end;

function TfmUntrackMe.has_b(s, in_s: String): boolean;
begin
  Result := false;
  if has(s) > 0 then
    Result := true;
end;

procedure TfmUntrackMe.jcmChange(Sender: TObject);
var p: Integer;
begin
  try
    if not Clipboard.HasFormat(CF_TEXT) then
      Exit;
    Source := Clipboard.AsText;
    mFrom.Text := Source;
    mTo.Color := clRed;

    if not has_b('http') then
      Exit;

    if has_b('fbclid') then
    begin
      setto(getto('', has('fbclid') - 2));
    end;

    setto(Source.Replace('m.facebook.com', 'facebook.com'));

    if has_b('https://facebook.com') and  has_b('?acontext') then
    begin
      setto(getto(getfrom('', has('https://facebook.com')), has('?acontext') - has('https://facebook.com')));
    end;
    if has_b('facebook.com') and has_b('&set=') then
    begin
      setto(getto('', has('&set=') - 1));
    end;
    if has_b('facebook.com') and has_b('?type=') then
    begin
      setto(getto('', has('?type=') - 1));
    end;

    if has_b('utm_source=') then
    begin
      setto(getto('', has('utm_source=') - 2));
    end;


    if has_b('l.php?u=') then
    begin
      setto(TIdURI.URLDecode(getfrom('', has_('l.php?u='))));
    end;

    if has_b('google.com') and has_b('&sa=D&source') and has_b('url?q=') then
    begin
      setto(getto(getfrom('', has_('url?q=')), has('&sa=D&source')-has_('url?q=')));
    end;

    if has_b('google.com') and has_b('url?q=') then
    begin
      setto(getfrom('', has_('url?q=')));
    end;

    Clipboard.AsText := Source;
  except on E: Exception do
  end;
end;

procedure TfmUntrackMe.setto(s: String);
begin
  Source := s;
  mTo.Text := Source;
  mTo.Color := clGreen;
end;

end.

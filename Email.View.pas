//Trabalho de Lucas Hollas de Cairos
unit Email.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,

  IniFiles,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdBaseComponent,
  IdMessage,
  // IdExplicitTLSClientServerBase,
  IdMessageClient,
  IdSMTPBase,
  IdSMTP,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  // IdSSL,
  // IdSSLOpenSSL,
  IdAttachmentFile,
  IdText;

type
  TfrmEmail = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    Btn_Limpar: TButton;
    Button1: TButton;
    BtnAnexo: TButton;
    Edt_nome: TEdit;
    edtAnexo: TEdit;
    edtAssunto: TEdit;
    EdtPara: TEdit;
    memCorpo: TMemo;
    BtnDesconecta: TButton;
    Panel3: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure BtnAnexoClick(Sender: TObject);
    procedure BtnDesconectaClick(Sender: TObject);
  private
    { Private declarations }
    function EnviarEmail(const AAssunto, ADestino, AAnexo: String;
      ACorpo: TStrings): Boolean;
  public
    { Public declarations }
   procedure limparcampos;
  end;

var
  frmEmail: TfrmEmail;


implementation

{$R *.dfm}

uses Main.View;

procedure TfrmEmail.Button1Click(Sender: TObject);
begin
if edtPara.Text = '' then
  begin
    showmessage('Por Favor, Digite o Destinat�rio!');
  end
  else if Edt_nome.Text = '' then
  begin
    showmessage('Por Favor, Digite a Sua Identifica��o');
  end;

  if EnviarEmail(edtAssunto.Text, edtPara.Text, edtAnexo.Text, memCorpo.Lines)
  then
    showmessage('Enviado com sucesso!')
  else
    showmessage('N�o foi poss�vel enviar o e-mail!');
end;

procedure TfrmEmail.BtnAnexoClick(Sender: TObject);

begin
  with TOpenDialog.Create(Self) do
    if Execute then
      edtAnexo.Text := FileName;
end;

procedure TfrmEmail.BtnDesconectaClick(Sender: TObject);
begin
  limparcampos;
  frmMain.Edt_Host.Text := '';
  frmMain.Edt_Porta.Text := '';
  frmMain.Edt_User.Text := '';
  frmMain.Edt_Senha.Text := '';

  frmMain.Visible := true;
  frmEmail.Close;
end;

function TfrmEmail.EnviarEmail(const AAssunto, ADestino, AAnexo: String;
  ACorpo: TStrings): Boolean;
var
  IniFile: TIniFile;
  sFrom: String;
  sBccList: String;
  sHost: String;
  iPort: Integer;
  sUserName: String;
  sPassword: String;

  idMsg: TIdMessage;
  IdText: TIdText;
  IdSMTP: TIdSMTP;
  // idSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;
begin

  try
    try
      // Cria��o e leitura do arquivo INI com as configura��es
      // IniFile                          := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.ini');
      // sFrom                            := IniFile.ReadString('Email' , 'From'     , sFrom);
      // sBccList                         := IniFile.ReadString('Email' , 'BccList'  , sBccList);
      // sHost                            := IniFile.ReadString('Email' , 'Host'     , sHost);
      // iPort                            := IniFile.ReadInteger('Email', 'Port'     , iPort);
      // sUserName                        := IniFile.ReadString('Email' , 'UserName' , sUserName);
      // sPassword                        := IniFile.ReadString('Email' , 'Password' , sPassword);
      sFrom := frmMain.Edt_User.Text;
      sBccList := 'acclucash@gmail.com';
      sHost := frmMain.Edt_Host.Text;
      iPort := strtoint(frmMain.Edt_Porta.Text);
      sUserName := frmMain.Edt_User.Text;
      sPassword := frmMain.Edt_Senha.Text;
      // Configura os par�metros necess�rios para SSL
      // IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
      // IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      // IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;

      // Vari�vel referente a mensagem
      idMsg := TIdMessage.Create(Self);
      idMsg.CharSet := 'utf-8';
      idMsg.Encoding := meMIME;
      idMsg.From.Name := Edt_nome.Text;
      idMsg.From.Address := sFrom;
      idMsg.Priority := mpNormal;
      idMsg.Subject := AAssunto;

      // Add Destinat�rio(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;
      idMsg.CCList.EMailAddresses := 'acclucash@gmail.com';
      idMsg.BccList.EMailAddresses := sBccList;
      idMsg.BccList.EMailAddresses := 'acclucash@gmail.com'; // C�pia Oculta

      // Vari�vel do texto
      IdText := TIdText.Create(idMsg.MessageParts);
      IdText.Body.Add(ACorpo.Text);
      IdText.ContentType := 'text/html; text/plain; charset=iso-8859-1';

      // Prepara o Servidor
      IdSMTP := TIdSMTP.Create(Self);
      // idSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      // idSMTP.UseTLS                    := utUseImplicitTLS;
      IdSMTP.AuthType := satDefault;
      IdSMTP.Host := sHost;
      IdSMTP.AuthType := satDefault;
      IdSMTP.Port := iPort;
      IdSMTP.Username := sUserName;
      IdSMTP.Password := sPassword;

      // Conecta e Autentica
      IdSMTP.Connect;
      IdSMTP.Authenticate;

      if AAnexo <> EmptyStr then
        if FileExists(AAnexo) then
          TIdAttachmentFile.Create(idMsg.MessageParts, AAnexo);

      // Se a conex�o foi bem sucedida, envia a mensagem
      if IdSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except
          on E: Exception do
          begin
            showmessage('Erro ao tentar enviar: ' + E.Message);
          end;
        end;
      end;

      // Depois de tudo pronto, desconecta do servidor SMTP
      if IdSMTP.Connected then
        IdSMTP.Disconnect;

      Result := true;
    finally
      // IniFile.Free;

      // UnLoadOpenSSLLibrary;

      FreeAndNil(idMsg);
      // FreeAndNil(idSSLIOHandlerSocket);
      FreeAndNil(IdSMTP);
    end;
  except
    on E: Exception do
    begin
      Result := False;
    end;
  end;
end;

procedure TfrmEmail.limparcampos;
begin
  Edt_nome.Text := '';
  memCorpo.Text := '';
  edtPara.Text := '';
  edtAssunto.Text := '';
  edtAnexo.Text := '';
end;

end.

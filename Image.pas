unit Image;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FileCtrl, Vcl.StdCtrls,
  ShellAPI;

type
  TImageFromFolder = class(TForm)
    lst1: TListBox;
    btnSelectFolder: TButton;
    lbl2: TLabel;
    procedure btnSelectFolderClick(Sender: TObject);
    procedure lst1DblClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure openImage(Path: string);
    function SlashSep(Path, FName: string): string;
    procedure ScanFolder(Folder: string);
  end;


  TScanThread = class(TThread)
    private
    { Private declarations }
  protected
    procedure Execute; override;
  end;


var
  ImageFromFolder: TImageFromFolder;
   ScanThread: TScanThread;
  PathtoFolder: string;

implementation

{$R *.dfm}

function TImageFromFolder.SlashSep(Path, FName: string): string;
begin
  if Path[Length(Path)] <> '\' then
    Result := Path + '\' + FName
  else
    Result := Path + FName;
end;


procedure TScanThread.Execute;
begin
  ImageFromFolder.ScanFolder(PathtoFolder);
end;

procedure TImageFromFolder.ScanFolder(Folder: string);
var
  sr: TSearchRec;
  FileName: string;
  Attr: Integer;
begin
  if FindFirst(Folder + '\*.*', faAnyFile, sr) = 0 then  // ���� ����� � �����
  begin
    repeat
      if (sr.Name = '.') or (sr.Name = '..') then
        continue;
      FileName := SlashSep(Folder, sr.Name);

 // ��� ����� ��� ���
      if (sr.Attr and faDirectory) = faDirectory then
      begin
        ScanFolder(FileName);
        continue;
      end;
      if (ExtractFileExt(sr.Name) = '.bmp') or (ExtractFileExt(sr.Name) = '.jpg') then
      begin
        lst1.Items.Add(FileName);

      end;
    until FindNext(sr) <> 0;

  end;

  FindClose(sr);
end;

procedure TImageFromFolder.btn1Click(Sender: TObject);
begin
  ScanFolder(PathtoFolder);
end;

procedure TImageFromFolder.btnSelectFolderClick(Sender: TObject);
var
  Files: string;
begin
  lst1.Clear;
  SetLength(Files, 0);
  //���� � �����, � ������� ����� ���������� �����. ��������� �������� ��������
  //������ ����� �
  if PathtoFolder = 'C:\' then
    PathtoFolder := ExtractFilePath(ParamStr(0));
  //������ ������ �����.
  if not SelectDirectory('����� �����', '', PathtoFolder) then
    Exit;
  PathtoFolder := IncludeTrailingPathDelimiter(PathtoFolder);  //���� �������� ���� �����������, �� ��������� ���.
  ScanThread:=TScanThread.Create(false);
  ScanThread.Priority:=tpNormal;
end;

procedure TImageFromFolder.lst1DblClick(Sender: TObject);
begin
  openImage((lst1.Items[lst1.ItemIndex]));
end;



procedure TImageFromFolder.openImage(Path: string);
var
  Command: string;
  Info: TShellExecuteInfo;
  MyFilename: string;
begin
  FillChar(Info, SizeOf(Info), #0);
  Info.cbSize := SizeOf(Info);
  Info.fMask := SEE_MASK_DEFAULT;
  Info.lpFile := PWideChar(Path);
  Info.nShow := SW_NORMAL;
  Win32Check(ShellExecuteEx(@Info));
end;

end.


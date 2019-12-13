unit ufrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ufrmdrag;

type
  TfrmMain = class(TfrmDrag)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Button1: TButton;
    GroupBox2: TGroupBox;
    ListView1: TListView;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Edit4: TEdit;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    Edit5: TEdit;
    Label6: TLabel;
    Edit6: TEdit;
    Label7: TLabel;
    Edit7: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    Edit8: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    procedure DoDragDropFile(sPath: string); override;
    procedure LoadFile(sPath: string);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

type
  Section = record
    sName: string; //区段名称
    VSize: Cardinal; //区段实际映射在内存对齐后后所占用的尺寸
    VAddress: Cardinal; //区段映射在内存后的RVA地址
    ROffset: Cardinal; //区段在文件中的偏移
    RSize: Cardinal; //区段在文件中对齐后的尺寸
  end;

var
  outFile: file of Byte;
  stSection: array of Section;

function ReadDWORD(iSeek: Cardinal): Cardinal; //在指定位置读取一个DWORD
var
  bBuf: array[0..3] of Byte;
begin
  try
    Seek(outFile, iSeek);
    read(outFile, bBuf[0], bBuf[1], bBuf[2], bBuf[3]);
    Move(bBuf, Result, 4);
  except
    on EInOutError do
      ShowMessage('文件读取出现错误！');
    else
      raise;
  end;
end;

function ReadWORD(iSeek: Cardinal): Word; //在指定位置读取一个WORD
var
  bBuf: array[0..1] of Byte;
begin
  try
    Seek(outFile, iSeek);
    read(outFile, bBuf[0], bBuf[1]);
    Move(bBuf, Result, 2);
  except
    on EInOutError do
      ShowMessage('文件读取出现错误！');
    else
      raise;
  end;
end;

function ReadString(iSeek: Cardinal): string; //在指定位置读入一个8BYTE的ANSI字符串
var
  sStr: string;
  bCh: Byte;
begin
  try
    Seek(outFile, iSeek);
    read(outFile, bCh);
    while bCh <> 0 do
    begin
      sStr := sStr + Char(bCh);
      read(outFile, bCh);
    end;
    Result := sStr;
  except
    on EInOutError do
      ShowMessage('文件读取出现错误！');
    else
      raise;
  end;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Edit1.Text := OpenDialog1.FileName;
    LoadFile(Edit1.Text);
  end;
end;

procedure TfrmMain.LoadFile(sPath: string);
var
  iPe: Cardinal; //PE头的开始地址
  iSection: Cardinal; //区段表的开始地址
  iSecCount: Cardinal; //区段数目
  i: Cardinal;
begin
  AssignFile(outFile, Edit1.Text);
  FileMode := fmOpenRead;
  Reset(outFile);
  iPe := ReadDWORD($3C); //读取PE文件头在文件中的位置
  Edit2.Text := '$' + IntToHex(ReadDWORD(iPe + $34), 4); //读取ImageBase字段
  Edit3.Text := '$' + IntToHex(ReadDWORD(iPe + $38), 4); //读取区段在内存中的对齐值
  Edit4.Text := '$' + IntToHex(ReadDWORD(iPe + $3C), 4); //读取区段在文件中的对齐值
  iSection := iPe + $18 + ReadWORD(iPe + $14); //取区段表所在文件偏移
  iSecCount := ReadWORD(iPe + $6); //读取区段数目
  SetLength(stSection, iSecCount);
  for i := 0 to iSecCount - 1 do //循环读取所有区段
  begin
    stSection[i].sName := ReadString(iSection + 40 * i); //读取区段名称
    stSection[i].VAddress := ReadDWORD(iSection + 40 * i + 12); //读取区段映射后的RVA地址
    stSection[i].RSize := ReadDWORD(iSection + 40 * i + 16); //读取区段经过文件对齐后的尺寸
    stSection[i].ROffset := ReadDWORD(iSection + i * 40 + 20); //读取区段在文件中的偏移地址
    stSection[i].VSize := ((stSection[i].RSize div Cardinal(StrToInt(Edit3.Text))) + 1) * Cardinal(StrToInt(Edit3.Text));
    //读取区段在内存中对齐后的尺寸
  end;
  ListView1.Clear;
  for i := Low(stSection) to High(stSection) do //显示读取出来的所有区块
  begin
    with ListView1.Items.Add do
    begin
      Caption := stSection[i].sName;
      SubItems.Add(IntToHex(stSection[i].VSize, 4));
      SubItems.Add(IntToHex(stSection[i].VAddress, 4));
      SubItems.Add(IntToHex(stSection[i].ROffset, 4));
      SubItems.Add(IntToHex(stSection[i].RSize, 4));
    end;
  end;
  CloseFile(outFile); //关闭文件
end;


procedure TfrmMain.Button2Click(Sender: TObject);
var
  i: Integer;
  iOffset: Cardinal;
  k: Cardinal;
  iBase: Cardinal;
begin
  iOffset := StrToInt('$' + Edit5.Text);
  iBase := StrToInt(Edit2.Text); //取出映射基地址
  for i := Low(stSection) to High(stSection) do
  begin
    if (iOffset >= stSection[i].ROffset) and (iOffset <= stSection[i].ROffset + stSection[i].RSize) then
    begin
      k := stSection[i].VAddress - stSection[i].ROffset;
      Edit6.Text := IntToHex(k + iOffset, 8); //得出RVA地址
      Edit7.Text := IntToHex(k + iOffset + iBase, 8); //得出VA地址
      Edit8.Text := stSection[i].sName;
      Exit;
    end;
  end;
  Edit5.Text := '';
  Edit6.Text := '';
  Edit7.Text := '';
  ShowMessage('转换失败！');
end;

procedure TfrmMain.Button3Click(Sender: TObject);
var
  i: Integer;
  iRVA: Cardinal;
  k: Cardinal;
  iBase: Cardinal;
begin
  iBase := StrToInt(Edit2.Text); //取出映射基地址
  iRVA := StrToInt('$' + Edit6.Text);
  for i := Low(stSection) to High(stSection) do
  begin
    if (iRVA >= stSection[i].VAddress) and (iRVA <= stSection[i].VAddress + stSection[i].RSize) then
    begin
      k := stSection[i].VAddress - stSection[i].ROffset;
      Edit5.Text := IntToHex(iRVA - k, 8);
      Edit7.Text := IntToHex(iRVA + iBase, 8);
      Edit8.Text := stSection[i].sName;
      Exit;
    end;
  end;
  Edit5.Text := '';
  Edit6.Text := '';
  Edit7.Text := '';
  ShowMessage('转换失败！');
end;

procedure TfrmMain.Button4Click(Sender: TObject);
var
  iBase: Cardinal;
begin
  iBase := StrToInt(Edit2.Text); //取出映射基地址
  Edit6.Text := IntToHex(Cardinal(StrToInt('$' + Edit7.Text)) - iBase, 8);
  Button3.Click;
end;

procedure TfrmMain.DoDragDropFile(sPath: string);
begin
  Edit1.Text := sPath;
  LoadFile(sPath);
end;

end.

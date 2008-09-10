(**
  
  This module contains a class which represent a form for defining the option
  for Documentation.

  @Version 1.0
  @Author  David Hoyle
  @Date    06 Sep 2008

**)
unit DocumentationOptionsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DocumentationDispatcher;

type
  (** A class to represent the form interface. **)
  TfrmDocumentationOptions = class(TForm)
    rgpDocumentationOptions: TRadioGroup;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
    Class Function Execute(var ADocType : TDocType) : Boolean;
  end;

implementation

{$R *.dfm}

{ TfrmDocumentationOptions }

(**



  @precon  None.
  @postcon Returns the documentation type require in the var parameter if the
           dialogue is accepted while returning true, else returns false.


  @return  a Boolean

**)
class function TfrmDocumentationOptions.Execute(var ADocType: TDocType): Boolean;

Var
  i : TDocType;

begin
  Result := False;
  With TfrmDocumentationOptions.Create(Nil) Do
    Try
      For i := Low(TDocType) to High(TDocType) Do
        rgpDocumentationOptions.Items.Add(strDocumentationTypes[i]);
      rgpDocumentationOptions.ItemIndex := Byte(ADocType);
      If ShowModal = mrOK Then
        Begin
          ADocType := TDocType(rgpDocumentationOptions.ItemIndex);
          Result := True;
        End;
    Finally
      Free;
    End;
end;

end.
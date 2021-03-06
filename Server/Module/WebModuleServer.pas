unit WebModuleServer;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, UniProvider, MySQLUniProvider,
  Data.DB, MemDS, DBAccess, Uni;

type
  TWebModule1 = class(TWebModule)
    ConnectionDB: TUniConnection;
    SQL: TUniSQL;
    Query: TUniQuery;
    MySQLUniProviderDB: TMySQLUniProvider;
    spex: TUniStoredProc;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1GetDataAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1PostDataAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1PutDataAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1DeleteDataAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses fMain;

{$R *.dfm}

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content :=
    '<html>' +
    '<head><title>Web Server Application</title></head>' +
    '<h1>Web Server Application</h1>' +
    '<body>Menampilkan Data</body></br>' +
    '<body>Get Data URL :  <a href="http://localhost:8080/Get">https://localhost:8080/Get</a></body></br></br>' +
    '<body>Menambah Data</body></br>' +
    '<body>Post Data URL :  <a href="http://localhost:8080/Post">https://localhost:8080/Post</a></body></br></br>' +
    '<body>Merubah Data</body></br>' +
    '<body>Put Data URL :  <a href="http://localhost:8080/Put">https://localhost:8080/Put</a></body></br></br>' +
    '<body>Menghapus Data</body></br>' +
    '<body>Delete Data URL :  <a href="http://localhost:8080/Delete">https://localhost:8080/Delete</a></body></br></br>' +
    '</html>';
end;

procedure TWebModule1.WebModule1DeleteDataAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
if (length(Request.ContentFields.Values['fNK']) > 0) then
     begin
       //Form1.CreateLog('Update: ' + Request.ContentFields.Values['fUser_create'] + 'Berhasil');
       //Form1.CreateRequest(Request.ContentFields.Text);
         with spex do
         begin
           SQL.Clear;
           CreateProcCall('tbl_karyawan.tbl_delete');
           ParamByName('fNk').AsString := Request.ContentFields.Values['fNK'];
           ParamByName('fUser_create').AsString := Request.ContentFields.Values['fUser_create'];
           Execute;
         end;

        Response.ContentType := 'application/json; charset=utf-8';
        Response.Content := '{code:200,description:update data berhasil}';
     end
     else
     begin
        //Form1.CreateLog('Insert: ' + Request.ContentFields.Values['fUser_create'] + 'Gagal');
        //Form1.CreateRequest(Request.ContentFields.Text);
        Response.ContentType := 'application/json; charset=utf-8';
        Response.Content := '{"code":"21","description":"error body - tidak boleh ada data kosong"}';
     end;
end;

procedure TWebModule1.WebModule1GetDataAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  if Request.QueryFields.Values['user'] = '' then
    begin
    with Query  do
      begin
        SQL.Clear;
        SQL.Text := 'SELECT db_json_view() as datauser';
        Execute;

        Response.ContentType := 'application/json; charset=utf-8';
        Response.Content := Fields.Fields[0].AsString;
      end;

    end;
end;

procedure TWebModule1.WebModule1PostDataAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  if (length(Request.ContentFields.Values['fNK']) > 0) and (length(Request.ContentFields.Values['fNama']) > 0) and (length(Request.ContentFields.Values['fAlamat']) > 0) then
     begin
       //Form1.CreateLog('Update: ' + Request.ContentFields.Values['fUser_create'] + 'Berhasil');
       //Form1.CreateRequest(Request.ContentFields.Text);
         with spex do
         begin
           SQL.Clear;
           CreateProcCall('tbl_karyawan.tbl_create');
           ParamByName('fNk').AsString := Request.ContentFields.Values['fNK'];
           ParamByName('fNama').AsString := Request.ContentFields.Values['fNama'];
           ParamByName('fAlamat').AsString := Request.ContentFields.Values['fAlamat'];
           ParamByName('fUser_create').AsString := Request.ContentFields.Values['fUser_create'];
           Execute;
         end;

        Response.ContentType := 'application/json; charset=utf-8';
        Response.Content := '{code:200,description:data berhasil ditambahkan}';
     end
     else
     begin
        //Form1.CreateLog('Insert: ' + Request.ContentFields.Values['fUser_create'] + 'Gagal');
        //Form1.CreateRequest(Request.ContentFields.Text);
        Response.ContentType := 'application/json; charset=utf-8';
        Response.Content := '{"code":"21","description":"error body - tidak boleh ada data kosong"}';
     end;
end;

procedure TWebModule1.WebModule1PutDataAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
   if (length(Request.ContentFields.Values['fNK']) > 0) and (length(Request.ContentFields.Values['fNama']) > 0) and (length(Request.ContentFields.Values['fAlamat']) > 0) then
     begin
       //Form1.CreateLog('Update: ' + Request.ContentFields.Values['fUser_create'] + 'Berhasil');
       //Form1.CreateRequest(Request.ContentFields.Text);
         with spex do
         begin
           SQL.Clear;
           CreateProcCall('tbl_karyawan.tbl_update');
           ParamByName('fNk').AsString := Request.ContentFields.Values['fNK'];
           ParamByName('fNama').AsString := Request.ContentFields.Values['fNama'];
           ParamByName('fAlamat').AsString := Request.ContentFields.Values['fAlamat'];
           ParamByName('fUser_create').AsString := Request.ContentFields.Values['fUser_create'];
           Execute;
         end;

        Response.ContentType := 'application/json; charset=utf-8';
        Response.Content := '{code:200,description:update data berhasil}';
     end
     else
     begin
        //Form1.CreateLog('Insert: ' + Request.ContentFields.Values['fUser_create'] + 'Gagal');
        //Form1.CreateRequest(Request.ContentFields.Text);
        Response.ContentType := 'application/json; charset=utf-8';
        Response.Content := '{"code":"21","description":"error body - tidak boleh ada data kosong"}';
     end;
end;

end.

object WebModule1: TWebModule1
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end
    item
      Name = 'GetData'
      PathInfo = '/Get'
      OnAction = WebModule1GetDataAction
    end
    item
      Name = 'PostData'
      PathInfo = '/Post'
      OnAction = WebModule1PostDataAction
    end
    item
      Name = 'PutData'
      PathInfo = '/Put'
      OnAction = WebModule1PutDataAction
    end
    item
      Name = 'DeleteData'
      PathInfo = '/Delete'
      OnAction = WebModule1DeleteDataAction
    end>
  Height = 380
  Width = 400
  PixelsPerInch = 96
  object ConnectionDB: TUniConnection
    ProviderName = 'mySQL'
    Port = 3307
    Database = 'db_uas'
    Username = 'root'
    Server = 'localhost'
    Connected = True
    Left = 40
    Top = 16
    EncryptedPassword = '9BFF96FF94FF9EFF'
  end
  object SQL: TUniSQL
    Connection = ConnectionDB
    Left = 128
    Top = 16
  end
  object Query: TUniQuery
    Connection = ConnectionDB
    Left = 200
    Top = 16
  end
  object MySQLUniProviderDB: TMySQLUniProvider
    Left = 300
    Top = 16
  end
  object spex: TUniStoredProc
    Connection = ConnectionDB
    Left = 296
    Top = 88
  end
end

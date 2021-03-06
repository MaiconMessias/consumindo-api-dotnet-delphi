object DtMdPrincipal: TDtMdPrincipal
  Height = 143
  Width = 579
  PixelsPerInch = 96
  object RESTClientAPICSharp: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://api.chucknorris.io/jokes/random'
    Params = <>
    Left = 32
    Top = 16
  end
  object RESTResponsePessoa: TRESTResponse
    Left = 32
    Top = 72
  end
  object RESTRequestPessoa: TRESTRequest
    Client = RESTClientAPICSharp
    Params = <>
    Response = RESTResponsePessoa
    Left = 152
    Top = 16
  end
  object RESTRequestPut: TRESTRequest
    Client = RESTClientAPICSharp
    Method = rmPUT
    Params = <
      item
        Kind = pkURLSEGMENT
        Name = 'id'
        Options = [poAutoCreated]
        ContentTypeStr = 'application/andrew-inset'
      end>
    Resource = '{id}'
    Left = 272
    Top = 16
  end
  object RESTRequestPost: TRESTRequest
    Client = RESTClientAPICSharp
    Method = rmPOST
    Params = <>
    Left = 384
    Top = 16
  end
  object RESTRequestDelete: TRESTRequest
    Client = RESTClientAPICSharp
    Method = rmDELETE
    Params = <
      item
        Kind = pkURLSEGMENT
        Name = 'id'
        Options = [poAutoCreated]
      end>
    Resource = '{id}'
    Left = 496
    Top = 16
  end
end

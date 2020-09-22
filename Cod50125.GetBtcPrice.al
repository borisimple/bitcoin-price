codeunit 50125 "Get Bitcoin Price"
{
    trigger OnRun()
    begin
        RetrieveBtcPrice();
    end;

    local procedure RetrieveBtcPrice()
    var
        CoinUri: Text;
        Client: HttpClient;
        ResponseMsg: HttpResponseMessage;
        ResponseText: Text;
        JToken: JsonToken;
        JTokenPrice: JsonToken;
        JTokenAth: JsonToken;
        JTokenPctChange: JsonToken;
        CurrPrice: Decimal;
        AthPrice: Decimal;
        PctChange: Decimal;
    begin
        CoinUri := 'https://api.coinranking.com/v1/public/coins?symbols=btc';
        Client.Get(CoinUri, ResponseMsg);

        if not ResponseMsg.IsSuccessStatusCode() then
            Error('Cannot retrieve Bitcoin price.\\' +
                    'Status Code: %1\' +
                    'Description: %2',
                    ResponseMsg.HttpStatusCode(),
                    ResponseMsg.ReasonPhrase());

        ResponseMsg.Content.ReadAs(ResponseText);

        JToken.ReadFrom(ResponseText);
        JToken.SelectToken('data.coins[0].price', JTokenPrice);
        JToken.SelectToken('data.coins[0].allTimeHigh.price', JTokenAth);
        JToken.SelectToken('data.coins[0].change', JTokenPctChange);

        CurrPrice := JTokenPrice.AsValue().AsDecimal();
        AthPrice := JTokenAth.AsValue().AsDecimal();
        PctChange := JTokenPctChange.AsValue().AsDecimal();

        SaveBtcPrice(CurrPrice, AthPrice, PctChange);
    end;

    local procedure SaveBtcPrice(CurrPrice: Decimal; AthPrice: Decimal; PctChange: Decimal)
    var
        BtcPrice: Record "Bitcoin Price";
    begin
        BtcPrice.Init();
        BtcPrice.Date := CreateDateTime(Today(), Time());
        BtcPrice.Price := CurrPrice;
        BtcPrice.AllTimeHigh := AthPrice;
        BtcPrice.PctChange := PctChange;
        BtcPrice.Insert();
    end;
}
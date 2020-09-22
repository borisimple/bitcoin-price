page 50125 "Bitcoin Prices"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bitcoin Price";
    Caption = 'Bitcoin Prices';
    Editable = false;
    SourceTableView = order(descending);
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater("Price History")
            {
                field(Price; Price)
                {
                    ApplicationArea = All;
                }
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field(PctChange; PctChange)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Get Bitcoin Price")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = InsertTravelFee;

                trigger OnAction()
                var
                    GetBtcPrice: Codeunit "Get Bitcoin Price";
                begin
                    GetBtcPrice.Run();
                end;
            }
            action("Delete Current History")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Delete;

                trigger OnAction()
                var
                    BTC: Record "Bitcoin Price";
                begin
                    BTC.DeleteAll();
                end;
            }
            action("See ATH Price")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Price;

                trigger OnAction()
                var
                    BTC: Record "Bitcoin Price";
                begin
                    if BTC.FindLast() then
                        Message('All time high price was $%1', BTC.AllTimeHigh);
                end;
            }
        }
    }
}
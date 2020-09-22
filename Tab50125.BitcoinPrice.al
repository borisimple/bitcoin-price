table 50125 "Bitcoin Price"
{
    DataClassification = CustomerContent;
    Caption = 'Bitcoin Price';
    DataPerCompany = false;

    fields
    {
        field(1; EntryNo; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
            AutoIncrement = true;
            InitValue = 0;
            Caption = 'Entry No';
        }
        field(2; Date; DateTime)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Date';
        }
        field(3; Price; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            DecimalPlaces = 2;
            Caption = 'Current Price';
        }
        field(4; AllTimeHigh; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            DecimalPlaces = 2;
            Caption = 'All Time High Price';
        }
        field(5; PctChange; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Change in %';
        }
    }

    keys
    {
        key(PK; EntryNo)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
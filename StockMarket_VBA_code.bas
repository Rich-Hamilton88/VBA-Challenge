Attribute VB_Name = "Module1"
Sub StockMarket():

' Loop Through Worksheets
    For Each ws In Worksheets


' Initial Variables
        Dim Ticker As String
        Dim LastRow As Long
        Dim TotalTickerVolume As Double
        TotalTickerVolume = 0
        Dim TableRow As Long
        TableRow = 2
        Dim YearlyOpen As Double
        Dim YearlyClose As Double
        Dim YearlyChange As Double
        Dim PreviousAmount As Long
        PreviousAmount = 2
        Dim PercentChange As Double
        Dim GreatestIncrease As Double
        GreatestIncrease = 0
        Dim GreatestDecrease As Double
        GreatestDecrease = 0
        Dim LastRowValue As Long
        Dim GreatestTotalVolume As Double
        GreatestTotalVolume = 0

' Data Field Labels
        ws.Range("I1").Value = "Ticker"
        ws.Range("J1").Value = "Yearly Change"
        ws.Range("K1").Value = "Percent Change"
        ws.Range("L1").Value = "Total Stock Volume"
        ws.Range("O2").Value = "Greatest % Increase"
        ws.Range("O3").Value = "Greatest % Decrease"
        ws.Range("O4").Value = "Greatest Total Volume"
        ws.Range("P1").Value = "Ticker"
        ws.Range("Q1").Value = "Value"

        

' Determine the Last Row
        LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
        
        For i = 2 To LastRow

' Add To Ticker Total Volume
            TotalTickerVolume = TotalTickerVolume + ws.Cells(i, 7).Value

            If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then


                ' Set Ticker Name
                Ticker = ws.Cells(i, 1).Value
                
                ws.Range("I" & TableRow).Value = Ticker
                ' Ticker Total Amount To The Table Row
                ws.Range("L" & TableRow).Value = TotalTickerVolume
                ' Reset Ticker Total
                TotalTickerVolume = 0


' Yearly Open, Yearly Close and Yearly Change Name
                YearlyOpen = ws.Range("C" & PreviousAmount)
                YearlyClose = ws.Range("F" & i)
                YearlyChange = YearlyClose - YearlyOpen
                ws.Range("J" & TableRow).Value = YearlyChange

' % Change
            If YearlyOpen = 0 Then
                    PercentChange = 0
                Else
                    YearlyOpen = ws.Range("C" & PreviousAmount)
                    PercentChange = YearlyChange / YearlyOpen
                End If
                ' Formatting that includes % Symbol And Two Decimal Places
                ws.Range("K" & TableRow).NumberFormat = "0.00%"
                ws.Range("K" & TableRow).Value = PercentChange

                ' Color formatting formulas for Green/Red
            If ws.Range("J" & TableRow).Value >= 0 Then
                    ws.Range("J" & TableRow).Interior.ColorIndex = 4
                Else
                    ws.Range("J" & TableRow).Interior.ColorIndex = 3
                End If
            
                ' Add One To The Table Row
                TableRow = TableRow + 1
                PreviousAmount = i + 1
                End If
        Next i



            ' Greatest % Increase, Greatest % Decrease and Greatest Total Volume
            LastRow = ws.Cells(Rows.Count, 11).End(xlUp).Row
        
            ' 2nd loop
            For i = 2 To LastRow
                If ws.Range("K" & i).Value > ws.Range("Q2").Value Then
                    ws.Range("Q2").Value = ws.Range("K" & i).Value
                    ws.Range("P2").Value = ws.Range("I" & i).Value
                End If

                If ws.Range("K" & i).Value < ws.Range("Q3").Value Then
                    ws.Range("Q3").Value = ws.Range("K" & i).Value
                    ws.Range("P3").Value = ws.Range("I" & i).Value
                End If

                If ws.Range("L" & i).Value > ws.Range("Q4").Value Then
                    ws.Range("Q4").Value = ws.Range("L" & i).Value
                    ws.Range("P4").Value = ws.Range("I" & i).Value
                End If

            Next i
        ' Includes % Symbol And Two Decimal Places
            ws.Range("Q2").NumberFormat = "0.00%"
            ws.Range("Q3").NumberFormat = "0.00%"
            
        ' Format Table Columns To Auto Fit
        ws.Columns("I:Q").AutoFit

    Next ws

End Sub


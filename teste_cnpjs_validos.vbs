Option Explicit

' Load validation module (cnpj_alfanumerico.vbs) into this script's global scope
Dim fso, moduleFile, moduleText, scriptFolder
Set fso = CreateObject("Scripting.FileSystemObject")
scriptFolder = fso.GetParentFolderName(WScript.ScriptFullName)
Set moduleFile = fso.OpenTextFile(scriptFolder & "\" & "cnpj_alfanumerico.vbs", 1)
moduleText = moduleFile.ReadAll
moduleFile.Close
ExecuteGlobal moduleText

' Entrypoint: accept optional CNPJ argument or path to CSV file and run tests
Dim csvPath, csvFile, csvContent, tokens, invalidCount, total, tok, singleCNPJ

csvPath = scriptFolder & "\" & "cnpjs_validos_gerados_receitafederal.csv"

Set csvFile = fso.OpenTextFile(csvPath, 1)
csvContent = csvFile.ReadAll
csvFile.Close

csvContent = Replace(csvContent, vbCrLf, "")
csvContent = Replace(csvContent, vbCr, "")
csvContent = Replace(csvContent, vbLf, "")

tokens = Split(csvContent, ";")
invalidCount = 0
total = 0

For Each tok In tokens
    tok = Trim(tok)
    If tok <> "" Then
        total = total + 1
        If ValidaCNPJAlfanumerico(tok) Then
            WScript.Echo tok & ";VALID"
        Else
            WScript.Echo tok & ";INVALID"
            invalidCount = invalidCount + 1
        End If
    End If
Next

WScript.Echo "TOTAL:" & total & " INVALID:" & invalidCount
If invalidCount > 0 Then
    WScript.Echo "*** Divergencias entre o resultado esperado e o obtido. ***"
    WScript.Quit 1
Else
    WScript.Echo "Resultados conferem com o esperado."
    WScript.Quit 0
End If
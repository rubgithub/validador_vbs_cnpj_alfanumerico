Option Explicit

' Carrega o módulo de validação (cnpj_alfanumerico.vbs) no escopo global deste script
Dim fso, moduleFile, moduleText, scriptFolder
Set fso = CreateObject("Scripting.FileSystemObject")
scriptFolder = fso.GetParentFolderName(WScript.ScriptFullName)
Set moduleFile = fso.OpenTextFile(scriptFolder & "\" & "cnpj_alfanumerico.vbs", 1)
moduleText = moduleFile.ReadAll
moduleFile.Close
ExecuteGlobal moduleText

' Entrada: testa o arquivo cnpsj_massa_mista_gerado_chatgpt.csv
Dim csvPath, csvFile, csvContent, lines, line, parts
Dim total, mismatchCount, invalidCount, validCount, expected, expectedBool, cnpj, obs, valid, status, i

csvPath = scriptFolder & "\" & "cnpsj_massa_mista_gerado_chatgpt.csv"

If Not fso.FileExists(csvPath) Then
    WScript.Echo "Arquivo não encontrado: " & csvPath
    WScript.Quit 2
End If

Set csvFile = fso.OpenTextFile(csvPath, 1)
csvContent = csvFile.ReadAll
csvFile.Close

' Normaliza quebras de linha e separa por linhas
csvContent = Replace(csvContent, vbCrLf, vbLf)
csvContent = Replace(csvContent, vbCr, vbLf)
lines = Split(csvContent, vbLf)

total = 0
mismatchCount = 0
invalidCount = 0
validCount = 0

For Each line In lines
    line = Trim(line)
    If line = "" Then
        ' pula linha vazia
    ElseIf LCase(Left(line, 4)) = "cnpj" Then
        ' pula cabeçalho
    Else
        total = total + 1
        parts = Split(line, ";")

        cnpj = ""
        If UBound(parts) >= 0 Then cnpj = Trim(parts(0))

        expected = ""
        If UBound(parts) >= 1 Then expected = Trim(parts(1))

        obs = ""
        If UBound(parts) >= 2 Then
            obs = Trim(parts(2))
            For i = 3 To UBound(parts)
                obs = obs & ";" & parts(i)
            Next
        End If

        If cnpj = "" Then
            WScript.Echo "Linha sem CNPJ: " & line
            mismatchCount = mismatchCount + 1
        Else
            valid = ValidaCNPJAlfanumerico(cnpj)
            If valid Then
                status = "VALID"
                validCount = validCount + 1
            Else
                status = "INVALID"
                invalidCount = invalidCount + 1
            End If

            If expected <> "" Then
                expected = UCase(expected)
                If expected = "S" Or expected = "Y" Or expected = "TRUE" Then
                    expectedBool = True
                Else
                    expectedBool = False
                End If

                If (valid = expectedBool) Then
                    WScript.Echo total & " - " & cnpj & ";" & status & ";EXPECTED:" & expected & ";OK;" & obs
                Else
                    WScript.Echo total & " - " & cnpj & ";" & status & ";EXPECTED:" & expected & ";MISMATCH;" & obs
                    mismatchCount = mismatchCount + 1
                End If
            Else
                WScript.Echo cnpj & ";" & status & ";EXPECTED:UNKN;" & obs
            End If
        End If
    End If
Next

WScript.Echo "TOTAL:" & total & " VALID:" & validCount & " INVALID:" & invalidCount & " MISMATCH:" & mismatchCount
If mismatchCount > 0 Then
    WScript.Echo "*** Divergencias entre o resultado esperado e o obtido. ***"
    WScript.Quit 1
Else
    WScript.Echo "Resultados conferem com o esperado."
    WScript.Quit 0
End If

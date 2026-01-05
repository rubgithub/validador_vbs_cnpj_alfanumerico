Option Explicit

' Module: validation functions only. Use `teste_cnpjs_validos.vbs` to execute the validator.

' =========================================================
' Validação de CNPJ Alfanumérico (VBScript)
' Adaptado para rodar com cscript/wscript no Windows
' =========================================================

Function ValidaCNPJAlfanumerico(CNPJ)
    Dim Base
    Dim DVInformado
    Dim DVCalculado

    ' Normaliza o CNPJ
    CNPJ = UCase(CNPJ)
    CNPJ = Replace(CNPJ, ".", "")
    CNPJ = Replace(CNPJ, "/", "")
    CNPJ = Replace(CNPJ, "-", "")

    ' Deve conter 14 caracteres
    If Len(CNPJ) <> 14 Then
        ValidaCNPJAlfanumerico = False
        Exit Function
    End If

    Base = Left(CNPJ, 12)
    DVInformado = Right(CNPJ, 2)

    ' Verifica se os 12 primeiros são alfanuméricos
    If Not SoAlfanumerico(Base) Then
        ValidaCNPJAlfanumerico = False
        Exit Function
    End If

    ' Calcula os dígitos verificadores
    DVCalculado = CalculaDV(Base)

    ' Compara com o informado
    ValidaCNPJAlfanumerico = (DVCalculado = DVInformado)
End Function

' =========================================================
' Cálculo dos dois dígitos verificadores
' =========================================================
Function CalculaDV(Base)
    Dim DV1
    Dim DV2

    DV1 = CalculaDigito(Base, Array(5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2))
    DV2 = CalculaDigito(Base & CStr(DV1), Array(6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2))

    CalculaDV = CStr(DV1) & CStr(DV2)
End Function

' =========================================================
' Cálculo individual de cada dígito verificador
' =========================================================
Function CalculaDigito(Texto, Pesos)
    Dim i
    Dim Soma
    Dim Valor
    Dim Resto

    Soma = 0

    For i = 1 To Len(Texto)
        Valor = ValorCaracter(Mid(Texto, i, 1))
        Soma = Soma + (Valor * Pesos(i - 1))
    Next

    Resto = Soma Mod 11

    If Resto = 0 Or Resto = 1 Then
        CalculaDigito = 0
    Else
        CalculaDigito = 11 - Resto
    End If
End Function

' =========================================================
' Converte caractere alfanumérico em valor numérico
' Regra: Valor = ASCII - 48
' =========================================================
Function ValorCaracter(C)
    ValorCaracter = Asc(C) - 48
End Function

' =========================================================
' Verifica se a string contém apenas caracteres 0-9 e A-Z
' =========================================================
Function SoAlfanumerico(Texto)
    Dim i
    Dim C

    For i = 1 To Len(Texto)
        C = Mid(Texto, i, 1)
        If Not ((C >= "0" And C <= "9") Or (C >= "A" And C <= "Z")) Then
            SoAlfanumerico = False
            Exit Function
        End If
    Next

    SoAlfanumerico = True
End Function

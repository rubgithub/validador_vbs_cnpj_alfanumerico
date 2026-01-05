import random
import string
# import csv

def obter_valor_calculo(char):
    """
    Retorna o valor para cálculo conforme documentação (ASCII - 48).
    """
    return ord(char) - 48

def gerar_cnpj_alfanumerico():
    """
    Gera os 12 caracteres base e calcula os DVs.
    Retorna o CNPJ bruto (sem formatação).
    """
    caracteres = string.digits + string.ascii_uppercase
    # Gera 12 caracteres base aleatórios
    base = [random.choice(caracteres) for _ in range(12)]

    # --- CÁLCULO DO 1º DV ---
    # Pesos: 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2
    pesos_dv1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    soma = 0
    
    for i in range(12):
        val = obter_valor_calculo(base[i])
        soma += val * pesos_dv1[i]
    
    resto = soma % 11
    dv1 = 0 if resto < 2 else 11 - resto

    # --- CÁLCULO DO 2º DV ---
    # Considera base + dv1
    # Pesos: 6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2
    pesos_dv2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    lista_calc_dv2 = base + [str(dv1)]
    soma = 0
    
    for i in range(13):
        val = obter_valor_calculo(lista_calc_dv2[i])
        soma += val * pesos_dv2[i]
        
    resto = soma % 11
    dv2 = 0 if resto < 2 else 11 - resto

    return "".join(base) + str(dv1) + str(dv2)

def formatar_cnpj(cnpj):
    """
    Formata o CNPJ para XX.XXX.XXX/XXXX-XX
    """
    return f"{cnpj[:2]}.{cnpj[2:5]}.{cnpj[5:8]}/{cnpj[8:12]}-{cnpj[12:14]}"

def gerar_massa_teste(qtd=50, nome_arquivo="massa_teste_cnpj.csv"):
    """
    Gera uma massa de dados e salva em CSV.
    """
    cabecalho = ["cnpj", "valido", "observacao"]
    dados = []
    
    print(f"Gerando {qtd} CNPJs...")
    
    for _ in range(qtd):
        cnpj_bruto = gerar_cnpj_alfanumerico()
        cnpj_formatado = formatar_cnpj(cnpj_bruto)
        
        # Estrutura da linha conforme solicitado
        linha = {
            "cnpj": cnpj_formatado,
            "valido": "S",
            "observacao": "cnpjs gerados script python"
        }
        # dados.append(linha)
        print(f"{cnpj_formatado};S;cnpjs gerados script python")
    
    # print(dados)
    # Gravar arquivo CSV
    # try:
    #     with open(nome_arquivo, mode='w', newline='', encoding='utf-8') as arquivo:
    #         writer = csv.DictWriter(arquivo, fieldnames=cabecalho, delimiter=';')
    #         writer.writeheader()
    #         writer.writerows(dados)
    #     print(f"Sucesso! Arquivo '{nome_arquivo}' criado com {qtd} registros.")
    # except Exception as e:
    #     print(f"Erro ao criar arquivo: {e}")

# --- EXECUÇÃO ---
if __name__ == "__main__":
    gerar_massa_teste(qtd=20)
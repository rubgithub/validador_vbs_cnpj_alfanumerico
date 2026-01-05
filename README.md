# Validador CNPJ Alfanumérico (VBScript)

![License: MIT](https://img.shields.io/github/license/rubgithub/validador_vbs_cnpj_alfanumerico?color=blue)

[![Test VBScript](https://github.com/rubgithub/validador_vbs_cnpj_alfanumerico/actions/workflows/test-vbscript.yml/badge.svg)](https://github.com/rubgithub/validador_vbs_cnpj_alfanumerico/actions/workflows/test-vbscript.yml)

**Descrição**

Projeto contendo código em **VBScript** para validação de CNPJs alfanuméricos, baseado no serviço oficial da Receita Federal para CNPJ alfanumérico:
- https://www.gov.br/receitafederal/pt-br/acesso-a-informacao/acoes-e-programas/programas-e-atividades/cnpj-alfanumerico

O código deste repositório foi criado com auxílio de IA (ChatGPT). Este repositório também inclui dados gerados para validação e um gerador em Python para criar amostras de CNPJs alfanuméricos.

## Conteúdo do repositório 🔧

- `cnpj_alfanumerico.vbs` — Validador em VBScript para CNPJ alfanumérico
- `teste_cnpjs_validos.vbs` — Script de teste com CNPJs válidos
- `teste_cnpsj_massa_mista.vbs` — Script de teste com massa mista (válidos e inválidos)
- `cnpjs_validos_gerados_receitafederal.csv` — 1000 CNPJs alfanuméricos válidos gerados usando o validador oficial da Receita (https://servicos.receitafederal.gov.br/servico/cnpj-alfa/simular)
- `cnpsj_massa_mista_gerado_chatgpt.csv` — Massa mista com CNPJs válidos e inválidos gerada com auxílio do ChatGPT
- `gerador_cnpj_alfanumerico/gerador_cnpj_alfanumerico.py` — Gerador de CNPJs (script em Python; gerado com chat.z.ai)
- `docs/` — Documentação e materiais relacionados

## Validação ✅

- Foram gerados **1000 (mil)** CNPJs alfanuméricos válidos usando o validador oficial da Receita Federal: `cnpjs_validos_gerados_receitafederal.csv`.
- Foi gerada uma **massa mista** (válidos e inválidos) com o auxílio do ChatGPT: `cnpsj_massa_mista_gerado_chatgpt.csv`.
- Amostras de CNPJs válidos também foram geradas com o script Python `gerador_cnpj_alfanumerico.py`.

## Como usar 🚀

- Para validar CNPJs com o VBScript, execute os arquivos `.vbs` em um sistema Windows (duplo clique ou via `cscript`):

```powershell
cscript //nologo teste_cnpjs_validos.vbs
```

```powershell
cscript //nologo teste_cnpsj_massa_mista.vbs
```

- Para gerar amostras com o script Python:

```bash
python gerador_cnpj_alfanumerico.py
```

(Verifique se o Python está instalado e use um ambiente apropriado.)

## Créditos e referências ✨

- Validador CNPJ alfanumérico — Receita Federal: https://www.gov.br/receitafederal/pt-br/acesso-a-informacao/acoes-e-programas/programas-e-atividades/cnpj-alfanumerico
- Serviço de simulação (geração/validação): https://servicos.receitafederal.gov.br/servico/cnpj-alfa/simular
- Geração assistida por IA: ChatGPT / chat.z.ai

## Licença 📝

Este projeto é distribuído sob a **MIT License** — uso irrestrito. O software é fornecido **"AS IS"** (no estado em que se encontra), sem garantias de qualquer tipo, expressas ou implícitas. Os autores e mantenedores não se responsabilizam por quaisquer danos, erros ou falhas decorrentes do uso deste software.
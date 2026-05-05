# Visão Geral
Este projeto auxilia no preenchimento do timesheet do **NetSuite**.
Para utilizá-lo, você deve preencher corretamente o arquivo `Timesheet.robot` com suas horas trabalhadas e executar o script. O Robot cuida de manipular a página do NetSuite, evitando desperdício de tempo e erros de preenchimento.

### Atenção:
**VOCÊ _DEVE_ VERIFICAR OS DADOS INSERIDOS APÓS A EXECUÇÃO DO SCRIPT, ELE É APENAS UM AUXILIAR**

# Requisitos
 - Python 3 - *testado com v3.12 - v3.13*
 - Node - *testado com v22.1.0*

# Como funciona
Para que tudo funcione, algumas configurações são necessárias:

**1.** Crie o arquivo .env

    `cp .env.example .env`
**2.** Preencha o arquivo `.env` com seus dados

**3.** No Netsuite, o 2FA é obrigatório. O script suporta dois métodos:

**Padrão — Códigos de backup:** O script utiliza códigos de backup por padrão. Como são de uso único e apenas 10 códigos são gerados por vez, será necessário renová-los periodicamente. Gere os códigos no NetSuite (procure por "Gerar códigos de backup 2FA") e cole-os no arquivo ```backup_codes.txt```. O script seleciona um código aleatório a cada execução e o remove do arquivo automaticamente.

**Opcional — ykman (YubiKey Manager):** Se você possui um token de hardware YubiKey, pode usar o `ykman` para gerar códigos TOTP automaticamente. Este método nunca expira e não requer renovação manual, sendo mais conveniente que os códigos de backup. Para ativá-lo, defina `YKMAN_ACCOUNT` no seu arquivo `.env` — a presença desta variável é suficiente para o script alternar para o modo ykman.

> **Nota:** A integração com o ykman foi testada apenas no Linux. Pode funcionar no macOS e Windows, mas não há garantia.

  -- Instale o `ykman` seguindo as [instruções oficiais](https://developers.yubico.com/yubikey-manager/) para o seu sistema:

    - Linux: `sudo apt install yubikey-manager` ou equivalente
    - macOS: `brew install ykman` (requer homebrew)
    - Windows: Baixe o instalador no site da Yubico

  -- Registre a conta OATH do seu YubiKey para o NetSuite:

    `ykman oath accounts uri "otpauth://totp/..."`

    Ou adicione manualmente:

    `ykman oath accounts add -i <issuer> <account_name> <secret_key>`

  -- Defina `YKMAN_ACCOUNT` no seu arquivo `.env` com o nome da conta registrada no YubiKey (use `ykman oath accounts list` para verificar o nome exato).

  -- O script chamará automaticamente `ykman oath accounts code <account>` para obter o código TOTP atual durante o login.

**4.** É altamente recomendável usar um ambiente virtual Python

    `python -m venv .venv`

    e ativá-lo

    `source .venv/bin/activate` para linux/mac ou

    `.venv\Scripts\activate` para windows

**5.** Instale as dependências `pip install -r requirements.txt`.

**6.** Inicialize o Playwright `rfbrowser init`

Todas as configurações acima precisam ser feitas apenas uma vez — exceto `./backup_codes.txt`, que deve ser reabastecido a cada dez execuções (não necessário ao usar ykman).

## Configurando o script

O script está em `./Scripts/Timesheet.robot`. Na seção `*** Variables ***` você pode configurar os valores a serem preenchidos em cada campo, respeitando os valores pré-cadastrados.

Na seção `*** Test Cases ***`, abaixo da linha comentada, você pode adicionar as linhas que deseja registrar no NetSuite.

Após configurar tudo, você pode definir a variável `HEADLESS` em `./Python/env.py` como `True` se não quiser ver tudo sendo executado em tempo real.

# Executando

Para executar o script, basta executar `robot ./Scripts/Timesheet.robot` ou `robot .`

### Aproveite!

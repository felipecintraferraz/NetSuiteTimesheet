# Overview
This project helps **NetSuite** timesheet filling.
To use it you have to daily fill correctly the `Timesheet.robot` file with your working hours and run the script. Robot will take care of manipulate NetSuite page avoiding wasting time and misfilling the form. 

### Attention:
**YOU _MUST_ CHECK THE DATA INSERTED AFTER THE SCRIPT EXECUTION, IT IS JUST A HELPER** 

# Requirements
 - Python 3 - *tested with v3.12 - v3.13*
 - Node - *tested with v22.1.0*

# How it works
To turn it possible some configurations must be done:

**1.** create .env file 

    `cp .env.example .env`
**2.** Fill `.env` file with your own data

**3.** In Netsuite 2FA is mandatory. The script supports two methods:

**Default — Backup codes:** The script uses backup codes out of the box. Since they are single-use and only 10 codes are generated at a time, you will need to renew them periodically. Generate the codes in NetSuite (look for "Generate 2FA Backup Codes" / "Gerar códigos de backup 2FA") and paste them into ```backup_codes.txt```. The script picks a random code each run and removes it from the file automatically.

**Optional — ykman (YubiKey Manager):** If you have a YubiKey hardware token, you can use `ykman` to generate TOTP codes automatically. This method never expires and requires no manual renewal, making it more convenient than backup codes. To enable it, set `YKMAN_ACCOUNT` in your `.env` file — the presence of this variable is enough to switch the script to ykman mode.

> **Note:**  ykman integration has been tested on Linux only. It may work on macOS and Windows, but is not guaranteed.

  -- Install `ykman` by following the [official instructions](https://developers.yubico.com/yubikey-manager/) for your OS:
  
    - Linux: `sudo apt install yubikey-manager` or equivalent
    - macOS: `brew install ykman` (homebrew required)
    - Windows: Download the installer from the Yubico website

  -- Register your YubiKey OATH account for NetSuite:

    `ykman oath accounts uri "otpauth://totp/..."`

    Or add it manually:

    `ykman oath accounts add -i <issuer> <account_name> <secret_key>`

  -- Set `YKMAN_ACCOUNT` in your `.env` file to the account name registered in your YubiKey (use `ykman oath accounts list` to check the exact name).

  -- The script will automatically call `ykman oath accounts code <account>` to retrieve the current TOTP code during login.

**4.** It is highly recommended to use a Python virtual environment 

    `python -m venv .venv` 
    
    and activate it 
    
    `source .venv/bin/activate` for linux/mac or 
    
    `.venv\Scripts\activate` for windows

**5.** Install dependencies `pip install -r requirements.txt`.

**6.** Init Playwright `rfbrowser init`

All above configurations just need to be done once - except `./backup_codes.txt` that should be refilled every ten executions (not needed if using ykman).

## Setting up script

The script lives at `./Scripts/Timesheet.robot` In the `*** Variables ***` section you can set up the values to be filled in each field, respecting the pre registered values.

In the `*** Test Cases ***` section under the commented line you can fill any rows that you want to perform the registers inside NetSuite

After configure everything you can update 'HEADLESS' variable at `./Python/env.py` to `True` if you don't want to see everything running in realtime.

# Run it

To execute the script just run `robot ./Scripts/Timesheet.robot` or `robot .`

- This script may not work fine if used with other language then portuguese

### Enjoy!

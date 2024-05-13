# Overview
This project helps **NetSuite** timesheet filling.
To use it you have to daily fill correctly the `Timesheet.robot` file with your working hours and run the script. Robot will take care of manipulate NetSuite page avoiding wasting time and misfilling the form. 

### Attention:
**YOU _MUST_ CHECK THE DATA INSERTED AFTER THE SCRIPT EXECUTION, IT IS JUST A HELPER** 

# Requirements
 - Python 3 - *tested with v3.12*
 - Node - *tested with v22.1.0*

# How it works
To turn it possible some configurations must be done
1. create .env file 

    `cp .env.example .env`
2. Fill `.env` file with your own data
3. You'll need to generate 'backup codes' in NetSuite to enable the script to login and pass through 2FA system. To do that login to netsuite and click at this option in the bottom side at home page. The link is: "Generate 2FA Backup Codes" or "Gerar códigos de backup 2FA" in portuguese.

    Copy all 10 generated codes and paste to `./backup_codes.txt`
4. It is highly recommended to use a Python virtual environment 

    `python -m venv .venv` 
    
    and activate it 
    
    `source .venv/bin/activate` for linux/mac or 
    
    `.venv\Scripts\activate` for windows

5. Install dependencies `pip install -r requirements.txt`. 
6. Init Playwright `rfbrowser init`

All above configurations just need to be done once - except `./backup_codes.txt` that should be refilled every ten executions.

## Setting up script

The script lives at `./Scripts/Timesheet.robot` In the `*** Variables ***` section you can set up the values to be filled in each field, respecting the pre registered values.

In the `*** Test Cases ***` section under the commented line you can fill any rows that you want to perform the registers inside NetSuite

After configure everything you can update 'HEADLESS' variable at `./Python/env.py` to `True` if you don't want to see everything running in realtime.

# Run it

To execute the script just run `robot ./Scripts/Timesheet.robot` 

- This script may not work fine if used with other language then portuguese

### Enjoy!

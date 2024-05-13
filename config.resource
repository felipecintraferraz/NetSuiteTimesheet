*** Settings ***
Documentation    This file just group imports and settings
Library          Browser
Library          String
Variables        ./Python/env.py
Resource         ./Resources/Login.resource
Resource         ./Resources/Common.resource
Resource         ./Resources/TrackTime.resource
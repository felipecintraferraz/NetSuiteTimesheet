*** Settings ***
Resource    ../config.resource


*** Keywords ***
Set Up
    ${args}    Create List       --start-maximized
    New Browser                  headless=${HEADLESS}   args=${args}
    New Context
    Set Browser Timeout          ${DEFAULT_TIMEOUT}     Global
    New Page                     ${URL}

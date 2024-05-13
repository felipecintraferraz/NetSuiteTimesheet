*** Settings ***
Resource  ../config.resource    # robotcode: ignore
 

*** Keywords ***
Perform Login
    Set Up
    Fill Login Form
    Input 2FA Code
    
Fill Login Form
    Fill Text                    \#email                ${EMAIL}
    Fill Secret                  \#password             $PASSWORD
    Check Checkbox               \#rememberme
    Click                        \#login-submit

Input 2FA Code
    Click   //label[text()='Backup codes' or text()='Códigos de backup']
    ${input}    Get Element  //div/span[text()='VERIFICATION CODE']/following-sibling::div//input
    Fill Text    ${input}    ${TWO_FA_CODE}
    Click     //label[contains(text(), 'Trust') or contains(text(), 'Confie')]
    Click   //label[text()='Enviar' or text()='Submit']
    

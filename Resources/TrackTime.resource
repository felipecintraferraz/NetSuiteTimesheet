*** Settings ***
Resource   ../config.resource    # robotcode: ignore


*** Keywords ***
Open Track Hours
    Click     //a[text()="Rastrear horário"]

Insert Date
    [Arguments]    ${date}
    Fill Text      \#trandate    ${date}

Calculate Time
    [Arguments]    ${start_time}    ${end_time}
    Click   //a[@title="Calcular"]
    Sleep   3s
    ${new_page}=    Get Page Ids    ALL
    Switch Page    ${new_page}[0]

    Fill Text    \#starttime    ${start_time}
    Fill Text    \#endtime    ${end_time}
    Click        //input[@type="submit"]
    Switch Page    ${new_page}[1]

Fill Client Project
    [Arguments]    ${value}
    Click  //*[@id="customer_fs"]//a[contains(@class, "popupsel")]/parent::span
    Click  //*[@id="customer_popup_list"]
    Click  //div[@id="inner_popup_div"]//td/a[contains(text(), "${value}")]

Fill Task Abstract
    [Arguments]    ${value}
    Click  //*[contains(@id, "casetaskevent")]//a[contains(@class, "popupsel")]/parent::span
    Click  //*[@id="casetaskevent_popup_list"]
    Click  //div[@id="inner_popup_div"]//td/a[contains(text(), "${value}")]

Fill Task Details
    [Arguments]   ${value}
    Fill Text     \#memo    ${value}

Save Task 
    Click  (//input[@type="submit"][@role="button"])[2]

Save And New Task
    ${status}   Run Keyword And Return Status      Click  (((//input[@type="submit"])[@role="button"])[@value="Salvar e novo"])[2]
    IF  not ${status}
        Hover    (//div[@alt="Mais opções"])[2]
        Click    //a/span[text()="Salvar e novo"]
    END
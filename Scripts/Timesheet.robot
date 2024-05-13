*** Settings ***
Documentation     This Robot File helps to fill the timesheet on the Oracle Net Suite following all recommendations.
Resource          ../config.resource
Suite Setup       Run Keywords  Perform Login  AND  Open Track Hours
Suite Teardown    Close Browser

*** Variables ***
${client_project}    <FILL HERE WITH EXACT THE NAME DISPLAYED IN NETSUITE>
${task_abstract}     <FILL HERE WITH EXACT THE NAME DISPLAYED IN NETSUITE>

*** Test Cases ***
Fill Timesheet Automation
    [Template]     Fill Timesheet
    # Date        Start Time   End Time       Task Details
    10/05/2024    08:00        09:00          Task description goes here
    10/05/2024    09:00        10:00          Second Task description goes here
    

*** Keywords ***
Fill Timesheet
    [Arguments]    ${date}    ${start_time}    ${end_time}    ${task_details}
    Insert Date             ${date}
    Calculate Time          ${start_time}   ${end_time}
    Fill Client Project     ${client_project}
    Fill Task Abstract      ${task_abstract}
    Fill Task Details       ${task_details}
    Save And New Task
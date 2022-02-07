*** Settings ***
Documentation     Zoomba Desktop Library Tests.
Library           Zoomba.DesktopLibrary
Suite Setup       Start App
Suite Teardown    Driver Teardown
Force Tags        Windows

*** Variables ***
${REMOTE_URL}    http://127.0.0.1:4723/wd/hub
${TruckFlow}     C:/TFS/TruckFlowGitTemp/PM.TruckFlow.Clients.OperatorStation/bin/Debug/PM.TruckFlow.Clients.OperatorStation.exe

*** Keywords ***
Start App
    [Documentation]     Sets up the application for quick launching through 'Launch Application' and starts the winappdriver
    Driver Setup
    Open Application    ${REMOTE_URL} platformName=Windows                                                                      deviceName=Windows    app=${TruckFlow}    alias=Main
    Maximize Window


Login
    [Arguments]                    ${username}                         ${password}
    Wait For And Input Password    accessibility_id=PasswordBox        ${password}
    Wait For And Input Text        accessibility_id=UsernameTextBox    ${username}
    Wait Until Element Contains    accessibility_id=UsernameTextBox    ${username}
    Wait For And Click Element     accessibility_id=BTConnect

*** Test Cases ***

Wait For And Input Login Test
    Login    Test    123

Restore DataBase Test
    Wait For And Click Element                                                                 accessibility_id=BTDataBase          10
    Wait For And Click Element                                                                 name=Restaurer la base de données    5
    Wait For And Click Element                                                                 name=Restaurer la base de données
    Wait For And Click Element                                                                 accessibility_id=OK
    Switch Application By Locator	http://localhost:4723/wd/hub	name=Restauration
    Wait For And Click Element                                                                 name=FULLDB.bak
    Wait For And Click Element                                                                 name=Restaurer la base de données
    Switch Application By Locator	http://localhost:4723/wd/hub	accessibility_id=MainWindows
    Wait For And Click Element                                                                 accessibility_id=OK                  30
    Login                                                                                      Test                            123

Weighing Test
    Wait For And Click Element    accessibility_id=BTCreateStandardWeighing    
    Wait For And Click Element    accessibility_id=TestValueOpen               #recherche de tout les badges qui commencent par 2
    Wait For And Click Element    name=200                                     #Choix du badge 200
    Element Text Should Be        accessibility_id=txbPlate                    2000                                                  #verification des différents champs associé au badge
    #Element Text Should Be    xpath=//*[@Name='Plaque']/parent::*    2000    #verification des différents champs associé au badge

    #Element Text Should Be    xpath=//*[@Name='Code tiers']/parent::*    2
    #Element Text Should Be    xpath=//*[@Name='Libellé tiers']/parent::*    Beton de France
    #Element Text Should Be    xpath=//*[@Name='Code produit']/parent::*    2
    #Element Text Should Be    xpath=//*[@Name='Libellé produit']/parent::*    Melange Beton
    #@{textbox}    Get Webelements    accessibility_id=textbox
    #Input Text    ${textbox}[3]    1500
    #Wait For And Click Element    accessibility_id=BTCaptureEntryWeight
    #Wait For And Click Element    accessibility_id=BTValidateEntryWeight
    #Wait For And Click Element    accessibility_id=Open
    #    @{textbox}    Get Webelements    accessibility_id=textbox
    #Input Text    ${textbox}[3]    500
    #Wait For And Click Element    accessibility_id=BTCaptureExitWeight
    #Wait For And Click Element    accessibility_id=BTTerminate
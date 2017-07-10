*** Settings ***
Library         Collections
Resource        keywords.robot
Test Setup      Test Setup
Test Teardown   Test Teardown

*** Variables ***
@{PDV}  1  0
@{PERSON_PDV}  0
&{LEGAL_TYPE}  company=@{PDV}  sole_trader=@{PDV}  person=@{PERSON_PDV}
${ROLE}  1
&{CREDENTIALS}

*** Test Cases ***
Зареєструвати користувачів і залогувати креди
  &{types}=  Run Keyword If  ${ROLE} == 0  Create Dictionary  company=@{PERSON_PDV}
  ...  ELSE  Create Dictionary  &{LEGAL_TYPE}
  :FOR  ${key}  IN  @{types.keys()}
  \  ${CREDENTIALS}=  Зареєструвати користувачів  ${key}  ${types["${key}"]}
  Capture Page Screenshot
  Wait Until Page Contains Element  xpath=//div[contains(@class, "alert-success")]
  Capture Page Screenshot
  Log Many  ${CREDENTIALS}

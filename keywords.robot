*** Settings ***
Library  Selenium2Library
#Library  DebugLibrary
Library  initial_data.py

*** Keywords ***
Test Setup
  Open Browser  http://tender.byustudio.in.ua  Firefox

Test Teardown
  Close Browser

Підготувати дані для реєстрації
  [Arguments]  ${role}  ${type}  ${tax}
  ${prepared_data}=  test_registration_data  ${role}  ${type}  ${tax}
  Log  ${prepared_data}
  [Return]  ${prepared_data}

Зареєструвати користувачів
  [Arguments]  ${type}  ${type_taxes}
  #${CREDENTIALS}=  Create Dictionary
  :FOR  ${tax}  IN  @{type_taxes}
  \  ${registration_data}=  Підготувати дані для реєстрації  ${role}  ${type}  ${tax}
  \  Set To Dictionary  ${CREDENTIALS}  ${registration_data.username}  ${registration_data.password}
  \  Зареєструвати користувача  ${registration_data}
  [Return]  ${CREDENTIALS}


Зареєструвати користувача
  [Arguments]  ${reg_data}
  Click Element  xpath=//*[@href="/register"]
  Wait Until Element Is Visible  id=companies-is_seller  10
  Select From List By Value  id=companies-is_seller  ${ROLE}
  # ЛОГІН ТА ПАРОЛЬ ДЛЯ ВХОДУ
  Input Text  id=user-username  ${reg_data.username}
  Input Text  id=user-password  ${reg_data.password}
  Input Text  id=user-confirmpassword  ${reg_data.password}
  # ЮРИДИЧНА АДРЕСА
  Select From List By Value  id=companies-registrationcountryname  ${reg_data.registrationcountryname}
  Wait Until Keyword Succeeds  5 x  1 s  Select From List By Value  id=companies-region  1
  Input Text  id=companies-locality  ${reg_data.locality}
  Input Text  id=companies-streetaddress  ${reg_data.streetaddress}
  Input Text  id=companies-postalcode  ${reg_data.postalcode}
  # ІНФОРМАЦІЯ ПРО УЧАСНИКА
  Select From List By Value  id=companies-countryname  1
  Select From List By Value  id=companies-legaltype  ${reg_data.legaltype}
  Input Text  id=companies-legalname  ${reg_data.legalname}
  Input Text  id=companies-legalname_en  ${reg_data.legalname_en}
  Run Keyword If  ${ROLE} == 0  Select From List By Value  id=companies-customer_type  general
  Input Text  id=companies-identifier  ${reg_data.identifier}
  Capture Page Screenshot
  # БАНКІВСЬКІ РЕКВІЗИТИ
  Input Text  id=companies-mfo  ${reg_data.mfo}
  Input Text  id=companies-bank_account  ${reg_data.bank_account}
  Input Text  id=companies-bank_branch  ${reg_data.bank_branch}
  #ДОДАТКОВІ ВІДОМОСТІ
  Run Keyword If  ${reg_data.legaltype} != 3 and ${ROLE} == 1  Select Radio Button  Companies[payer_pdv]  ${reg_data.tax}
  Run Keyword If  ${ROLE} == 1 and ${reg_data.tax} == 1  Run Keywords
  ...  Wait Until Element Is Visible  id=companies-ipn_id  10
  ...  AND  Input Text  id=companies-ipn_id  ${reg_data.ipn_id}
  # ДАНІ ПРО УПОВНОВАЖЕНУ ОСОБУ (ДЛЯ ДОГОВОРУ)
  Run Keyword If  ${reg_data.legaltype} != 3  Run Keywords
  ...  Input Text  id=companies-fio  ${reg_data.fio}
  ...  AND  Input Text  id=companies-userposition  ${reg_data.userposition}
  ...  AND  Input Text  id=companies-userdirectiondoc  ${reg_data.userdirectiondoc}
  # УПОВНОВАЖЕНА КОНТАКТНА ОСОБА
  Capture Page Screenshot
  Input Text  id=persons-username  ${reg_data.persons_username}
  Input Text  id=persons-usersurname  ${reg_data.persons_usersurname}
  Input Text  id=persons-userpatronymic  ${reg_data.persons_userpatronymic}
  Input Text  id=persons-username_en  ${reg_data.persons_username_en}
  Input Text  id=persons-usersurname_en  ${reg_data.persons_usersurname_en}
  Input Text  id=persons-email  ${reg_data.persons_email}
  Input Text  id=persons-telephone  ${reg_data.persons_telephone}
  Click Element  id=user-info1
  Click Element  id=user-info2
  Click Element  id=user-info3
  Click Element  id=user-subscribe_status
  Click Element  xpath=//button[contains(@class,"mk-btn_accept")]


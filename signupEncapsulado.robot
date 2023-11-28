*** Settings ***
Documentation        Suite de testes de cadastro de dog walker
Library              Browser


*** Test Cases ***
Deve validar a tela de cadasro de um novo Dog walker
    
    #Massa de teste
    ${name}                  Set Variable        Jonathan teste 
    ${email}                 Set Variable        jonteste@teste.com  
    ${cpf}                   Set Variable        77002758152
    ${cep}                   Set Variable        72914502
    ${addressStreet}         Set Variable        Quadra 4 Conjunto A
    ${addressNumber}         Set Variable        14
    ${addressDetails}        Set Variable        apto 204
    ${addressDistrict}       Set Variable        Parque da Barragem Setor 06
    ${addressCityUf}         Set Variable        Águas Lindas de Goiás/GO
    ${cnh}                   Set Variable        toretto.jpg

    Go to signup page
    Fill signup form    ${name}    ${email}    ${cpf}    ${cep}    ${addressStreet}    ${addressDistrict}    ${addressCityUf}    ${addressNumber}    ${addressDetails}    ${cnh}
    Submit signup form
    Popup should be     Recebemos o seu cadastro e em breve retornaremos o contato.


*** Keywords ***

Go to signup page
    New Browser        browser=chromium        headless=False
    #Acessando o site
    New Page           https://walkdog.vercel.app/signup

    Wait For Elements State    form h1    visible    5000
    Get Text                   form h1    equal        Faça seu cadastro

 Fill signup form
    [Arguments]    ${name}    ${email}    ${cpf}    ${cep}    ${addressStreet}    ${addressDistrict}    ${addressCityUf}    ${addressNumber}    ${addressDetails}    ${cnh}

    Fill Text    css=input[name=name]              ${name}
    Fill Text    css=input[name=email]             ${email}
    Fill Text    css=input[name=cpf]               ${cpf}
    Fill Text    css=input[name=cep]               ${cep}

    Click        css=input[type=button][value$=CEP]

    Get Property    css=input[name=addressStreet]      value    equal      ${addressStreet}
    Get Property    css=input[name=addressDistrict]    value    equal      ${addressDistrict}
    Get Property    css=input[name=addressCityUf]      value    equal      ${addressCityUf}

    Fill Text    css=input[name=addressNumber]     ${addressNumber}
    Fill Text    css=input[name=addressDetails]    ${addressDetails}

    Upload File By Selector    css=input[type=file]    ${EXECDIR}/${cnh}

Submit signup form
    Click    css=.button-register

Popup should be
    [Arguments]    ${expected_text}

    Wait For Elements State    css=.swal2-html-container    visible    5
    Get Text                   css=.swal2-html-container    equal      ${expected_text}

    #Capturando a evidência do teste
    Take Screenshot

    #Pausa para visualizar as informções
    Sleep    5
*** Settings ***
Documentation        Suite de testes de cadastro de dog walker
Library              Browser


*** Test Cases ***
Deve validar a tela de cadasro de um novo Dog walker
    
    #Massa de teste com super variavel
     ${dog_walker}        Create Dictionary    
    ...                  name=Jonathan Teste
    ...                  email=jonteste@teste.com
    ...                  cpf=77002758152
    ...                  cep=72914502
    ...                  street=Quadra 4 Conjunto A
    ...                  number=404
    ...                  details=apto 204
    ...                  district=Parque da Barragem Setor 06
    ...                  city_uf=Águas Lindas de Goiás/GO
    ...                  cnh=toretto.jpg

    Go to signup page
    Fill signup form    ${dog_walker}
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
    [Arguments]    ${dog_walker}

    Fill Text    css=input[name=name]              ${dog_walker}[name]
    Fill Text    css=input[name=email]             ${dog_walker}[email]
    Fill Text    css=input[name=cpf]               ${dog_walker}[cpf]
    Fill Text    css=input[name=cep]               ${dog_walker}[cep]

    Click        css=input[type=button][value$=CEP]

    Get Property    css=input[name=addressStreet]      value    equal      ${dog_walker}[street]
    Get Property    css=input[name=addressDistrict]    value    equal      ${dog_walker}[district]
    Get Property    css=input[name=addressCityUf]      value    equal      ${dog_walker}[city_uf]

    Fill Text    css=input[name=addressNumber]     ${dog_walker}[number]
    Fill Text    css=input[name=addressDetails]    ${dog_walker}[details]

    Upload File By Selector    css=input[type=file]    ${EXECDIR}/${dog_walker}[cnh]

Submit signup form
    Click    css=.button-register

Popup should be
    [Arguments]    ${expected_text}

    Wait For Elements State    css=.swal2-html-container    visible    5
    Get Text                   css=.swal2-html-container    equal      ${expected_text}

    #Capturando a evidência do teste
    Take Screenshot

    #Pausa para visualizar as informções
    Sleep    20
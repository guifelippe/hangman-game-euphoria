include std/io.e
include std/filesys.e

sequence palavras = {}
sequence palavra_secreta

procedure ler_palavras()
    object file = open("words.txt", "r")
    if file = -1 then
        puts("Erro ao abrir o arquivo 'words.txt'\n", 2)
        return
    end if

    sequence linha

    while 1 do
        linha = gets(file)
        if linha = -1 or length(linha) = 0 then
            exit
        end if
        palavras = append(palavras, linha)
    end while

    close(file)
end procedure

procedure escolher_palavra()
    integer indice = rand(length(palavras))
    palavra_secreta = palavras[indice]
end procedure

function palavra_completa(sequence palavra_adivinhada)
    integer i = 1
    integer todas_adivinhadas = 1

    while i <= length(palavra_secreta) do
        if palavra_adivinhada[i] = "_" then
            todas_adivinhadas = 0
            exit
        end if
        i += 1
    end while

    if todas_adivinhadas = 1 then
        return 1
    else
        return 0
    end if
end function

procedure main()
    ler_palavras()
    escolher_palavra()
    sequence palavra_adivinhada = repeat("_", length(palavra_secreta))
    integer erros = 0
    integer max_erros = 6

    while erros < max_erros and not (palavra_completa(palavra_adivinhada) = 1) do
        puts("Palavra: " & palavra_adivinhada & "\n", 1)
        puts("Erros restantes: " & (max_erros - erros) & "\n", 1)
        puts("Adivinhe uma letra: ", 1)
        sequence entrada = gets(1)
        if not find(entrada, palavra_secreta) then
            erros += 1
        else
            integer j = 1
            while j <= length(palavra_secreta) do
                if palavra_secreta[j] = entrada then
                    palavra_adivinhada[j] = entrada
                end if
                j = j + 1
            end while
        end if
    end while

    if palavra_completa(palavra_adivinhada) = 1 then
        puts("Você venceu! A palavra era: " & palavra_secreta & "\n", 1)
    else
        puts("Você perdeu! A palavra era: " & palavra_secreta & "\n", 1)
    end if
end procedure

main()
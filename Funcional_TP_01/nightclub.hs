-- Punto 1----------------------------------------------------------------------------------------------------------------
data Cliente = Cliente String Int [Cliente] deriving (Show)

nombre :: Cliente -> String
nombre (Cliente nombre _ _) = nombre

resistencia :: Cliente -> Int
resistencia (Cliente _ resistencia _) = resistencia

amigos :: Cliente -> [Cliente]
amigos (Cliente _ _ amigos) = amigos

-- Punto 2----------------------------------------------------------------------------------------------------------------

rodri = Cliente "Rodri" 55 []
marcos = Cliente "Marcos" 40 [rodri]
cristian = Cliente "Cristian" 2 []
ana = Cliente "Ana" 120 [marcos,rodri]

-- Punto 3----------------------------------------------------------------------------------------------------------------
comoEsta::Cliente->String
comoEsta cliente 
    |resistencia cliente > 50 = "fresco"
    |length (amigos cliente) > 1 = "piola"
    |otherwise = "duro"

-- Punto 4----------------------------------------------------------------------------------------------------------------
esAmigoNuevo::Cliente->Cliente->Bool
esAmigoNuevo cliente amigo = not (any (==nombre amigo) (map nombre (amigos cliente))) && (nombre cliente /= nombre amigo)

reconocerAmigo::Cliente->Cliente->Cliente
reconocerAmigo cliente amigo
    | esAmigoNuevo cliente amigo = Cliente (nombre cliente) (resistencia cliente) ((amigos cliente) ++ [amigo])
    | otherwise = Cliente (nombre cliente) (resistencia cliente) (amigos cliente)

-- Punto 5----------------------------------------------------------------------------------------------------------------
grog::Cliente->Cliente
grog cliente = Cliente (nombre cliente) 0 (amigos cliente)

jarraLoca::Cliente->Cliente
jarraLoca cliente = Cliente (nombre cliente) (resistencia cliente - 10) (map jarraLoca (amigos cliente))

klusener::String->Cliente->Cliente
klusener sabor cliente = Cliente (nombre cliente) ((resistencia cliente) - length(sabor)) (amigos cliente)

tintico::Cliente->Cliente
tintico cliente = Cliente (nombre cliente) (resistencia cliente + 5 * length(amigos cliente)) (amigos cliente)

soda::Int->Cliente->Cliente
soda fuerza cliente = Cliente ("e" ++ (replicate fuerza 'r') ++ "p" ++ (nombre cliente)) (resistencia cliente) (amigos cliente)

-- Punto 6----------------------------------------------------------------------------------------------------------------
rescatarse::Int->Cliente->Cliente
rescatarse horas cliente
    | horas > 3 = Cliente (nombre cliente) (resistencia cliente + 200) (amigos cliente)
    | otherwise = Cliente (nombre cliente) (resistencia cliente + 100) (amigos cliente)

-- Punto 7----------------------------------------------------------------------------------------------------------------

--Consulta ejecucion en consola
--((klusener "huevo").(rescatarse 2).(klusener "chocolate").(jarraLoca)) ana
-- Punto 1

data Cliente = Cliente String Int [Cliente] deriving (Show)

nombre :: Cliente -> String
nombre (Cliente nombre _ _) = nombre

resistencia :: Cliente -> Int
resistencia (Cliente _ resistencia _) = resistencia

amigos :: Cliente -> [Cliente]
amigos (Cliente _ _ amigos) = amigos

-- Punto 2

rodri = Cliente "Rodri" 55 []
marcos = Cliente "Marcos" 40 [rodri]
cristian = Cliente "Cristian" 2 []
ana = Cliente "Ana" 120 [marcos,rodri]

-- Punto 3

comoEsta cliente 
    |resistencia cliente > 50 = "fresco"
    |length (amigos cliente) > 1 = "piola"
    |otherwise = "duro"

-- Punto 4

esAmigoNuevo cliente amigo = not (any (==nombre amigo) (map nombre (amigos cliente))) && (nombre cliente /= nombre amigo)

reconocerAmigo::Cliente->Cliente->Cliente

reconocerAmigo cliente amigo
    | esAmigoNuevo cliente amigo = Cliente (nombre cliente) (resistencia cliente) ((amigos cliente) ++ [amigo])
    | otherwise = Cliente (nombre cliente) (resistencia cliente) (amigos cliente)

-- Punto 5

grog cliente = Cliente (nombre cliente) 0 (amigos cliente)

--jarraLoca cliente = Cliente (nombre cliente) ((resistencia cliente) - 10) (map (-10) (resistencia(amigos cliente)))

klusener sabor cliente = Cliente (nombre cliente) ((resistencia cliente) - length(sabor)) (amigos cliente)

tintico cliente = Cliente (nombre cliente) (resistencia cliente + 5* length(amigos cliente)) (amigos cliente)

soda fuerza cliente = Cliente ("e" ++ (replicate fuerza 'r') ++ "p" ++ (nombre cliente)) (resistencia cliente) (amigos cliente)

-- Punto 6

rescatarse horas cliente
    | horas > 3 = Cliente (nombre cliente) (resistencia cliente + 200) (amigos cliente)
    | otherwise = Cliente (nombre cliente) (resistencia cliente + 100) (amigos cliente)

-- Punto 7

-- comentado para que compile, la siguiente línea se corre por consola.
-- klusener huevo (rescatarse 2 (klusener chocolate (jarraLoca ana)))

data Bebida = Bebida {nombreBebida::String, resistenciaBebida::Int} deriving (Show)
jarraLoca = Bebida "jarra loca" 10

klunsterSabor:: String->Bebida
klunsterSabor sabor = Bebida ("Klunster sabor "++ sabor) (length(sabor))

tinticoB::Cliente->Bebida
tinticoB cliente = Bebida ("Tintico") (5* length(amigos cliente))

sodaB = Bebida "Soda" 0

tomar:: Bebida->Cliente->Cliente

tomar unaBebida unCliente = Cliente (nombre unCliente)  (resistencia unCliente - resistenciaBebida unaBebida) (amigos unCliente)

--Consulta ejecutada con aplicacion parcial y composicion
--Main> ((tomar (klunsterSabor "huevo")).(rescatarse 2).(tomar (klunsterSabor "chocolate")).(tomar jarraLoca)) ana

--Cliente "Ana" 196 [Cliente "Marcos" 30 [Cliente "Rodri" 45 []],Cliente "Rodri" 45 []]

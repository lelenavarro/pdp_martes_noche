-- Punto 1----------------------------------------------------------------------------------------------------------------
data Cliente = Cliente {nombre :: String, resistencia :: Int, amigos :: [Cliente]} deriving (Show)

--nombre :: Cliente -> String
--nombre (Cliente nombre _ _) = nombre

--resistencia :: Cliente -> Int
--resistencia (Cliente _ resistencia _) = resistencia

--amigos :: Cliente -> [Cliente]
--amigos (Cliente _ _ amigos) = amigos

-- Punto 2----------------------------------------------------------------------------------------------------------------

rodri = Cliente "Rodri" 55 []
marcos = Cliente "Marcos" 40 [rodri]
cristian = Cliente "Cristian" 2 []
ana = Cliente "Ana" 120 [marcos,rodri]

-- Punto 3----------------------------------------------------------------------------------------------------------------
comoEsta::Cliente->String 
comoEsta cliente
    |(resistencia cliente) > 50 = "fresco"
    |length (amigos cliente) > 1 = "piola"
    |otherwise = "duro"

-- Punto 4----------------------------------------------------------------------------------------------------------------
esAmigoNuevo::Cliente->Cliente->Bool -- Correccion simplificacion de funcion usando notElem
esAmigoNuevo cliente amigo =  (notElem (nombre amigo) (map nombre (amigos cliente))) && (nombre cliente /= nombre amigo)

--Correccion usando funcion Error
reconocerAmigo cliente amigo	
    | nombre cliente == nombre amigo = error "El cliente no puede ser igual al amigo"
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
 --Correccion usando una abstraccion
aumentaResistencia cliente valor = Cliente (nombre cliente) (resistencia cliente + valor) (amigos cliente)

rescatarse::Int->Cliente->Cliente
rescatarse horas cliente
    | horas > 3 = aumentaResistencia cliente 200
    | otherwise = aumentaResistencia cliente 100
 

-- Punto 7----------------------------------------------------------------------------------------------------------------

--Consulta ejecucion en consola
--((klusener "huevo").(rescatarse 2).(klusener "chocolate").(jarraLoca)) ana
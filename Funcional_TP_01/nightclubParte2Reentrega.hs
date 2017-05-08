import Text.Show.Functions
import Data.List
-- Punto 1----------------------------------------------------------------------------------------------------------------
data Cliente = Cliente {nombre :: String, resistencia :: Int, amigos :: [Cliente], bebidas :: [Cliente->Cliente]} deriving (Show)


-- Punto 2----------------------------------------------------------------------------------------------------------------

rodri = Cliente "Rodri" 55 [] [tintico]
marcos = Cliente "Marcos" 40 [rodri] [klusener "Guinda"]
cristian = Cliente "Cristian" 2 [] [grog,jarraLoca]
ana = Cliente "Ana" 120 [marcos,rodri] []

-- Punto 3----------------------------------------------------------------------------------------------------------------
comoEsta::Cliente->String --Correccion resuelto con composicion
comoEsta cliente
    |((>50).(resistencia)) cliente = "fresco"
    |((>1).(length).(amigos)) cliente = "piola"
    |otherwise = "duro"

-- Punto 4----------------------------------------------------------------------------------------------------------------
esAmigoNuevo::Cliente->Cliente->Bool -- Correccion simplificacion de funcion usando notElem
esAmigoNuevo cliente amigo =  (notElem (nombre amigo) (map nombre (amigos cliente))) && (nombre cliente /= nombre amigo)

--Correccion usando funcion Error
reconocerAmigo cliente amigo
    | nombre cliente == nombre amigo = error "El cliente no puede ser igual al amigo"
    | esAmigoNuevo cliente amigo = Cliente (nombre cliente) (resistencia cliente) ((amigos cliente) ++ [amigo]) (bebidas cliente)
    | otherwise = Cliente (nombre cliente) (resistencia cliente) (amigos cliente) (bebidas cliente)

-- Punto 5----------------------------------------------------------------------------------------------------------------
grog::Cliente->Cliente
grog cliente = Cliente (nombre cliente) 0 (amigos cliente) (grog : bebidas cliente)

jarraLoca::Cliente->Cliente
jarraLoca cliente = Cliente (nombre cliente) (resistencia cliente - 10) (map jarraLoca (amigos cliente)) (jarraLoca : bebidas cliente)

klusener::String->Cliente->Cliente
klusener sabor cliente = Cliente (nombre cliente) ((resistencia cliente) - length(sabor)) (amigos cliente) (klusener sabor : bebidas cliente)

tintico::Cliente->Cliente
tintico cliente = Cliente (nombre cliente) (resistencia cliente + 5 * length(amigos cliente)) (amigos cliente) (tintico : bebidas cliente)

soda::Int->Cliente->Cliente
soda fuerza cliente = Cliente ("e" ++ (replicate fuerza 'r') ++ "p" ++ (nombre cliente)) (resistencia cliente) (amigos cliente) (soda fuerza : bebidas cliente)

-- Punto 6----------------------------------------------------------------------------------------------------------------
 --Correccion usando una abstraccion
aumentaResistencia cliente valor = Cliente (nombre cliente) (resistencia cliente + valor) (amigos cliente) (bebidas cliente)

rescatarse::Int->Cliente->Cliente
rescatarse horas cliente
    | horas > 3 = aumentaResistencia cliente 200
    | otherwise = aumentaResistencia cliente 100
 

-- Punto 7----------------------------------------------------------------------------------------------------------------

--Consulta ejecucion en consola
--((klusener "huevo").(rescatarse 2).(klusener "chocolate").(jarraLoca)) ana


--Parte 2 - Punto 1-------------------------------------------------------------------------------------------------------
tomarTragos::Cliente->[Cliente->Cliente]->Cliente
tomarTragos cliente [] = cliente
tomarTragos cliente (x:xs) = tomarTragos (x cliente) xs

dameOtro::Cliente->Cliente
dameOtro cliente =  last (bebidas cliente) cliente

---Parte 2- Punto 2 ------------------------------------------------------------------------------------------------------
cualesPuedeTomar:: Cliente->[Cliente->Cliente]->[Cliente->Cliente]
masDeCero cliente bebida = resistencia (bebida cliente) > 0 
cualesPuedeTomar cliente tragos = filter (masDeCero cliente)  (tragos)

cuantasPuedeTomar:: Cliente->[Cliente->Cliente]->Int
cuantasPuedeTomar cliente tragos = length(cualesPuedeTomar cliente tragos)

---Parte 2- Punto 3 ------------------------------------------------------------------------------------------------------

data Itinerario = Itinerario {nombreItinerario::String, duracion::Float , accionItinerario::[Cliente->Cliente]} deriving (Show)

robertoCarlos = Cliente "Roberto Carlos" 165 [] []

itinerarioVacio = Itinerario "Itinerario Vacio" 0 []
mezclaExplosiva = Itinerario "Mezcla Explosiva" 2.5 [grog, grog, klusener "Huevo", klusener "Frutilla"]
itinerarioBasico = Itinerario "Itinerario Basico" 5.0 [jarraLoca, klusener "Chocolate", rescatarse 2, klusener "Huevo"]
salidaDeAmigos = Itinerario  "Salida de Amigos" 1.0 [soda 1, tintico, flip reconocerAmigo robertoCarlos, jarraLoca]

aplicarFuncion::Cliente->(Cliente->Cliente)->Cliente
aplicarFuncion cliente funcion = funcion cliente

hacerItinerario::Cliente->Itinerario->Cliente
hacerItinerario cliente itinerario = foldl (aplicarFuncion) cliente (accionItinerario itinerario)

---Parte 2- Punto 4 ------------------------------------------------------------------------------------------------------
intensidad::Itinerario->Float
intensidad itinerario = 1 * genericLength(accionItinerario itinerario) / duracion itinerario

maximaIntensidad::Itinerario->Itinerario->Itinerario
maximaIntensidad itinerario1 itinerario2 
  | (intensidad itinerario1) > (intensidad itinerario2) = itinerario1
  | otherwise = itinerario2

hacerElMasIntenso::Cliente->[Itinerario]->Cliente
hacerElMasIntenso cliente listaItinerarios = hacerItinerario cliente (foldl (maximaIntensidad) itinerarioVacio listaItinerarios)

---Parte 2- Punto 5 ------------------------------------------------------------------------------------------------------

todasLasSodas n = (soda n) : (todasLasSodas (n + 1))

chuckNorris = Cliente "Chuck" 1000 [ana] (todasLasSodas 1)

--NO puede pedir dameOtro porque nunca llegaria al ultimo elemento de una lista infinita y da un error de tipo: ERROR - Garbage collection fails to reclaim sufficient space
--SI se puede preguntar si chuckNorris tiene más resistencia que ana porque la resistencia no depende de la lista infinita, solo se toman los valores enteros para la comparacion

---Parte 2- Punto 6 BONUS ------------------------------------------------------------------------------------------------------

laJarraPopular 0 cliente = cliente
laJarraPopular espirituosidad (Cliente nombre resistencia (cab:cola) bebidas) = laJarraPopular (espirituosidad - 1) (hacerGrupoAmigos ((Cliente nombre resistencia (cab:cola) bebidas)) cab)

hacerGrupoAmigos cliente (Cliente nombre resistencia amigos bebidas) = hacerMuchosAmigos cliente amigos

hacerMuchosAmigos cliente [] = cliente
hacerMuchosAmigos cliente (cab:cola) = hacerMuchosAmigos (reconocerAmigo cab cliente) cola



--Night Club 2 - Grupo 01
import Data.List
import Text.Show.Functions
--Punto 01

--Modificaciones en la abstraccion de cliente y otras funciones
data Cliente = Cliente {
 nombre :: String,
 resistencia :: Int,
 amigos :: [Cliente],
 bebidas :: [Bebidas]
} deriving (Show)

data Bebidas = GrogXD | JarraLoca | Klusener String | Tintico | Soda Int deriving Show

rodri = Cliente "Rodri" 55 [] [Tintico]
marcos = Cliente "Marcos" 40 [rodri] [Klusener "Guinda"]
cristian = Cliente "Cristian" 2 [] [GrogXD, JarraLoca]
ana = Cliente "Ana" 120 [marcos, rodri] []

--Tipado
grogXD:: Cliente -> Cliente
jarraLoca:: Cliente -> Cliente
klusener:: String -> Cliente -> Cliente
tintico:: Cliente -> Cliente
soda:: Int -> Cliente -> Cliente
rescatarse:: Int -> Cliente -> Cliente
esAmigoNuevo:: Cliente -> Cliente -> Bool

beber GrogXD = grogXD
beber JarraLoca = jarraLoca
beber Tintico = tintico
beber (Klusener sabor) = klusener sabor
beber (Soda fuerza) = soda fuerza

grogXD cliente = Cliente (nombre cliente) 0 (amigos cliente) (GrogXD : bebidas cliente)
jarraLoca cliente = Cliente (nombre cliente) (resistencia cliente - 10) (map jarraLoca (amigos cliente)) (JarraLoca : bebidas cliente)
klusener sabor cliente = Cliente (nombre cliente) ((resistencia cliente) - length(sabor)) (amigos cliente) ((Klusener sabor) : bebidas cliente)
tintico cliente = Cliente (nombre cliente) (resistencia cliente + 5 * length(amigos cliente)) (amigos cliente) (Tintico : bebidas cliente)
soda fuerza cliente = Cliente ("e" ++ (replicate fuerza 'r') ++ "p" ++ (nombre cliente)) (resistencia cliente) (amigos cliente) ((Soda fuerza) : bebidas cliente)

esAmigoNuevo cliente amigo =  (notElem (nombre amigo) (map nombre (amigos cliente))) && (nombre cliente /= nombre amigo)

reconocerAmigo amigo cliente
    | nombre cliente == nombre amigo = error "El cliente no puede ser igual al amigo"
    | esAmigoNuevo cliente amigo = Cliente (nombre cliente) (resistencia cliente) ([amigo] ++ (amigos cliente)) (bebidas cliente)
    | otherwise = Cliente (nombre cliente) (resistencia cliente) (amigos cliente) (bebidas cliente)

aumentaResistencia cliente valor = Cliente (nombre cliente) (resistencia cliente + valor) (amigos cliente) (bebidas cliente)

rescatarse horas cliente
    | horas > 3 = aumentaResistencia cliente 200
    | otherwise = aumentaResistencia cliente 100


--Punto 01.C 
--listaH : lista Head; listaT : lista Tail
tomarTragos cliente [] = cliente
tomarTragos cliente (tragoH : tragoT) = tomarTragos ((beber tragoH) cliente) tragoT

--Punto 01.D
dameOtro (Cliente nombre resistencia amigos bebidas) = beber (last (bebidas)) (Cliente nombre resistencia amigos bebidas)

--Punto 02.A
newResistencia cliente GrogXD = 0
newResistencia (Cliente _ resistencia _ _) JarraLoca = resistencia - 10
newResistencia (Cliente _ resistencia _ _) (Klusener sabor) = resistencia - length(sabor)
newResistencia (Cliente _ resistencia amigos _) Tintico = resistencia + 5 * (length amigos)
newResistencia (Cliente _ resistencia _ _) (Soda _) = resistencia

cualesPuedeTomar cliente tragos = filter ((>0).newResistencia cliente) tragos

--Punto 02.B
cuantasPuedeTomar cliente = (length.(cualesPuedeTomar cliente))

--Punto 03.A
robertoCarlos = Cliente "Roberto Carlos" 165 [] []

data Itinerario = Itinerario {
    nombreItinerario :: String,
    duracion :: Float,
    acciones :: [Cliente -> Cliente]
} deriving (Show)

mezclaExplosiva = Itinerario "Mezcla explosiva" 2.5 [beber GrogXD, beber GrogXD, beber (Klusener "Huevo"), beber (Klusener "Frutilla")]
itinerarioBasico = Itinerario "Itinerario básico" 5 [beber JarraLoca, beber (Klusener "Chocolate"), rescatarse 2, beber (Klusener "Huevo")]
salidaDeAmigos = Itinerario "Salida de Amigos" 1 [beber (Soda 1), beber Tintico, reconocerAmigo robertoCarlos, beber JarraLoca]

--Punto 03.B
ejecutarItinerario :: Itinerario -> Cliente -> Cliente
ejecutarItinerario itinerario = foldl1 (.) ((reverse.acciones) itinerario)

--Punto 04.A
intensidad :: Itinerario -> Float
intensidad itinerario = (genericLength.acciones) itinerario / duracion itinerario

--Punto 04.B
buscar max [] = max
buscar max (head:tail) 
    |intensidad max > intensidad head = buscar max (tail)
    |otherwise = buscar head (tail)

ejecutarMasIntenso cliente (head:tail) = ejecutarItinerario (buscar head tail) cliente

--Punto 05

todasLasSodas n = (Soda n) : (todasLasSodas (n + 1))
chuckNorris = Cliente "Chuck" 1000 [ana] (todasLasSodas 1)

--Punto 05.b
--No, chuckNorris no puede pedir otro trago con la función dameOtro porque esta funcion utiliza el ultimo elemento de la lista de bebibas del cliente, 
--y la lista de chuck es infinita; y Haskell usa evalucion diferida para intentar encontrar cual es la ultima bebida y no la va a encontrar.

--Punto 05.d
--Si, se puede. Porque Haskell al usar "lazy evaluation", solo revisa la resistencia de ambos y no llega a revisar la lista infinita que tiene 
--el cliente chuckNorris

--Punto 06

laJarraPopular 0 cliente = cliente
laJarraPopular espirituosidad (Cliente nombre resistencia (cab:cola) bebidas) = laJarraPopular (espirituosidad - 1) (hacerGrupoAmigos ((Cliente nombre resistencia (cab:cola) bebidas)) cab)

hacerGrupoAmigos cliente (Cliente nombre resistencia amigos bebidas) = hacerMuchosAmigos cliente amigos

hacerMuchosAmigos cliente [] = cliente
hacerMuchosAmigos cliente (cab:cola) = hacerMuchosAmigos (reconocerAmigo cab cliente) cola
--Night Club 2 - Grupo 01

--Punto 01
data Cliente = Cliente {
 nombre :: String,
 resistencia :: Int,
 amigos :: [Cliente],
 bebidas :: [Bebidas]
} deriving (Show)

--Modificaciones en la abstraccion de cliente y otras funciones
data Bebidas = GrogXD | JarraLoca | Klusener String | Tintico | Soda Int deriving Show

rodri = Cliente "Rodri" 55 [] [Tintico]
marcos = Cliente "Marcos" 40 [rodri] [Klusener "Guinda"]
cristian = Cliente "Cristian" 2 [] [GrogXD, JarraLoca]
ana = Cliente "Ana" 120 [marcos, rodri] []

beber GrogXD = grogXD
beber JarraLoca = jarraLoca
beber Tintico = tintico
beber (Klusener sabor) = klusener sabor
beber (Soda fuerza) = soda fuerza

grogXD::Cliente->Cliente
grogXD cliente = Cliente (nombre cliente) 0 (amigos cliente) (GrogXD : bebidas cliente)

jarraLoca::Cliente->Cliente
jarraLoca cliente = Cliente (nombre cliente) (resistencia cliente - 10) (map jarraLoca (amigos cliente)) (JarraLoca : bebidas cliente)

klusener::String->Cliente->Cliente
klusener sabor cliente = Cliente (nombre cliente) ((resistencia cliente) - length(sabor)) (amigos cliente) ((Klusener sabor) : bebidas cliente)

tintico::Cliente->Cliente
tintico cliente = Cliente (nombre cliente) (resistencia cliente + 5 * length(amigos cliente)) (amigos cliente) (Tintico : bebidas cliente)

soda::Int->Cliente->Cliente
soda fuerza cliente = Cliente ("e" ++ (replicate fuerza 'r') ++ "p" ++ (nombre cliente)) (resistencia cliente) (amigos cliente) ((Soda fuerza) : bebidas cliente)

--Punto 01.C 
--listaH : lista Head; listaT : lista Tail
tomarTragos cliente [] = cliente
tomarTragos cliente (tragoH : tragoT) =  tomarTragos ((beber tragoH) cliente) tragoT

--Punto 01.D
dameOtro (Cliente nombre resistencia amigos (bebidaH:bebidasT)) = (beber bebidaH) (Cliente nombre resistencia amigos (bebidaH:bebidasT))

--Punto 02.A
newResistencia cliente GrogXD = 0
newResistencia (Cliente _ resistencia _ _) JarraLoca = resistencia - 10
newResistencia (Cliente _ resistencia _ _) (Klusener sabor) = resistencia - length(sabor)
newResistencia (Cliente _ resistencia amigos _) Tintico = resistencia + 5 * (length amigos)
newResistencia (Cliente _ resistencia _ _) (Soda _)= resistencia

cualesPuedeTomar cliente tragos = filter ((>0).newResistencia cliente) tragos

--Punto 02.B
cuantasPuedeTomar cliente= (length.(cualesPuedeTomar cliente)) 
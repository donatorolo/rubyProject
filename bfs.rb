#############################################
# Programacion Orientada a Objetos - Tarea  #
#                                           #
#   Carlos Aponte           09-10041        #
#   Donato Rolo             10-10640        #
#-------------------------------------------#
#                                           #
#     Pregunta 2: Busqueda Generalizada     #
#                                           #
#############################################

################################################################################
#                                                                              #
#                               Modulo BFS                                     #
#                                                                              #
#    Los procedimientos de este modulo pueden operar indistintamente sobre     #
#     objetos de las clases BinTree y GraphNode. Los procedimientos son:       # 
#                                                                              #
#                         -find   -path    -walk.                              #
#                                                                              #
################################################################################

module BFS

# Procedimiento find:
# 
# Comienza la búsqueda BFS a partir del objeto "start" hasta encontrar el primer
# objeto que cumpla con el predicado "predicate" y lo retorna. Si se agota la 
# búsqueda sin encontrar objetos que cumplan el predicado se retorna  nil.

    def find(start, predicate)

        ruta = camino(start,predicate)
        if ruta == nil 
            return nil
        else 
            return ruta.last
        end
    end

# Procedimiento path:
# 
# Comienza la búsqueda BFS a partir del objeto "start" hasta encontrar el
# primer objeto que cumpla con el predicado "predicate", retornando el camino
# desde "start" hasta el nodo encontrado en forma de Array. Si se agota la
# búsqueda sin encontrar un objetos que cumplan el predicado retorna  nil.

    def path(start, predicate)

        # Recibe una lista de caminos y verifica si hay uno hacia el nodo
        # con valos 'elem'.
        ruta = camino(start,predicate)

        if ruta == nil 
            return nil
        else 
            return ruta
        end
    end


# Predicado walk:
# 
# Comienza un recorrido BFS a partir del objeto "start" hasta agotar todo el
# espacio de búsqueda, ejecuta el cuerpo de código "action" sobre cada nodo 
# visitado y retorna un Array con los nodos visitados. Si el cuerpo de código
# "action" se omite, sólo retorna el Array con los nodos visitados.

    def walk(start, action = lambda{|x| x})

        faltantes = [start]
        visitados = []
        
        block= lambda{ |hijo| if hijo != nil; faltantes << hijo; end}
        
        while !faltantes.empty?
            tmp = faltantes.shift
            action.call(tmp)
            visitados.push(tmp)
            tmp.each(&block)
        end

        return visitados
    end


################################
#   Procedimientos Auxiliares  #
################################

    
# Predicado armar_camino:
# Devuelve el camino del nodo de "inicio" al nodo "fin" haciendo un recorrido
# inverso sobre los padres de cada nodo de una corrida de BFS previa
    def armar_camino(padre, inicio,fin)

        camino = [fin]
        actual = fin

        while (actual != inicio)
            actual = padre[actual]
            camino.unshift(actual)
        end

        return camino
    end

# Procedimiento: camino
# Recorre la estructura correspondiente usando el algoritmo de BFS y retorna
# el camino desde el nodo de inicio "start" hasta el primer nodo que cumpla
# el predicado "predicate"
    def camino (start,predicate)

        camino = []
        padre = Hash.new
        anterior = start

        if predicate.call(start)
            start
        else

            faltantes = []
            temporal = []
            block = lambda{ |hijo| if !(hijo.nil?); temporal << hijo; end}

            start.each(&block) #Calcula los hijos del nodo

            # Establezco la relacion padre-hijo de los nodos
            temporal.each do |hijo|
                padre[hijo] = start   
                faltantes.push(hijo)    
            end

            temporal = [] #Limpia la "cola" temporal
        
            while !faltantes.empty?

                tmp = faltantes.shift

                if predicate.call(tmp)

                    camino = armar_camino(padre,start,tmp) #Arma el camino 
                    return camino
                end
           
                tmp.each(&block) #Calcula los hijos del nodo

                # Establezco la relacion padre-hijo de los nodos
                temporal.each do |hijo|
                    padre[hijo] = tmp  
                    faltantes.push(hijo)
                end


                temporal = [] #Limpia la "cola" temporal

                anterior = tmp
            end

            return nil 
        end
    end
end


################################################################################
#                                                                              #
#                                   Clases                                     #
#                                                                              #
#                 Clases que trabajaran con el modulo/mixin BFS                #
#                    -BinTree     -NodeGraph        -LCR                       #
#                                                                              #
################################################################################


# #############################################################################
# Clase GraphNode: 
# Representa un grafo arbitrario a partir de un nodo especifico y sus hijos.
# #############################################################################
class GraphNode

    include BFS
    attr_accessor :value,   # Valor alamacenado en el nodo
                  :children # Arreglo de sucesores GraphNode
    
    def initialize(v,c)
        @value = v
        @children = c
    end
    
    def each(&block)

        if self.children
            @children.each do |siguiente|
                block.call(siguiente) if siguiente
            end
        end
    end
end

# #############################################################################
# Clase BinTree: 
# Representa un arbol binario generico.
# #############################################################################
class BinTree

    include BFS
    attr_accessor :value, # Valor almacenado en el nodo
                  :left,  # BinTree izquierdo
                  :right  # BinTree derecho

    def initialize(v,l,r)
        @value = v
        @left = l
        @right = r
    end
    
    def each(&block)
        block.call( self.left  ) if self.left
        block.call( self.right ) if self.right
    end
end


# #############################################################################
# Clase LCR
# Represanta el problema de: Lobo, Cabra, Repollo mediante un grafo de estados
# #############################################################################
class LCR
    include BFS
    attr_reader :value

    #Where indica si estamos en la orilla izq o derecha
    # left y right indican que elementos (lobo,cabra,repollo) hay en cada orilla

    def initialize(where,left,right) # Indique los argumentos

        sleft = []
        sright = []
        
        left.each do |obj|
            sleft.push(obj.to_sym)
        end

        right.each do |obj|
            sright.push(obj.to_sym)
        end

        where = where.to_sym
    
        @value = {"where" => where, "left"  => sleft, "right" => sright}
    end


    #Itera sobre los posibles estados validos de mover obj de una orilla a otra
    def each(&block)

        # Si el bote esta del lado izquierdo
        if @value["where"].to_s == "left"

            #Movimiento con el bote vacio si
            ni = @value["left"]
            nd = @value["right"]
            posible = LCR.new("right",ni,nd)

            if posible.aceptable
              block.call(posible)
            end

            #Determina los movimientos validos con algun objeto
            elementos = @value["left"]
            elementos.each do |obj|
               
                #Simula el movimiento del obj a la derecha
                ni = Array.new(@value["left"])
                ni.delete(obj)
                nd = Array.new(@value["right"])
                nd.push(obj)

                #Crea un nuevo estado 
                posible = LCR.new("right",ni,nd)

                #Si el estado es valido lo usa
                if posible.aceptable
                  block.call(posible)
                end
            end

        # Si el bote esta del lado derecho
        else
            #Movimiento con el bote vacio
            ni = @value["left"]
            nd = @value["right"]
            posible = LCR.new("left",ni,nd)

            if posible.aceptable
                block.call(posible)
            end

            #Detemrina los movimientos validos con algun objeto
            elementos = @value["right"]
            elementos.each do |obj|
               
                #Simula el movimiento del obj a la izq
                nd = Array.new(@value["right"])
                nd.delete(obj)
                ni = Array.new(@value["left"])
                ni.push(obj)

                #Crea un nuevo estado 
                posible = LCR.new("left",ni,nd)

                #Si el estado es valido lo usa
                if posible.aceptable
                  block.call(posible)
                end
            end
        end
    end

# Procedimiento: solve
# Resuelve el problema LCR asumiendo que el objetivo es llevar todos los 
# objetos a la orilla derecha. Asi mismo, retorna los pasos necesarios para 
# llegar a dicha solucion.

    def solve
        fin = Proc.new{ |est| est == LCR.new(:right,[],[:lobo,:cabra,:repollo])}
        cam = path(self,fin)

        if !cam.nil?
           imprimir(cam)
        end
    end

################################
#   Procedimientos Auxiliares  #
################################

# Procedimiento: imprimir
# Imprime por pantalla el camino que representa la solucion del problema LCR 
    def imprimir(camino)
        i =1
        camino.each do |paso|
            if paso.value["left"].size == 3
                tab = "\t"
            elsif paso.value["left"].size == 2
                tab = "\t\t"
            elsif paso.value["left"].size == 1
                tab = "\t\t\t"
            else
                 tab = "\t\t\t\t"
            end

            puts "Paso #{i}: Lado Actual: #{paso.value["where"]}
                |    Orilla Izq: #{paso.value["left"]}  #{tab} 
                |    Orilla Der: #{paso.value["right"]}"
            puts
            i += 1  
        end
    end

# Procedimiento: aceptable
# Determina si un estado es aceptable. Esto es, si no tiene la combinacion de
# lobo-cabra, cabra-repollo en ninguna de sus orillas.
    def aceptable

        izq = self.value["left"]
        der = self.value["right"]
        act = self.value["where"]
        if((self.nil?) ||
           (izq.include?(:lobo) && izq.include?(:cabra) && act == :right ) || 
           (der.include?(:lobo) && der.include?(:cabra) && act == :left  ) || 
           (izq.include?(:repollo) && izq.include?(:cabra) && act == :right) ||
           (der.include?(:repollo) && der.include?(:cabra) && act == :left))
            return false
        end

        return true

    end


 # Overrride del metodo de comparacion profunda (==)
    def ==(elem)
        if elem.nil?
            return true
        end

        if ((@value["where"] == elem.value["where"]) &&
           (@value["right"].sort == elem.value["right"].sort) &&
           (@value["left"].sort == elem.value["left"].sort))

            return true
        else 
            return false
        end
    end

 end

 
#############################################
# Programacion Orientada a Objetos - Tarea  #
#                                           #
#   Carlos Aponte           09-10041        #
#   Donato Rolo             10-10640        #
#############################################
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

	    if predicate.call(start)
	        start
	    else
	        faltantes = []
	        block = lambda{ |hijo| if hijo != nil; faltantes << hijo; end}
	        start.each(&block)
	       
	        while !faltantes.empty?
	            tmp = faltantes.shift
	            
	            if predicate.call(tmp)
	                return tmp
	            end
	            
	            tmp.each(&block)
	        end
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
        def camino(lista,elem)
            lista.each do |x|
                if x.last.value == elem
                    return false
                end
            end
            return true
        end

        # Recibe una lista de los caminos mas cortos hacia cada nodo y 
        # retorna el que satisface el bloque 'predicate'
        def getCamino(lista,predicate)
            lista.each do |x|
                if predicate.call(x.last)
                    return x
                end
            end
            return nil
        end

        if predicate.call(start)

            return [start]

        else

            abiertos = []
            cerrados = []

            abiertos.push([start])

            while !abiertos.empty?

                cerrados << abiertos.shift
                actual = cerrados.last.clone

                block1 = lambda { |elemento| elemento == actual.last}
                block2 = lambda { |siguiente|
                    if ((siguiente != nil) && (self.camino(abiertos,siguiente)) && (self.camino(cerrados,siguiente)))
                        aux = actual.clone
                        x = Array.new(aux.push(siguiente))
                   	    abiertos.push(x)
                    end
                }

                elemento = start.find(start, block1)
                elemento.each(block2)

            end

            camino = getCamino(cerrados,predicate)
            return camino
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

end


# Clase GraphNode: 
# Representa un grafo arbitrario a partir de un nodo especifico.
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


################################################################################
#                                                                              #
#                                   Clases                                     #
#                                                                              #
#                 Clases que trabajaran con el modulo/mixin BFS                #
#                            -BinTree     -NodeGraph                           #
#                                                                              #
################################################################################


# Clase BinTree: 
# Representa un arbol binario generico.
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


if __FILE__ == $0

# Arbol de Prueba

	pisocincol = BinTree.new(10, nil,nil)
	pisocincor = BinTree.new(11, nil,nil)

	pisocuatrol = BinTree.new(8,pisocincol,pisocincor)
	pisocuatror = BinTree.new(9,nil,nil)

	pisotresbl = BinTree.new(6,pisocuatrol,pisocuatror)
	pisotresbr = BinTree.new(7,nil,nil)

	pisotresal = BinTree.new(4,nil,nil)
	pisotresar = BinTree.new(5,nil,nil)

	pisodosl = BinTree.new(2,pisotresal,pisotresar)
	pisodosr = BinTree.new(3,pisotresbl,pisotresbr)

	arbol = BinTree.new(1,pisodosl,pisodosr)

	# Con lo que uso el metodo find y path
	condicion = Proc.new { |x| return (x.value >= 3)}

	# Con lo que uso el metodo walk
	action = Proc.new{ |x| x.value = x.value * 2}

	puts "Uso del metodo Walk"
	arbol.walk(arbol,action).each do |elem|
		puts elem.value
	end

	puts "Uso del metodo find"
	arbol.find(arbol,condicion)


end
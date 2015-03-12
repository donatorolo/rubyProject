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
	        seccion = lambda{ |hijo| if hijo != nil; faltantes << hijo; end}
	        start.each(seccion)
	       
	        while !faltantes.empty?
	            tmp = faltantes.shift
	            
	            if predicate.call(tmp)
	                return tmp
	            end
	            
	            tmp.each(seccion)
	        end
	    end
	end

# Procedimiento path:
# 
# Comienza la búsqueda BFS a partir del objeto "start" hasta encontrar el
# primer objeto que cumpla con el predicado "predicate", retornando el camino
# desde "start" hasta el nodo encontrado en forma de Array. Si se agota la
# búsqueda sin encontrar un objetos que cumplan el predicado retorna  nil.










# Predicado walk:
# 
# Comienza un recorrido BFS a partir del objeto "start" hasta agotar todo el
# espacio de búsqueda, ejecuta el cuerpo de código "action" sobre cada nodo 
# visitado y retorna un Array con los nodos visitados. Si el cuerpo de código
# "action" se omite, sólo retorna el Array con los nodos visitados.

    def walk(start, action = lambda{|x| x})

        faltantes = [start]
        visitados = []
        
        seccion = lambda{ |hijo| if hijo != nil; faltantes << hijo; end}
        
        while !faltantes.empty?
            tmp = faltantes.shift
            action.call(tmp)
            visitados.push(tmp)
            tmp.each(seccion)
        end

        return visitados
    end

end
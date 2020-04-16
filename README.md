# rubyproject

--------------------------------------------------------------------------------
-- Tarea: Ruby	                                                              --
--                                                                            --
-- Fecha: 10/03/2015                                                          --
--                                                                            --
-- Autor:                                                                     --
--         Carlos Aponte 09-10041                                             --
--         Donato Rolo   10-10640                                             --
--------------------------------------------------------------------------------

------------------------------------
    Introducción:
------------------------------------

    Con este archivo Readme se busca aclarar posibles dudas sobre el contenido 
de los archivos del proyecto, los procedimientosque implementados, su accionar, 
como se interrelacionan entre sí y las decisiones de diseno que se tomaron.

------------------------------------
   Preguntas: 
------------------------------------

-----------------------------
|  Pregunta 1: Unificacion  |
-----------------------------

    Clase Term -> Contiene los metodos y atributos basicos que deben cumplir
    los tipos de datos de Prolog. Esta clase actua como clase abstracta para
    que contiene un constructor, un getter al nombre y los metodos abstractos
    para volverlos un String y para unificar.

    Las sigueintes clases son subclase sde Term por lo que heredan todos sus 
    metodos y atributos, adicionalmente implementan los metodos abstractos antes
    mencionados y metodos auxiliareas para realizar la unificacion mediante
    despacho doble.

    Clase Atomic -> Representa el tipo de datos "atom" de Prolog.

    Clase Variable -> Representa el tipos de datos "variable" de Prolog.

    Clase VariableLigada -> sublcase de Variable que sirve para contener
    variables que esten ligadas asi como al elemento al que estan ligadas.

    Clase Functor -> Representa el tipos de datos compuesto de Prolog.

-------------------------------------
| Pregunta 2: Busqueda Generalizada |
-------------------------------------

    Modulo BFS -> Este modulo actua com Mixin para las clases grafos y 
    afines. Los procedimientos de este modulo pueden operar indistintamente
    sobre objetos de las clases BinTree, GraphNode y LCR.

        - Procedimiento camino 
        -----------------------
        Procedimiento auxiliar que devuelve el camino del nodo de "inicio" al
        nodo "fin" haciendo un recorrido inverso sobre los padres de cada nodo
        de una corrida de BFS previa.

        - Procedimiento armar_camino
         ---------------------------- 
         Devuelve el camino del nodo de "inicio" al nodo "fin" haciendo un 
         recorrido inverso sobre los padres de cada nodo de una corrida de BFS 
         previa.

        - Procedimiento Find
        ----------------------
        Comienza la búsqueda BFS a partir del objeto "start" hasta encontrar el
        primer objeto que cumpla con el predicado "predicate" y lo retorna. Si 
        se agota la búsqueda sin encontrar objetos que cumplan el predicado se 
        retorna  nil.

        - Procedimiento Path
        ---------------------
        Comienza la búsqueda BFS a partir del objeto "start" hasta encontrar el 
        primer objeto que cumpla con el predicado "predicate", retornando el 
        camino desde "start" hasta el nodo encontrado en forma de Array. Si se
        agota la búsqueda sin encontrar un objetos que cumplan el predicado
        retorna  nil.

        - Procedimiento Walk
        -----------------------
        Comienza un recorrido BFS a partir del objeto "start" hasta agotar todo 
        el espacio de búsqueda, ejecuta el cuerpo de código "action" sobre cada 
        nodo visitado y retorna un Array con los nodos visitados. Si el cuerpo 
        de código "action" se omite, sólo retorna el Array con los nodos 
        visitados.


    Clase GraphNode -> representa un grafo arbitrario a partir de un nodo 
    especifico y sus hijos.

        - Procedimiento initialize
        ---------------------------
        Constructor de la clase GraphNode que toma el valor del nodo y los
        hijos del mismo.

        - Procedimiento each
        ---------------------
        Recibe un bloque que será utilizado para iterar sobre los hijos del 
        nodo, cuando estén definidos.


    Clase BinTree -> representa un arbol binario generico.

        - Procedimiento initialize
        ---------------------------
        Constructor de la clase BinTree que recibe el valor del nodo, y sus
        hijos izquierdos y derechos.

        - Procedimiento each 
        ---------------------
        Recibe un bloque que será utilizado para iterar sobre los hijos del 
        nodo, cuando estén definidos.

    Clase LCR -> represanta el problema de: Lobo, Cabra, Repollo mediante un
    grafo de estados

        - Procedimiento initialize
        ---------------------------
        Constructor de la clase LCR que toma la posicion actual del bote y los
        objetos que en las orillas izquierda y derecha respectivamente.

        - Procedimiento each
        --------------------- 
        Recibe un bloque que será utilizado para iterar sobre los hijos del 
        nodo que cumplan las condiciones de no dejar juntos en la orilla opuesta
        al lobo y la cabra o a la cabra y al repollo.

        - Procedimiento solve
        ---------------------- 
        Resuelve el problema LCR asumiendo que el objetivo es llevar todos los 
        objetos a la orilla derecha. Asi mismo, retorna los pasos necesarios
        para llegar a dicha solucion.

        - Procedimiento imprimir 
        -------------------------
        Imprime por pantalla el camino que representa la solucion del problema
        LCR. 

        - Procedimiento aceptable
        -------------------------
        Determina si un estado es aceptable. Esto es, si no tiene la combinacion
        de lobo-cabra, cabra-repollo en ninguna de sus orillas.

        - Override de ==
        ----------------- 
        Overrride del metodo de comparacion profunda (==)

------------------------------------   
      Decisiones de Diseño
------------------------------------ 
     
     Pregunta 1 -- Unificacion:

        -En lugar de hacer una subclase VarLigada se decidio agregar el atributo
        value a la clase Variable, de esta forma si el atibuto es nil se toma 
        como que es una variable libre.

     
     Pregunta 2 -- LCR:

        - Se tomo como estado final que el bote este en la orilla derecha y
        que todos los objetos esten de ese mismo lado. Esto daria como caso 
        inicial el 
 

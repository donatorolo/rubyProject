#############################################
# Programacion Orientada a Objetos - Tarea  #
#                                           #
#   Carlos Aponte           09-10041        #
#   Donato Rolo             10-10640        #
#############################################
#                                           #
#     Pregunta 1: Unificacion               #
#                                           #
#############################################


# Clase Term: 
# Contiene los metodos y atributos basicos que deben cumplir los tipos de
# datos de Prolog.
class Term
  attr :nombre
  
  # Constructor
  def initialize(nombre)
    @nombre = nombre
  end

  # Getter
  def name
    @nombre
  end

  # Metodo Abstracto to_s
  def to_s

  end

  def unify(target)

  end

end


# Clase Atomic:
# Representa lostipos de datos "atom" de Prolog.
class Atomic < Term

  #Crea un alias del metodo name al metodo value y elimina el acceso
  # a este ultimo (Tienen igual comportamiento para este caso).
  alias_method :value,:name
  undef_method :name

  # Implementacion del metodo abstracto to_s
  def to_s
    "Atom #{@nombre}"   
  end 

  # Implementacion del metodo abstracto unify
  def unify(target)


  end

end


# Clase Variable:
# Representa los tipos de datos "variable" de Prolog.
class Variable < Term

  # Implementacion del metodo abstracto to_s
  def to_s
    "Var #{@nombre}"   
  end 
end



# Clase Functor:
# Representa los predicados de Prolog con su nombre y argumentos.
class Functor < Term

  def initialize(nombre,argumentos)
    @nombre = nombre
    @args = argumentos
  end

  def args
    @args
  end

  # Implementacion del metodo abstracto to_s
  def to_s
    "Functor #{@nombre}(#{@args.join(", ")})"   
  end 
end
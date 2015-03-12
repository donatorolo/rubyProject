#!/usr/bin/env ruby

#  --------------------------- Clase Padre -------------------------------------
# Clase Term: 
# Contiene los metodos basicos que deben cumplir los tipos de Prolog.
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


#  ----------------------- Clase  Hijo Atom-------------------------------------
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

#  ----------------------- Clase  Hijo Variable --------------------------------

class Variable < Term

  # Implementacion del metodo abstracto to_s
  def to_s
    "Var #{@nombre}"   
  end 
end


#  ----------------------- Clase  Hijo Functor ---------------------------------
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
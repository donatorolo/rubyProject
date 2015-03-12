#!/usr/bin/env ruby

# Clase Tipos: 
# Contiene los metodos basicos que deben cumplir los tipos de Prolog.
class Tipos
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
end

class Atomic < Tipos

  #Crea un alias del metodo name al metodo value y elimina el acceso
  # a este ultimo (Tienen igual comportamiento para este caso).
  alias_method :value,:name
  undef_method :name

  # Implementacion del metodo abstracto to_s
  def to_s
    "Atom #{@nombre}"   
  end 
end

class Variable < Tipos

  # Implementacion del metodo abstracto to_s
  def to_s
    "Var #{@nombre}"   
  end 
end

class Functor < Tipos

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
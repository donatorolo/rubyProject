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
  attr_reader :nombre
  
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

  def unify target

  end

end


# Clase Atomic:
# Representa lostipos de datos "atom" de Prolog.
class Atomic < Term

  #Crea un alias del metodo name al metodo value y elimina el acceso
  # a este ultimo (Tienen igual comportamiento para   este caso).
  alias_method :value,:name
  undef_method :name

  # Implementacion del metodo abstracto to_s
  def to_s
    "Atom #{@nombre}"   
  end 

  # Implementacion del metodo abstracto unify
  def unify(target)
    target.right_par_atomic(self)
  end

  def right_par_atomic x
    return self.value == x.value
  end

  def right_par_var x
    p = Proc.new{|x, y| x = VariableLigada.new(x.name, y.value)}
    p.call(x,self)
    # x = VariableLigada.new(x.name, self.value)
    puts "HOLAAAAAAAAAAAAAA#{x.class}"
    return true
  end

  def right_par_varLig x
    return x.value == self.value
  end

  def right_par_functor x
    return false
  end

end

# Clase Variable:
# Representa los tipos de datos "variable" de Prolog.
class Variable < Term

  # Implementacion del metodo abstracto to_s
  def to_s
    "Var #{@nombre}"   
  end 

  def unify target
    target.right_par_var(self)
  end

  def right_par_atomic x
    # self = VariableLigada.new(self.name, x.value)
    # return true
  end

  def right_par_var x
    return true
  end

  def right_par_varLig x

  end

  def right_par_functor x
    
  end
end

# Clase VariableLigada

class VariableLigada < Variable
  
  def initialize(nombre, valor)
    @nombre = nombre
    @value = valor
  end

  def value
    return @value
  end

  def unify target
    target.right_par_var(self)
  end

  def right_par_atomic x
    return self.value == x.value
  end

  def right_par_var x
    x = VariableLigada.new(x.name, self.value)
    return true
  end

  def right_par_varLig x
    return self.value == x.value
  end
  
  def right_par_functor x
    
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

  def unify target
    target.right_par_functor(self)
  end

  def right_par_atomic x
    return false
  end

  def right_par_var x
    return self.value == x.value
  end

  def right_par_functor x
    
  end
end

if __FILE__ == $0

####################### Verificando Atomic ###############################
puts
puts "Verificando Atomic"

puts "\tright_par_atomic"

ra1 = Atomic.new(1)

ra2 = Atomic.new(1)

aux = ra2.unify(ra1)

puts "\tDeberia dar True y da: #{aux}"
#------------------------------------
puts 
puts "\tright_par_var"

rv1 = Atomic.new(1)

rv2 = Variable.new('x')

aux = rv2.unify(rv1)

puts "#{rv2.class}"

puts "\tDeberia dar True y da: #{aux}"
#------------------------------------
puts 
puts "\tright_par_varLig"

rv1 = Atomic.new(1)

rv2 = VariableLigada.new('x',1)

aux = rv2.unify(rv1)

puts "\tDeberia dar True y da: #{aux}"
#------------------------------------
puts 
puts "\tright_par_functor"

rv1 = Atomic.new(1)

rv2 = Functor.new('x',[1])

aux = rv2.unify(rv1)

puts "\tDeberia dar False y da: #{aux}"

####################### Verificando Variable ##############################



####################### Verificando VariableLigada ########################
####################### Verificando Functor ###############################


end
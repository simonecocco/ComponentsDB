# frozen_string_literal: true

require 'json'

# passato un oggetto json lo trasforma in un oggetto del suo tipo
def definetype item
	case item['type']
		when 'r'
			return Resistor.new item['ohm'],item['toll'],item['watt']
		when 'c'
			return Capacitor.new item['capacitance'],item['volt'],item['material']
		when 'l'
			return Inductance.new item['inductance'],item['current'] 
		when 'ic'
			return IntegratedCircuit.new item['model'],item['function'],item['npin'],item['maxvcc']
		when 't'
			return Transistor.new item['model'],item['config'],item['darlington'],item['hfemin'],item['hfemax'],item['freqmax']
		when 'd'
			return Diode.new item['model'],item['function'],item['maxrevvoltage'],item['minrevvoltage'],item['maxcapacitance'],item['mincapacitance'],item['revcurrent'],item['current'],item['watt']
	end
end

class Resistor
	attr_reader :ohm, :toll, :watt
	
	def initialize ohm,toll=nil,watt=nil
		@ohm = ohm
		@toll = toll
		@watt = watt
	end
	
	def type
		return 'r'
	end
	
	def hash
		return {:type=>'r',:ohm=>@ohm,:toll=>@toll,:watt=>@watt}
	end
	
	def to_s
		return "resistore da #{@ohm}ohm"
	end
	
	def <=>(other)
		return @ohm<=>other.ohm
	end
	
	def show
		puts "Resistore\n\t\tohm: #{@ohm}ohm\n\t\ttolleranza: #{@toll}%\n\t\tpotenza: #{@watt}W"
	end
end
	
class Capacitor
	attr_reader :capacitance, :volt, :material
	
	def initialize capacitance,volt,material
		@capacitance=capacitance
		@volt=volt
		@material=material
	end
	
	def type
		return 'c'
	end
	
	def hash
		return {:type=>'c',:capacitance=>@capacitance,:volt=>@volt,:material=>@material}
	end
	
	def to_s
		return "condensatore da #{@capacitance}F"
	end
	
	def <=>(other)
		return @capacitance<=>other.capacitance
	end

	def show
		puts "Condensatore\n\t\tcapacità: #{@capacitance}F\n\t\ttensione massima: #{@volt}V\n\t\tmateriale: #{@material}"
	end
end

class Inductance
	attr_reader :inductance, :current
	
	def initialize inductance,current
		@inductance=inductance
		@current=current
	end
	
	def type
		return 'l'
	end
	
	def hash
		return {:type=>'l',:inductance=>@inductance,:current=>@current}
	end
	
	def to_s
		return "induttore da #{@inductance}H"
	end
	
	def <=>(other)
		return @inductance<=>other.inductance
	end
	
	def show
		puts "Induttore\n\t\tinduttanza: #{@inductance}H\n\t\tcorrente: #{@current}A"
	end
end
	
class IntegratedCircuit
	attr_reader :model,:function, :npin, :maxvcc
	
	def initialize model,function,npin,maxvcc
		@model=model
		@function=function
		@npin=npin
		@maxvcc=maxvcc
	end 
	
	def type
		return 'ic'
	end
	
	def hash
		return {:type=>'ic',:model=>@model,:function=>@function,:npin=>@npin,:maxvcc=>@maxvcc}
	end
	
	def to_s
		return "#{@model}(#{function})"
	end
	
	def <=>(other)
		return @model<=>other.model
	end
	
	def show
		puts "Circuito integrato\n\t\tmodello: #{@model}\n\t\tfunzione: #{@function}\n\t\tnumero di pin:#{@npin}\n\t\ttensione di alimentazione massima: #{@maxvcc}V"
	end
end
	
class Transistor
	attr_reader :model,:config,:darlington,:hfemin,:hfemax,:freqmax
	
	def initialize model,config,darlington,hfemin,hfemax,freqmax
		@model=model
		@config=config
		@darlington=darlington
		@hfemin=hfemin
		@hfemax=hfemax
		@freqmax=freqmax
	end
	
	def type
		return 't'
	end
	
	def hash
		return {:type=>'t',:model=>@model,:config=>@config,:darlington=>@darlington,:hfemin=>@hfemin,:hfemax=>@hfemax,:freqmax=>@freqmax}
	end
	
	def to_s
		return "#{@model}(#{@config}) #{@hfemin}-#{@hfemax}"
	end
	
	def <=>(other)
		return @model<=>other.model
	end
	
	def show
		puts "Transistor\n\t\tmodello: #{@model}\n\t\ttipo: #{@config}\n\t\tdarlington? #{@darlington}\n\t\thfe minimo: #{@hfemin}\n\t\thfe massimo: #{@hfemax}\n\t\tfrequenza di taglio: #{@freqmax}"
	end
end
	
class Diode
	attr_reader :model,:function,:maxrevvoltage,:minrevvoltage,:maxcapacitance,:mincapacitance,:revcurrent,:current,:watt
	
	def initialize model,function,maxrevvoltage,minrevvoltage,maxcapacitance,mincapacitance,revcurrent,current,watt
		@model=model
		@function=function
		@maxrevvoltage=maxrevvoltage
		@minrevvoltage=minrevvoltage
		@maxcapacitance=maxcapacitance
		@mincapacitance=mincapacitance
		@revcurrent=revcurrent
		@current=current
		@watt=watt
	end
	
	def type
		return 'd'
	end
	
	def hash
		return {:type=>'d',:model=>@model,:function=>@function,:maxrevvoltage=>@maxrevvoltage,:minrevvoltage=>@minrevvoltage,:maxcapacitance=>@maxcapacitance,:mincapacitance=>@mincapacitance,:revcurrent=>@revcurrent,:current=>@current,:watt=>@watt}
	end
	
	def to_s
		return "#{@model}(#{@function}) #{@watt}"
	end
	
	def <=>(other)
		return @model<=>other.model
	end
	
	def show
		puts "Diodo\n\t\tmodello: #{@model}\n\t\ttipo: #{@function}\n\t\tmassima tensione inversa: #{@maxrevvoltage}V\n\t\tminima tensione inversa: #{@minrevvoltage}V\n\t\tcapacità massima: #{@maxcapacitance}F\n\t\tcapacità minima: #{@mincapacitance}F\n\t\tcorrente inversa: #{@revcurrent}A\n\t\tcurrent: #{@current}A\n\t\tpotenza: #{@watt}W"
	end
end

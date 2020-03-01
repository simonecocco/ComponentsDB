# frozen_string_literal: true
=begin
 usando:
 -r  per resistore
 -c  per condensatore
 -l  per induttore
 -ic per integrato
 -t  per transistor
 -d  per diodo
=end

require 'json'
load 'clist.rb'
load 'compmodel.rb'

# aggiungi un componente alla lista
def add cl,type,arg
	case type
		when '-r' # resistore
			if arg.size !=3
				puts 'resistenza: ohm, tolleranza, potenza'
				return
			end
			cl+Resistor.new(arg[0],arg[1],arg[2])
		when '-c' # condensatore
			if arg.size !=3
				puts 'condensatore: capacità, tensione massima, materiale'
				return
			end
			cl+Capacitor.new(arg[0],arg[1],arg[2]) 
		when '-l' # induttanza
			if arg.size !=2
				puts 'induttore: induttanza, corrente'
				return
			end
			cl+Inductance.new(arg[0],arg[1])
		when '-ic' # circuito integrato
			if arg.size !=4
				puts 'circuito integrato: modello, funzione, numero di pin, tensione di alimentazione massima'
				return
			end
			cl+IntegratedCircuit.new(arg[0],arg[1],arg[2],arg[3])
		when '-t' # transistor
			if arg.size!=6
				puts 'transistor/cmos/mosfet/fet: modello, tipo, tipo darlington? (true/false), hfe minimo, hfe massimo, frequenza di taglio'
				return
			end
			cl+Transistor.new(arg[0],arg[1],arg[2],arg[3],arg[4],arg[5])
		when '-d' # diodo
			if arg.size !=9
				puts 'diodo: modello, tipo, massima tensione inversa, minima tensione inversa, massima capacità, minima capacità, corrente inversa, corrente, potenza'
				return
			end
			cl+Diode.new(arg[0],arg[1],arg[2],arg[3],arg[4],arg[5],arg[6],arg[7],arg[8])
		else
			puts 'cmdb: tipo non riconosciuto'
	end
end

# cerca un componente nella lista
def search cl,arg
	res=cl[arg]
	return nil if res==nil||res.empty?
	for index,elem in res
		print "id#{index} "
		elem.show
	end
end

# rimuove un componente nella lista
def remove cl,arg
	print 'rimuovo '
	begin
		(cl-arg).show
	rescue NoMethodError
		puts 'il nulla'
	end
end

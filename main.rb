# frozen_string_literal: true

=begin
 Inventario dei componenti
 @author Simone Cocco
 @date 22/02/2020
=end

FILENAME='complist.json'

require 'json'
load 'compmodel.rb'
load 'fileutil.rb'
load 'clist.rb'
load 'optolist.rb'

# carica la lista
def init
	puts 'ComponentsDB - Simone Cocco (2020)'
	complist=loadlist
	complist=makelist if complist==nil
	CList.new complist
end

# esegue i comandi
def run cl,arg
	case arg[0]
		when '-a' # add
			add cl,arg[1],arg[2..-1]
		when '-r' # remove
			remove cl,arg[1]
		when '-s' # search
			search cl,arg[1]
		when '-m' #show all
			cl.show
	end
end

# crea l'elemento
clist=init

=begin
per aggiungere:
	-a
		-r :ohm, :toll, :watt
		-c :capacitance, :volt, :material
		-l :inductance, :current
		-ic :model,:function, :npin, :maxvcc
		-t :model,:config,:darlington,:hfemin,:hfemax,:freqmax
		-d :model,:function,:maxrevvoltage,:minrevvoltage,:maxcapacitance,:mincapacitance,:revcurrent,:current,:watt

per cercare:
	-s keyword

mostra tutto:
	-m
	
rimuovi tramite id:
	-r id
=end

if ARGV[0]==nil || ARGV[0].empty?
	# shell interattiva
	while true
		print 'cmdb: '
		cmd=gets.chomp.split ' '
		break if cmd[0]=='q' || cmd[0]=='quit'
		run clist,cmd
	end
else
	# comandi da terminale
	run clist,ARGV
end

# salva
clist.close

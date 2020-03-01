# frozen_string_literal: true

require 'json'
load 'fileutil.rb'
load 'compmodel.rb'

# contenitore della lista
class CList
	def initialize jsond
		tmpjsond=JSON.parse jsond
		tmpjsond=tmpjsond['list']
		@indexes=tmpjsond['indexes']
		@nelem=tmpjsond['nelem'].to_i
		@elems=[]
		return unless tmpjsond['elems']!=nil && tmpjsond['elems'].size>0
		for elem in tmpjsond['elems']
			@elems.push definetype(elem)
		end
	end
	
	# aggiunge un elemento
	def +(comp)
		return nil if comp==nil
		@nelem+=1
		@elems.push comp
		puts "cmdb: aggiungo #{comp}"
		self
	end
	
	# rimuove un elemento
	def -(comp)
		return nil if comp==nil
		@nelem-=1
		item=@elems[comp.to_i]
		@elems.delete_at comp.to_i
		return item
	end
	
	# ricerca veloce
	def [](keyw)
		tmplist={}
		for index in 0...@elems.size
			elem=@elems[index]
			elem.hash.each_value{ |val|
				tmplist[index]=elem if val.downcase.include? keyw.downcase
			}
		end
		return tmplist
	end
	
	# ricerca specifica
	def []=(type,keyw)
		#todo
	end
	
	#mostra tutta la lista
	def show
		for elem in @elems
			puts elem.show
		end
	end
	
	#componi la lista
	def _compose
		@elems.map!{|elem|
			elem.hash
		}
		return {:list=>{:nelem=>@nelem,:elems=>@elems}}.to_json
	end
	
	#salva la lista
	def close
		deletelist
		makelist _compose
	end
end

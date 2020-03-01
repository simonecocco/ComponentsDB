# frozen_string_literal: true

# carica la lista
# @return nil se non esiste o non è leggibile
def loadlist
	return nil unless File.exist?(FILENAME) && File.readable?(FILENAME)
	file=File.open FILENAME,'r'
	jsond=file.read
	file.close
	return jsond
end

# crea la lista
def makelist json=nil
	File.open(FILENAME,'w+') do |listf|
		if json==nil
			listf.write "{\"list\":{\"nelem\":0,\"elems\":[]}}"
		else
			listf.write json
		end
	end
	return loadlist
end

# elimina la lista
def deletelist
	File.delete FILENAME
end

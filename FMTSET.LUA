local data1
local data2
local data3
local data4

local data1sts
local data2sts
local data3sts
local data4sts

function readformatEvent()
	--- READ DATA ---
	data = readResult():readData()
	datalength= string.len(data)
	
	if datalength > 0 then
			
		if datalength == 15 then --- Main barcode have 15 Character
			--- RESET ALL ---
			data1=""
			data2=""
			data3=""
			data4=""
			data1sts = 0
			data2sts = 0
			data3sts = 0
			data4sts = 0

			--- FIRST DATA ---
			data1 = data
			data1sts = 1
			outonEvent(1) --- turn on OUT 1
		else
		
			if data1sts == 1 then --- if main barcode already scanned

				if datalength == 5 then --- 2nd barcode have 5 character
					data2 = data
					data2sts = 1
					outonEvent(2) --- turn on OUT 2
				elseif datalength == 6 then --- 3rd barcode have 6 character
					data3 = data
					data3sts = 1
					outonEvent(3) --- turn on OUT 3
				else --- last barcode
					data4 = data
					data4sts = 1
					outonEvent(4) --- turn on OUT 4
				end
			
			end
		
		end
		
	end

	if data1sts == 1 and data2sts == 1 and data3sts == 1 and data4sts == 1  then 
		--- send data if every part already scanned
		sendData = data1..","..data2..","..data3..","..data4
		if sendData ~= temp then
			temp=sendData
			return(sendData)
			
		else 
			return("")
		end

	end

	
end
---hadillafilanda@gmail.com
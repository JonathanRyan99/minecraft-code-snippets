function assign_bin()
	local data = turtle.getItemDetail()
	local current_Slot = turtle.getSelectedSlot()
	if data then--if data is found it is sorted according to the whitelists
		print(data.name)
		for i = 1,table.getn(ores_array) do
			if data.name == ores_array[i] then
				destination[current_Slot] = 1 --category is stored as a int 
			end
		end
		for i = 1,table.getn(building_array) do
			if data.name == building_array[i] then
				destination[current_Slot] = 2
			end
		end
		
		--catch if it doesnt fall into those category
		if destination[current_Slot] == null then
			destination[current_Slot] = 0
		end
	
	else--if theres no data then slot is emtpy misc as 0
		destination[current_Slot] = 0
	end
end

function debug_categories()
	for i = 1,16 do
		print(destination[i])
	end
end


function movefoward()
	turtle.forward()
	current_pos_x = current_pos_x + 1
end

function moveback()
	turtle.back()
	current_pos_x = current_pos_x - 1
end

--will align its self with boxes, 0 is starting pos +int is infront and -int is behind
function align(target)
	while target ~= current_pos_x do
		if target < current_pos_x then
			moveback()
		end
	
		if target > current_pos_x then
			movefoward()
		end
	end
	print("aligned with target: ",target)
end


--dumps all slots in inventory that corrispond with current category (this is known from destination)
function dump(category)
	for i =1,16 do
		if destination[i] == category then
			turtle.select(i)
			turtle.dropDown()
		end
	end

end




--INTALISE WHITE LISTS AND VARIABLES
--declares white list arrays for chests
ores_array = {"minecraft:gold_ore", "minecraft:iron_ore","minecraft:diamond","minecraft:redstone","minecraft:lapis_lazuli","minecraft:coal"}
building_array ={"minecraft:dirt","minecraft:cobblestone","minecraft:gravel","minecraft:sand"}
--this is used to assign destination for the items each slot has a destination
destination = {}

--used for navigation (assumed 1 == one block moved) 0 is starting pos +int is infront and -int is behind 
current_pos_x = 0
home_pos = 0
ores_chest_pos = 1 
mats_chest_pos = 2
misc_chest_pos = 8


--main
--sorts item inventory
for i = 1,16 do
	turtle.select(i)
	assign_bin()
end

--align(chest pos)
--dump(category)

--dont really know if it was worth putting this in functions but i did
function ores_chest()
	align(ores_chest_pos)
	dump(1)
end

function mats_chest()
	align(mats_chest_pos)
	dump(2)
end

function misc_chest()
	align(misc_chest_pos)
	dump(0)
end



ores_chest()
mats_chest()
misc_chest()
--dont forget to return home
align(home_pos)













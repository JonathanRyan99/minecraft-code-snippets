--http://www.computercraft.info/forums2/index.php?/topic/1704-get-the-direction-the-turtle-face/

function getOrientation()
loc1 = vector.new(gps.locate(2, false))
if not turtle.forward() then
    for j=1,6 do
            if not turtle.forward() then
                    turtle.dig()
         else break end
    end
end
loc2 = vector.new(gps.locate(2, false))
heading = loc2 - loc1
return ((heading.x + math.abs(heading.x) * 2) + (heading.z + math.abs(heading.z) * 3))
end





--[[orientation will be:
-x = 1 west
-z = 2 north
+x = 3 east
+z = 4 south
This matches exactly with orientation in game, except that Minecraft uses 0 for +z instead of 4.
--]]

function goRight()
	if direction  == 1 then
		direction = 2

    elseif direction == 2 then
    	direction = 3
    	
    elseif direction == 3 then 
    	direction = 4
    	
    elseif direction == 4 then 
    	direction = 1	
    end

    turtle.turnRight()
end

function goLeft()
	if direction  == 1 then
		direction = 4

    elseif direction == 4 then
    	direction = 3
    	
    elseif direction == 3 then 
    	direction = 2
    	
    elseif direction == 2 then 
    	direction = 1	
    end

    turtle.turnLeft()
end



function alignX(target)
	if CurrentPos.x < target then 
		while direction ~= 3 do
			goRight()
		end
	else
		while direction ~= 1 do 
			goLeft()
		end
	end
	
	while CurrentPos.x ~= target do
		forward()
	end
end 



function alignZ(target)
	if CurrentPos.z < target then 
		while direction ~= 4 do
			goLeft()
		end
	
	else
		while direction ~= 2 do
			goRight()
		end
	end

	while CurrentPos.z ~= target do 
		forward()
	end
end




function alignY(target)
	if CurrentPos.y < target then 
		while CurrentPos.y ~= target do
			turtle.up()
			CurrentPos.y = CurrentPos.y + 1
		end
	else
		while CurrentPos.y ~= target do
			turtle.down()
			CurrentPos.y = CurrentPos.y - 1
		end
	end
	print("X:",CurrentPos.x,"Y:",CurrentPos.y,"Z:",CurrentPos.z)
end 


--traveling 
--west north east south effects on x and z axis
--e.g north decreases x by 1, but traveling east has no effect on x,
xDiff = { -1, 0, 1, 0 }
zDiff = { 0, -1, 0, 1}

function forward()
	CurrentPos.x = CurrentPos.x + xDiff[direction]
	CurrentPos.z = CurrentPos.z + zDiff[direction]
	turtle.forward()
	print("X:",CurrentPos.x,"Y:",CurrentPos.y,"Z:",CurrentPos.z)
	
end

function moveTo()
	alignY(TargetPos.y)
	alignX(TargetPos.x)
	alignZ(TargetPos.z)
end

function home()
	alignY(0)
	alignX(0)
	alignZ(0)
end

function getTarget()
	print("X:",TargetPos.x,"Y:",TargetPos.y,"Z:",TargetPos.z)
end

function setTarget(input)
	TargetPos.x = input.x
	TargetPos.y = input.y
	TargetPos.z = input.z
end


function getHome()
	print("X:",HomePos.x,"Y:",HomePos.y,"Z:",HomePos.z)
end

function setHome(input)
	HomePos.x = input.x
	HomePos.y = input.y
	HomePos.z = input.z
end


function getDirection()
	print("current direction: ", direction)
end

function setDirection(input)
	if input <= 4 and input > 0 then 
		direction = input
	else
		print("direction is 1,4")
	end
	
end

print("enter the direction turtle is facing: 1 west, 2 north,3 east,4 south")
direction = tonumber(read())

HomePos = vector.new(0,0,0)
CurrentPos = vector.new(0,0,0)
TargetPos = vector.new(0,0,0)

temp = vector.new(-3,1,9)
setTarget(temp)
moveTo()
sleep(3)
home(HomePos)





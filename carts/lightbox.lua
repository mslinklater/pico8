iReadBuf=1
WriteBuf=2

function doinit()
	-- setup and clear the play area
	grid = {}
	for buffer=1,2 do
		buffertable={}
		for row=1,16 do
			gridrow = {}
			for col=1,16 do
				gridrow[col] = 0
			end
			buffertable[row]=gridrow
		end
		grid[buffer]=buffertable
	end

	-- create some default objects

	grid[1][5][5]=tile_source_up
	grid[2][5][5]=tile_source_up
end

function doupdate()
	-- propigate light rays
	-- set the map values based off the grid
	for row=1,16 do
		for col=1,16 do
			local zerocol=col-1
			local zerorow=row-1
			mset(zerocol,zerorow, grid[iReadBuf][col][row])
		end
	end
end

function dodraw()
	cls(col_black)
	map(0,0,0,0,16,16)
end

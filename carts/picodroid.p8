pico-8 cartridge // http://www.pico-8.com
version 15
__lua__
// picodroid

toggle_each_frame=true
phase_current = nil
floor_current=1

// --------------- sprite flags
flag_collidable = 0
flag_floor = 1

// ------------- sprite numbers
sprite_clear = 0
sprite_wall_zero = 22
sprite_wall_l = 1
sprite_wall_t = 2
sprite_wall_r = 3
sprite_wall_b = 4
sprite_wall_horizontal = 5
sprite_wall_vertical = 6
sprite_wall_tr = 7
sprite_wall_rb = 8
sprite_wall_lb = 9
sprite_wall_tl = 10
sprite_wall_lrb = 11
sprite_wall_tlb = 12
sprite_wall_tlr = 13
sprite_wall_trb = 14
sprite_hdoor = 32
sprite_vdoor = 48
sprite_floor = 17
sprite_wall_cross = 18
sprite_player_start = 19
sprite_player = 21
-- debug
sprite_dbg_1=64
sprite_dbg_2=65
sprite_dbg_3=66
sprite_dbg_4=67
sprite_dbg_col0=127
sprite_dbg_col1=126
sprite_dbg_col2=125
sprite_dbg_col3=124
sprite_dbg_col4=123
sprite_dbg_col5=122
sprite_dbg_col6=121
sprite_dbg_col7=120
sprite_dbg_col8=119
sprite_dbg_col9=118
sprite_dbg_col10=117
sprite_dbg_col11=116
sprite_dbg_col12=115
sprite_dbg_col13=114
sprite_dbg_col14=113
sprite_dbg_col15=112

// ---------------------- input
button_left = 0
button_right = 1
button_up = 2
button_down = 3
button_o = 4
button_x = 5

camera_x=0
camera_y=0
camera_target_x=64
camera_target_y=64
camera_damp=0.2

player_x=0
player_y=0
player_vx=0
player_vy=0
player_max_speed=1.5
player_damp=0.75
player_index=0

cell_unknown=0
cell_clear=1
cell_floor=2

debug_0=0
debug_1=0

-- map zones
map_main_xmin=0
map_main_xmax=95
map_main_ymin=0
map_main_ymax=46

-- wall building data

--+---+---+---+
--|001|002|004|
--+---+---+---+
--|008|   |016|
--+---+---+---+
--|032|064|128|
--+---+---+---+

wall_building_list = {
	--1-5
	sprite_wall_tl, sprite_wall_horizontal, sprite_wall_horizontal, sprite_wall_tr, sprite_wall_tlr,
	--6-10
	sprite_wall_horizontal, sprite_wall_horizontal, sprite_wall_vertical, sprite_wall_vertical, sprite_dbg_col8,
	--11-15
	sprite_wall_rb, sprite_wall_trb, sprite_wall_trb, sprite_wall_rb, sprite_wall_rb,
	--16-20
	sprite_wall_vertical, sprite_wall_tlb, sprite_dbg_col8, sprite_wall_lb, sprite_wall_vertical,
	--21-25
	sprite_wall_tlb, sprite_wall_lb, sprite_wall_lb, sprite_wall_vertical, sprite_wall_vertical,
	--26-30
	sprite_dbg_col8, sprite_dbg_col8, sprite_wall_vertical, sprite_wall_vertical, sprite_dbg_col8,
	--31-35
	sprite_wall_b, sprite_wall_lb, sprite_wall_tlb, sprite_dbg_col8, sprite_wall_lrb,
	--36-40
	sprite_wall_cross, sprite_wall_cross, sprite_wall_lrb, sprite_wall_lrb, sprite_wall_vertical,
	--41-45
	sprite_wall_vertical, sprite_wall_rb, sprite_wall_rb, sprite_wall_trb, sprite_wall_trb,
	--46-50
	sprite_wall_rb, sprite_wall_rb, sprite_wall_tlb, sprite_dbg_col8, sprite_dbg_col8,
	--51-55
	sprite_dbg_col8, sprite_wall_tlb, sprite_wall_tlb, sprite_dbg_col8, sprite_wall_lb,
	--56-60
	sprite_wall_vertical, sprite_wall_vertical, sprite_dbg_col8, sprite_dbg_col8, sprite_wall_vertical,
	--61-65
	sprite_wall_vertical, sprite_wall_b, sprite_wall_b, sprite_wall_horizontal, sprite_wall_tlr,
	--66-70
	sprite_wall_horizontal, sprite_wall_horizontal, sprite_wall_tlr, sprite_dbg_col8, sprite_wall_horizontal,
	--71-75
	sprite_wall_horizontal, sprite_dbg_col8, sprite_dbg_col8, sprite_dbg_col8, sprite_wall_r,
	--76-80
	sprite_dbg_col8, sprite_dbg_col8, sprite_dbg_col8, sprite_wall_r, sprite_wall_tl,
	--81-85
	sprite_dbg_col8, sprite_dbg_col8, sprite_dbg_col8, sprite_wall_tl, sprite_dbg_col8,
	--86-90
	sprite_dbg_col8, sprite_dbg_col8, sprite_dbg_col8, sprite_dbg_col8, sprite_dbg_col8,
	--91-95
	sprite_dbg_col8, sprite_dbg_col8, sprite_dbg_col8, sprite_dbg_col8, sprite_dbg_col8,
	--96-100
	sprite_wall_horizontal, sprite_wall_tlr, sprite_wall_horizontal, sprite_wall_horizontal, sprite_wall_tlr,
	--101-105
	sprite_wall_tlr, sprite_wall_horizontal, sprite_wall_horizontal, sprite_wall_tr, sprite_wall_tr,
	--106-110
	sprite_wall_r, sprite_wall_r, sprite_dbg_col8, sprite_wall_tr, sprite_wall_r,
	--111-115
	sprite_wall_r, sprite_wall_tl, sprite_dbg_col8, sprite_dbg_col8, sprite_wall_l,
	--116-120
	sprite_wall_tl, sprite_dbg_col8, sprite_wall_l, sprite_wall_l, sprite_dbg_col8,
	--121-125
	sprite_dbg_col8, sprite_dbg_col8, sprite_dbg_col8, sprite_dbg_col8, sprite_dbg_col8,
	--126-130
	sprite_dbg_col8, sprite_wall_zero, sprite_wall_rb, sprite_wall_cross, sprite_wall_lrb,
	--131-135
	sprite_wall_lrb, sprite_wall_trb, sprite_wall_cross, sprite_wall_lrb, sprite_wall_lrb,
	--136-140
	sprite_wall_trb, sprite_wall_trb, sprite_dbg_col8, sprite_wall_rb, sprite_dbg_col8,
	--141-145
	sprite_wall_trb, sprite_dbg_col8, sprite_wall_rb, sprite_wall_vertical, sprite_wall_tlb,
	--146-150
	sprite_dbg_col8, sprite_wall_lb, sprite_wall_vertical, sprite_wall_tlb, sprite_wall_lb,
	--151-155
	sprite_wall_lb, sprite_wall_vertical, sprite_wall_vertical, sprite_wall_zero, sprite_dbg_col8,
	--156-160
	sprite_wall_vertical, sprite_wall_vertical, sprite_dbg_col8, sprite_wall_b, sprite_wall_lrb,
	--161-165
	sprite_wall_cross, sprite_wall_lrb, sprite_wall_lrb, sprite_wall_cross, sprite_wall_cross,
	--166-170
	sprite_wall_lrb, sprite_wall_lrb, sprite_wall_trb, sprite_wall_trb, sprite_dbg_col8,
	--171-175
	sprite_wall_rb, sprite_wall_trb, sprite_wall_trb, sprite_dbg_col8, sprite_wall_rb,
	--176-180
	sprite_wall_tlb, sprite_wall_tlb, sprite_dbg_col8, sprite_dbg_col8, sprite_wall_tlb,
	--181-185
	sprite_wall_tlb, sprite_wall_lb, sprite_wall_lb, sprite_wall_vertical, sprite_wall_vertical,
	--186-190
	sprite_dbg_col8, sprite_wall_b, sprite_wall_vertical, sprite_wall_vertical, sprite_wall_b,
	--191-195
	sprite_wall_b, sprite_wall_horizontal, sprite_wall_tlr, sprite_wall_horizontal, sprite_wall_horizontal,
	--196-200
	sprite_wall_tlr, sprite_wall_tlr, sprite_wall_horizontal, sprite_wall_horizontal, sprite_wall_tr,
	--201-205
	sprite_wall_tr, sprite_dbg_col8, sprite_wall_r, sprite_dbg_col8, sprite_wall_tr,
	--205-210
	sprite_dbg_col8, sprite_dbg_col8, sprite_wall_tl, sprite_wall_tl, sprite_dbg_col8,
	--211-215
	sprite_wall_l, sprite_wall_tl, sprite_wall_tl, sprite_wall_l, sprite_wall_l,
	--216-220
	sprite_dbg_col8, sprite_dbg_col8, sprite_dbg_col8, sprite_dbg_col8, sprite_dbg_col8,
	--221-225
	sprite_wall_t, sprite_wall_zero, sprite_dbg_col8, sprite_wall_horizontal, sprite_wall_tlr,
	--226-230
	sprite_wall_horizontal, sprite_wall_horizontal, sprite_wall_tlr, sprite_wall_tlr, sprite_wall_horizontal,
	--231-235
	sprite_wall_horizontal, sprite_wall_tr, sprite_wall_tr, sprite_dbg_col8, sprite_wall_r,
	--236-240
	sprite_wall_tr, sprite_wall_tr, sprite_wall_r, sprite_wall_r, sprite_wall_tl,
	--241-245
	sprite_wall_tl, sprite_dbg_col8, sprite_wall_l, sprite_wall_tl, sprite_wall_tl,
	--246-250
	sprite_wall_l, sprite_wall_l, sprite_wall_t, sprite_wall_t, sprite_dbg_col8,
	--251-255
	sprite_wall_zero, sprite_wall_t, sprite_wall_t, sprite_wall_zero, sprite_wall_zero,
}

floor1 = [[
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
    ........                                                                                   
    .S......                                                                                   
    ........                                                                                   
       h  h      ....                                                                          
      .......   ......                                                                         
      ........v.......                                                                         
      .......   ......                                                                         
                 ....                                                                          
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
]]
floor2 = [[
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
         .....                                                                                 
         .....           ..............                                                        
         ..S........v..................                                                        
         .....           ..............                                                        
         .....            h    h    h                                                          
                         .... .... ....                                                        
                         .... .... ....                                                        
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
]]

maps = {floor1, floor2}

-- doors

doors = {}
door_closed=1
door_open=2

function clear_doors()
	printh("clear_doors")
	doors = {}
end

function add_door(col,row,spr)
	door={}
	door.col=col
	door.row=row
	door.x=col*8
	door.y=row*8
	door.type=spr
	door.spr=spr
	door.state=door_closed
	add(doors,door)
	return #doors
end

-- droids

droids={}

function add_droid(x,y,floor,update)
	--printh("add_droid " .. x .. "," .. y)
	droid={}
	droid.x=x
	droid.y=y
	droid.floor=floor
	droid.update=update
	add(droids,droid)
	droid.index=#droids
	return #droids
end

phase_splash={}
phase_ingame={}

-------------
-- splash --
-------------

function draw_splash()
	cls()
	map(0,48,0,0,16,63)
	print("by martin", 22,85,i,0)
	print("linklater", 22,101,i,0)
end

function update_splash()
	if btnp(5) then
		set_current_phase(phase_ingame)
	end
end

function init_splash()
	printh("init_splash")
end

function enter_splash()
	printh("enter_splash")
	camera_x=0
	camera_y=0
end

function exit_splash()
	printh("exit_splash")
end

phase_splash.draw=draw_splash
phase_splash.update=update_splash
phase_splash.init=init_splash
phase_splash.enter=enter_splash
phase_splash.exit=exit_splash

-------------
-- in-game --
-------------
function draw_ingame()
	cls()
	map(0,0,map_main_xmin,map_main_ymin,map_main_xmax,map_main_ymax)
	draw_player()
	draw_debug()

	-- draw doors
	printh("Num doors " .. #doors)
	for door in all(doors) do
		if door.state==door_open then
			mset(door.col,door.row,sprite_floor)
		else
			mset(door.col,door.row,door.spr)
		end
	end
end

function update_ingame()
	-- update player input
	if btn(button_left) then 
		player_vx-=1 
	end
	if btn(button_right) then
		player_vx+=1
	end
	if btn(button_up) then
	 player_vy-=1
	end
	if btn(button_down) then
		player_vy+=1
	end
	player_vx=max(min(player_vx,player_max_speed),-player_max_speed)
	player_vy=max(min(player_vy,player_max_speed),-player_max_speed)

	player_vx,player_vy=do_wall_collision(player_x+1,player_y+1,player_vx,player_vy)
	player_vx,player_vy=do_wall_collision(player_x+7,player_y+1,player_vx,player_vy)
	player_vx,player_vy=do_wall_collision(player_x+1,player_y+7,player_vx,player_vy)
	player_vx,player_vy=do_wall_collision(player_x+7,player_y+7,player_vx,player_vy)

	player_x+=player_vx
	player_y+=player_vy
	player_vx=player_vx*player_damp
	player_vy=player_vy*player_damp

	update_camera(player_x,player_y)	

	if btnp(5) then
		set_current_phase(phase_splash)
	end

	if btnp(4) then
		new_floor=floor_current+1
		if new_floor>#maps then
			new_floor = 1
		end
		set_current_floor(new_floor)
	end

	-- update droids
	for droid in all(droids) do
		if droid.floor==floor_current then
			droid.update()
		end
	end

	-- open doors
	for door in all(doors) do
		door.state=door_closed
	end
	for droid in all(droids) do
		for door in all(doors) do
			dx=droid.x-door.x
			dy=droid.y-door.y
			distsqr=dx*dx+dy*dy
			if distsqr < 500 then
				door.state=door_open
			end
		end
	end
end

function init_ingame()
	printh("init_ingame")
end

function enter_ingame()
	printh("enter_ingame")
	-- go through all the map data and setup the dynamic object stuff
	droids={}
	enter_floor(1)
end

function exit_ingame()
	printh("exit_ingame")
end

function exit_floor()
	printh("exit_floor")
	doors={}
	for col=0,96 do
		for row=0,48 do
			mset(col,row,0)
		end
	end
	-- clear doors
end

function enter_floor(new_floor_number)
	printh("enter_floor")
	build_map(new_floor_number)
	for col=0,96 do
		for row=0,48 do
			cell=mget(col,row)
			if cell==sprite_hdoor or cell==sprite_vdoor then
				add_door(col,row,cell)
			end
		end
	end
end

phase_ingame.draw=draw_ingame
phase_ingame.update=update_ingame
phase_ingame.init=init_ingame
phase_ingame.enter=enter_ingame
phase_ingame.exit=exit_ingame

-------------

function update_player()
	mydroid=droids[player_index]
	mydroid.x=player_x
	mydroid.y=player_y
end

-------------

function map_set_area(x1,y1,x2,y2,val)
	for column=x1,x2 do
		for row=y1,y2 do
			mset(column,row,val)
		end
	end
end

function map_is_clear(x,y)
	return fget(mget(x,y))==0
end

function map_is_floor(x,y)
	return fget(mget(x,y),flag_floor)
end

function map_is_collidable(x,y)
	return fget(mget(x,y),flag_collidable)
end

function map_get_cell_state(x,y)
	ret=cell_unknown
	if map_is_clear(x,y) then
		ret=cell_clear
	elseif map_is_floor(x,y) then
		ret=cell_floor
	end
	return ret
end

function map_autogen_walls()
	for column=map_main_xmin+1,map_main_xmax do
		for row=map_main_ymin+1,map_main_ymax do
			if mget(column,row)==sprite_clear then
				val=0
				if (map_get_cell_state(column-1,row-1)==cell_floor) val+=1
				if (map_get_cell_state(column,row-1)==cell_floor) val+=2
				if (map_get_cell_state(column+1,row-1)==cell_floor) val+=4
				if (map_get_cell_state(column-1,row)==cell_floor) val+=8
				if (map_get_cell_state(column+1,row)==cell_floor) val+=16
				if (map_get_cell_state(column-1,row+1)==cell_floor) val+=32
				if (map_get_cell_state(column,row+1)==cell_floor) val+=64
				if (map_get_cell_state(column+1,row+1)==cell_floor) val+=128

				mset(column,row,wall_building_list[val])
			end
		end
	end
end

function map_set_player_to_start()
	for row=2,map_main_xmax do
		for column=2,map_main_ymax do
			if mget(column,row)==sprite_player_start then
				player_x=column*8
				player_y=row*8
			end
		end
	end
	player_index=add_droid(player_x,player_y,1,update_player)
end

map_to_sprite={
	["."]=sprite_floor,
	["S"]=sprite_player_start,
	["v"]=sprite_vdoor,
	["h"]=sprite_hdoor,
}

function build_map(map_num)
	clear_doors()
	-- clear the map
	map_set_area(map_main_xmin,map_main_ymin,map_main_xmax,map_main_ymax,sprite_clear)
	map_data = maps[map_num]
	for i=1,#map_data do
		local cell=sub(map_data,i,i)
		icol=i%96
		irow=flr(i/96)
		mset(icol,irow,map_to_sprite[cell])
	end

	map_autogen_walls()
	-- TODO: This needs better logic behind it... player start set should only happen at game start
	map_set_player_to_start()
end

function set_current_floor(new_floor)
	printh("set_current_floor " .. new_floor)
	exit_floor()
	enter_floor(new_floor)
	floor_current=new_floor
end

function set_current_phase(newphase)
	printh("set_current_phase")
	if phase_current != nil then
		phase_current.exit()
	end
	phase_current=newphase
	phase_current.enter()
end

function _init()
	printh("--------------------------INIT-----------------------")
	mouse_set_mouse(1)
	cls()
	-- init all phases
	phase_splash.init()
	phase_ingame.init()
	set_current_phase(phase_splash)
end

function do_wall_collision(x,y,vx,vy)
	x2=x+vx
	xc=x/8
	xc2=x2/8
	xcf=flr(xc)
	xcf2=flr(xc2)

	y2=y+vy
	yc=y/8
	yc2=y2/8
	ycf=flr(yc)
	ycf2=flr(yc2)

	if vx<0 and xcf!=xcf2 then -- left
		local para=(x-(xcf*8))/(x-x2)
		local ypos=y-((y-y2)*para)	-- intersection at (xcf,tpos)
		local ycell=flr(ypos/8)

		if map_is_collidable(xcf2,ycell) then
			vx=vx*para
		end
	end

	if vx>0 and xcf!=xcf2 then -- right
		local para=((xcf2*8)-x)/(x2-x)
		local ypos=y-((y-y2)*para)
		local ycell=flr(ypos/8)

		para=0
		if map_is_collidable(xcf2,ycell) then
			vx=vx*para
		end
	end

	if vy<0 and ycf!=ycf2 then -- up
		local para=(y-(ycf*8))/(y-y2)
		local xpos=x-((x-x2)*para)	-- intersection at (xcf,tpos)
		local xcell=flr(xpos/8)

		if map_is_collidable(xcell,ycf2) then
			vy=vy*para
		end
	end
	if vy>0 and ycf!=ycf2 then -- down
		local para=((ycf2*8)-y)/(y2-y)
		local xpos=x-((x-x2)*para)
		local xcell=flr(xpos/8)

		para=0
		if map_is_collidable(xcell,ycf2) then
			vy=vy*para
		end
	end
	return vx,vy
end

function update_camera(x,y)
	target_x=x-camera_target_x
	target_y=y-camera_target_y
	camera_x=camera_x+((target_x-camera_x)*camera_damp)
	camera_y=camera_y+((target_y-camera_y)*camera_damp)
end

function _update()
	mouse_update()
	toggle_each_frame=not toggle_each_frame
	phase_current.update()
	camera(camera_x,camera_y)
end

function draw_debug()
	print("picodroid ",camera_x,camera_y,7)
end

function draw_player()
	spr(sprite_player,player_x,player_y)
end

function _draw()
	--draw_splash()
	phase_current.draw()
	draw_debug()
end
-->8 // mouse functions

mouse_last_primary=0
mouse_last_secondary=0
mouse_primary=0
mouse_secondary=0

function mouse_set_mouse(state)
	poke(0x5F2D, state)
end

function mouse_update()
	mouse_last_primary=mouse_primary
	mouse_last_secondary=mouse_secondary
	if band(stat(34),0x01) != 0 then
		mouse_primary=true
	else
		mouse_primary=false
	end
	if band(stat(35),0x02) != 0 then
		mouse_secondary=true
	else
		mouse_secondary=false
	end
end

function mouse_get_primary_down()
	return mouse_primary and not mouse_last_primary
end

function mouse_get_primary()
	return mouse_primary
end

function mouse_get_primary_up()
	return mouse_last_primary and not mouse_primary
end

function mouse_get_secondary_down()
	return mouse_secondary and not mouse_last_secondary
end

function mouse_get_secondary()
	return mousesecondary_
end

function mouse_get_secondary_up()
	return mouse_last_secondary and not mouse_secondary
end
__gfx__
00000000777777767666666567777777677777767777777776666665766666676777777777777776766666657777777776666665766666677666666700000000
00000000666666657666666576666666766666656666666676666665766666667666666666666665666666656666666666666665666666667666666600000000
00000000666556657665566576655666766556656665566676655665766556667665566666655665666556656665566666655665666556667665566600000000
00000000665667657656676576566766765667656656676676566765765667667656676666566765665667656656676666566765665667667656676600000000
00000000665667657656676576566766765667656656676676566765765667667656676666566765665667656656676666566765665667667656676600000000
00000000666776657667766576677666766776656667766676677665766776667667766666677665666776656667766666677665666776667667766600000000
00000000666666657666666576666666766666656666666676666665766666667666666666666665666666656666666666666665666666667666666600000000
00000000555555566555555665555555766666655555555576666665655555557666666576666665555555567666666576666665555555557666666500000000
00000000666666667666666765555556666666660077770067777776000000000000000000000000000000000000000000000000000000000000000000000000
00000000666666666666666656666667666777660770077076666665000000000000000000000000000000000000000000000000000000000000000000000000
00000000666666666666666656666667666677767707707776655665000000000000000000000000000000000000000000000000000000000000000000000000
00000000666666666666666656666667666677767000700776566765000000000000000000000000000000000000000000000000000000000000000000000000
00000000666666666666666656666667666677767000700776566765000000000000000000000000000000000000000000000000000000000000000000000000
00000000666666666666666656666667666677767700707776677665000000000000000000000000000000000000000000000000000000000000000000000000
00000000666666666666666656666667666777660770077076666665000000000000000000000000000000000000000000000000000000000000000000000000
00000000666666667666666567777776666666660077770065555556000000000000000000000000000000000000000000000000000000000000000000000000
66666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666055555500555555005555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777055555500555555005555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666556666655556665555556000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666556666655556665555556000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555055555500555555005555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666055555500555555005555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66766566000660000006600000066000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66766566055665500556655005555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66766566055665500555555005555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66766566055555500555555005555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66766566055555500555555005555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66766566055665500555555005555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66766566055665500556655005555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66766566000660000006600000066000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00070000077777007777777070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00770000000000700000070070007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00070000000000700000700070007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00070000077777000007770077777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00070000700000000000007000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00070000700000000000007000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777000777777707777770000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666666666665566666677666666776666666666666655666666666666665566666666666666776666666666666655666000000000000000000000000
66666666666666666665566666677666666776666666666666555566666666666665566666666666666776666666666666655666000000000000000000000000
66666666666666666655666666665566666776666666666665566556666666666665566666666666667766666666666666667766000000000000000000000000
66666677776666665556666666666555666776667777777755666677666666666665566655555555777666666666665566666777000000000000000000000000
66666777777666665566666666666655666776667777777755666677666666666665566655555555776666666666655566666677000000000000000000000000
66667766667766666666666666666666666776666666666667766776666666666665566666666666666666666666556666666666000000000000000000000000
66677666666556666666666666666666666776666666666666777766666666666665566666666666666666666665566666666666000000000000000000000000
66677666666556666666666666666666666776666666666666677666666666666665566666666666666666666665566666666666000000000000000000000000
ffffffffeeeeeeeeddddddddccccccccbbbbbbbbaaaaaaaa99999999888888887777777766666666555555554444444433333333222222221111111100000000
ffffffffeeeeeeeeddddddddccccccccbbbbbbbbaaaaaaaa99999999888888887777777766666666555555554444444433333333222222221111111100000000
ffffffffeeeeeeeeddddddddccccccccbbbbbbbbaaaaaaaa99999999888888887777777766666666555555554444444433333333222222221111111100000000
ffffffffeeeeeeeeddddddddccccccccbbbbbbbbaaaaaaaa99999999888888887777777766666666555555554444444433333333222222221111111100000000
ffffffffeeeeeeeeddddddddccccccccbbbbbbbbaaaaaaaa99999999888888887777777766666666555555554444444433333333222222221111111100000000
ffffffffeeeeeeeeddddddddccccccccbbbbbbbbaaaaaaaa99999999888888887777777766666666555555554444444433333333222222221111111100000000
ffffffffeeeeeeeeddddddddccccccccbbbbbbbbaaaaaaaa99999999888888887777777766666666555555554444444433333333222222221111111100000000
ffffffffeeeeeeeeddddddddccccccccbbbbbbbbaaaaaaaa99999999888888887777777766666666555555554444444433333333222222221111111100000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000009797979797979797979797979797979787878787878787878787878787878787
87000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000f79797979797979797979797979797979787878787878787878787878787878787
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000009797979797979797979797979797979787878787878787878787878787878787
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000009797979797979797979797979797979787878787878787878787878787878787
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000009797979797979797979797979797979787878787878787878787878787878787
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000009797979797979797979797979797979787878787878787878787878787878787
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000009797979797979797979797979797979787878787878787878787878787878787
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000009797979797979797979797979797979787878787878787878787878787878787
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000009797979797979797979797979797979787878787878787878787878787878787
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000009797979797979797979797979797979787878787878787878787878787878787
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000009797979797979797979797979797979787878787878787878787878787878787
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000009797979797979797979797979797979787878787878787878787878787878787
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000009797979797979797979797979797979787878787878787878787878787878787
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000009797979797979797979797979797979787878787878787878787878787878787
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000009797979797979797979797979797979787878787878787878787878787878787
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000009797979797979797979797979797979787878787878787878787878787878787
06565656565656565616065616065616171717171717171717171717171717172727272727272727272727272727272737373737373737373737373737373737
47474747474747474747474747474747575757575757575757575757575757576767676767676767676767676767676777777777777777777777777777777777
46767676767676767686466686467686171717171717171717171717171717172727272727272727272727272727272737373737373737373737373737373737
47474747474747474747474747474747575757575757575757575757575757576767676767676767676767676767676777777777777777777777777777777777
4676767676767676768646b626467686171717171717171717171717171717172727272727272727272727272727272737373737373737373737373737373737
47474747474747474747474747474747575757575757575757575757575757576767676767676767676767676767676777777777777777777777777777777777
36969696969696969626362676369626171717171717171717171717171717172727272727272727272727272727272737373737373737373737373737373737
47474747474747474747474747474747575757575757575757575757575757576767676767676767676767676767676777777777777777777777777777777777
76760616065616065616061676061676171717171717171717171717171717172727272727272727272727272727272737373737373737373737373737373737
47474747474747474747474747474747575757575757575757575757575757576767676767676767676767676767676777777777777777777777777777777777
7606a68646b626466686468606a68676171717171717171717171717171717172727272727272727272727272727272737373737373737373737373737373737
47474747474747474747474747474747575757575757575757575757575757576767676767676767676767676767676777777777777777777777777777777777
76466686468676467686468646668676171717171717171717171717171717172727272727272727272727272727272737373737373737373737373737373737
47474747474747474747474747474747575757575757575757575757575757576767676767676767676767676767676777777777777777777777777777777777
76369626362676369626362636962676171717171717171717171717171717172727272727272727272727272727272737373737373737373737373737373737
47474747474747474747474747474747575757575757575757575757575757576767676767676767676767676767676777777777777777777777777777777777
06565656565656565616065616065616171717171717171717171717171717172727272727272727272727272727272737373737373737373737373737373737
47474747474747474747474747474747575757575757575757575757575757576767676767676767676767676767676777777777777777777777777777777777
4676767676767676768646b626467686171717171717171717171717171717172727272727272727272727272727272737373737373737373737373737373737
47474747474747474747474747474747575757575757575757575757575757576767676767676767676767676767676777777777777777777777777777777777
4676065656565616768646c616467686171717171717171717171717171717172727272727272727272727272727272737373737373737373737373737373737
47474747474747474747474747474747575757575757575757575757575757576767676767676767676767676767676777777777777777777777777777777777
46763696969696267686369626467686171717171717171717171717171717172727272727272727272727272727272737373737373737373737373737373737
47474747474747474747474747474747575757575757575757575757575757576767676767676767676767676767676777777777777777777777777777777777
46760656565656167686065616467686171717171717171717171717171717172727272727272727272727272727272737373737373737373737373737373737
47474747474747474747474747474747575757575757575757575757575757576767676767676767676767676767676777777777777777777777777777777777
46763696969696267686466686467686171717171717171717171717171717172727272727272727272727272727272737373737373737373737373737373737
47474747474747474747474747474747575757575757575757575757575757576767676767676767676767676767676777777777777777777777777777777777
46767676767676767686467686467686171717171717171717171717171717172727272727272727272727272727272737373737373737373737373737373737
47474747474747474747474747474747575757575757575757575757575757576767676767676767676767676767676777777777777777777777777777777777
36969696969696969626369626369626171717171717171717171717171717172727272727272727272727272727272737373737373737373737373737373737
47474747474747474747474747474747575757575757575757575757575757576767676767676767676767676767676777777777777777777777777777777777
__label__
70000000000007707700777007707770770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07000000000000707070707070700700707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700000000000707070770070700700707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07000000000000707070707070700700707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000000000007007770707077007770777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000006666666666666666666666666666666666666666666666666666666
00000000000000000000000000000000000000000000000000000000000000000000000006666666666666666666666666666666666666666666666666666666
00000000000000000000000000000000000000000000000000000000000000000000000006666666666666666666666666666666666666666666666666666666
00000000000000000000000000000000000000000000000000000000000000000000000006666666666666666666666666666666666666666666666666666666
00000000000000000000000000000000000000000000000000000000000000000000000006666000000000000000000000000000000000000000000006666000
00000000000000000000000000000000000000000000000000000000000000000000000006666000000000000000000000000000000000000000000006666000
00000000000000000000000000000000000000000000000000000000000000000000000006666000000000000000000000000000000000000000000006666000
00000000000000000000000000000000000000000000000000000000000000000000000006666000555555005555550055555500555555005566650006666000
00000000000000000000000000000000000000000000000000000000000000000000000006666000555555005555550055555500555555005556660006666000
00000000000000000000000000000000000000000000000000000000000000000000000006666000555555005555550055555500555555005556660006666000
00000000000000000000000000000000000000000000000000000000000000000000000006666000555555005555550055555500555555005556660006666000
00000000000000000000000000000000000000000000000000000000000000000000000006666000555555005555550055555500555555005556660006666000
00000000000000000000000000000000000000000000000000000000000000000000000006666000555555005555550055555500555555005566650006666000
00000000000000000000000000000000000000000000000000000000000000000000000006666000000000000000000000000000000000000000000006666000
00000000000000000000000000000000000000000000000000000000000000000000000006666000000000000000000000000000000000000000000006666000
00000000000000000000000000000000000000000000000000000000000000000000000006666000555555005555550055555500000000000000000006666000
00000000000000000000000000000000066666666666666666666666666666666666666666666000555555005555550055555500066666666666666666666000
00000000000000000000000000000000066666666666666666666666666666666666666666666000555555005555550055555500066666666666666666666000
00000000000000000000000000000000066666666666666666666666666666666666666666666000555555005555550055555500066666666666666666666000
00000000000000000000000000000000066666666666666666666666666666666666666666666000555555005555550055555500066666666666666666666000
00000000000000000000000000000000066660000000000000000000000000000000000006666000555555005555550055555500066660000000000000000000
00000000000000000000000000000000066660000000000000000000000000000000000006666000000000000000000000000000066660000000000000000000
00000000000000000000000000000000066660000000000000000000000000000000000006666000000000000000000000000000006600000000000000000000
00000000000000000000000000000000066660005555550055555500555555005555550006666000555555005555550055555500006600005555550055555500
00000000000000000000000000000000066660005555550055555500555555005555550006666000555555005555550055555500006600005555550055555500
00000000000000000000000000000000066660005555550055555500555555005555550006666000555555005555550055555500006600005555550055555500
00000000000000000000000000000000066660005555550055555500555555005555550006666000555555005555550055555500006600005555550055555500
00000000000000000000000000000000066660005555550055555500555555005555550006666000555555005555550055555500006600005555550055555500
00000000000000000000000000000000066660005555550055555500555555005577770006666000555555005555550055555500006600005555550055555500
00000000000000000000000000000000066660000000000000000000000000000770077006666000000000000000000000000000006600000000000000000000
00000000000000000000000000000000066660000000000055555500000000007707707700660000000000000000000000000000066660000000000000000000
00000000000000000000000000000000066660005555550500000050555555007555750700660000555555005555550055555500066660005555550055555500
00000000000000000000000000000000066660005555550505555050555555007555750700660000555555005555550055555500066660005555550055555500
00000000000000000000000000000000066660005555550505005050555555007755757700660000555555005555550055555500066660005555550055555500
00000000000000000000000000000000066660005555550505005050555555005775577000660000555555005555550055555500066660005555550055555500
00000000000000000000000000000000066660005555550505555050555555005577770000660000555555005555550055555500066660005555550055555500
00000000000000000000000000000000066660005555550500000050555555005555550000660000555555005555550055555500066660005555550055555500
00000000000000000000000000000000066660000000000055555500000000000000000000660000000000000000000000000000066660000000000000000000
00000000000000000000000000000000066660000000000000000000000000000000000006666000000000000000000000000000066660000000000000000000
00000000000000000000000000000000066660005555550055555500555555005555550006666000000000000000000000000000066660005555550055555500
00000000000000000000000000000000066660005555550055555500555555005555550006666666666666600000000666666666666660005555550055555500
00000000000000000000000000000000066660005555550055555500555555005555550006666666666666666666666666666666666660005555550055555500
00000000000000000000000000000000066660005555550055555500555555005555550006666666666666666666666666666666666660005555550055555500
00000000000000000000000000000000066660005555550055555500555555005555550006666666666666600000000666666666666660005555550055555500
00000000000000000000000000000000066660005555550055555500555555005555550006666000000000000000000000000000066660005555550055555500
00000000000000000000000000000000066660000000000000000000000000000000000006666000000000000000000000000000066660000000000000000000
00000000000000000000000000000000066660000000000000000000000000000000000006666000000000000000000000000000066660000000000000000000
00000000000000000000000000000000066660000000000000000000000000000000000006666000555555005555550055555500066660005555550055555500
00000000000000000000000000000000066666666666666666666660000000066666666666666000555555005555550055555500066660005555550055555500
00000000000000000000000000000000066666666666666666666666666666666666666666666000555555005555550055555500066660005555550055555500
00000000000000000000000000000000066666666666666666666666666666666666666666666000555555005555550055555500066660005555550055555500
00000000000000000000000000000000066666666666666666666660000000066666666666666000555555005555550055555500066660005555550055555500
00000000000000000000000000000000000000000000000006666000000000000000000000000000555555005555550055555500066660005555550055555500
00000000000000000000000000000000000000000000000006666000000000000000000000000000000000000000000000000000066660000000000000000000
00000000000000000000000000000000000000000000000006666000000000000000000000000000000000000000000000000000066660000000000000000000
00000000000000000000000000000000000000000000000006666000555555005555550055555500555555005555550055555500066660005555550055555500
00000000000000000000000000000000000000000000000006666000555555005555550055555500555555005555550055555500066660005555550055555500
00000000000000000000000000000000000000000000000006666000555555005555550055555500555555005555550055555500066660005555550055555500
00000000000000000000000000000000000000000000000006666000555555005555550055555500555555005555550055555500066660005555550055555500
00000000000000000000000000000000000000000000000006666000555555005555550055555500555555005555550055555500066660005555550055555500
00000000000000000000000000000000000000000000000006666000555555005555550055555500555555005555550055555500066660005555550055555500
00000000000000000000000000000000000000000000000006666000000000000000000000000000000000000000000000000000066660000000000000000000
00000000000000000000000000000000000000000000000006666000000000000000000000000000000000000000000000000000006600000000000000000000
00000000000000000000000000000000000000000000000006666000555555005555550055555500555555005555550055555500006600005555550055555500
00000000000000000000000000000000000000000000000006666000555555005555550055555500555555005555550055555500006600005555550055555500
00000000000000000000000000000000000000000000000006666000555555005555550055555500555555005555550055555500006600005555550055555500
00000000000000000000000000000000000000000000000006666000555555005555550055555500555555005555550055555500006600005555550055555500
00000000000000000000000000000000000000000000000006666000555555005555550055555500555555005555550055555500006600005555550055555500
00000000000000000000000000000000000000000000000006666000555555005555550055555500555555005555550055555500006600005555550055555500
00000000000000000000000000000000000000000000000006666000000000000000000000000000000000000000000000000000006600000000000000000000
00000000000000000000000000000000000000000000000006666000000000000000000000000000000000000000000000000000066660000000000000000000
00000000000000000000000000000000000000000000000006666000555555005555550055555500555555005555550055555500066660005555550055555500
00000000000000000000000000000000000000000000000006666000555555005555550055555500555555005555550055555500066660005555550055555500
00000000000000000000000000000000000000000000000006666000555555005555550055555500555555005555550055555500066660005555550055555500
00000000000000000000000000000000000000000000000006666000555555005555550055555500555555005555550055555500066660005555550055555500
00000000000000000000000000000000000000000000000006666000555555005555550055555500555555005555550055555500066660005555550055555500
00000000000000000000000000000000000000000000000006666000555555005555550055555500555555005555550055555500066660005555550055555500
00000000000000000000000000000000000000000000000006666000000000000000000000000000000000000000000000000000066660000000000000000000
00000000000000000000000000000000000000000000000006666000000000000000000000000000000000000000000000000000066660000000000000000000
00000000000000000000000000000000000000000000000006666000000000000000000000000000000000000000000000000000066660000000000000000000
00000000000000000000000000000000000000000000000006666666666666666666666666666666666666666666666666666666666666666666666666666666
00000000000000000000000000000000000000000000000006666666666666666666666666666666666666666666666666666666666666666666666666666666
00000000000000000000000000000000000000000000000006666666666666666666666666666666666666666666666666666666666666666666666666666666
00000000000000000000000000000000000000000000000006666666666666666666666666666666666666666666666666666666666666666666666666666666
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

__gff__
0001010101010101010101010101010000020100000001000000000000000000020000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000805050505050b05090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c
0000000000000000000611111111140611060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c
0000000008050505050c11111108050a11060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c
0000000006111111110611111110111111060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c
0000000006111311111011111106111111060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c
0000000006111111110e050f050c111111060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c
0000000007050b0f050a11111106111111060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c
0000000000000611111111111106111111060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c
0000000000000611111111111110111111060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c
0000000000000611111111111106111111060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c
000000000000070505050505050d0505050a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007f7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007f7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a

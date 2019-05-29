pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
-- lissajous
-- martin linklater

counter=0
res=500


function _init()
 xcount=2
 ycount=3
end

function _update60()
 -- counter loop
 counter=counter+(res*0.001)
 if counter>res then
  counter=counter-res
 end
 
 -- input
 if btnp(0) then
  xcount=xcount+1
 end
 if btnp(1) then
  xcount=xcount-1
 end
 if btnp(2) then
  ycount=ycount+1
 end
 if btnp(3) then
  ycount=ycount-1
 end
 -- limits
 if ycount<1 then
  ycount=1
 end
 if xcount<1 then
  xcount=1
 end
 if ycount>10 then
  ycount=10
 end
 if xcount>10 then
  xcount=10
 end
end

function _draw()
 cls(0)
 print(xcount,0,0)
 print(ycount,20,0)
 for i=0,500 do
  c=i+counter
  x1val=64+cos((c/res)*xcount)*60
  y1val=68+sin((i/res)*ycount)*60
  x2val=64+cos(((c+1)/500)*xcount)*60
  y2val=68+sin(((i+1)/500)*ycount)*60
  line(x1val,y1val,x2val,y2val)
 end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

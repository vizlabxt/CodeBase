#!/usr/bin/ruby2.1.0
# Brainfuck解释器
# (C) Jayson.Xu


f = File.open("./bf.txt","r")
commands = [">","<","+","-",".","[","]",","]

code = []
f.each_byte.each do |b|
  code<<b
end

le = code.length #code length
ip =  -1 #code pointer
cp =  0 #cell pointer
cell = [] #cell
lb = []  #left bracket stack
rb = []  #right bracket stack
cleanCode = [] #new codes
bm = {} #bracket map

0.upto(99) {|i| cell[i] = 0}

#find bracket
while(ip+=1) <= le - 1
  c = code[ip].chr()
  case c
  when '['  
    lb << ip 
    
  when ']' 
    rb << ip
  end

 if commands.include?(c) then
   cleanCode << c
 end
  
end

#check balance
if lb.length != rb.length
  puts "unbalanced bracket!"
  exit
end

#create mapping
counter = 0
lb.each do |b|
  bm[b] = rb[rb.length - counter - 1]
  counter += 1
end

#debug
puts lb.inspect,rb.inspect,bm.inspect

ip = -1
cp = 0
le = cleanCode.length
while( ip+=1 ) <= le - 1
  
  case cleanCode[ip].chr
  when '>' then
    cp += 1
  when '<' then
    cp == 0 ? cp = 0 : cp -= 1
  when '+' then
    cell[cp] == 254 ? cell[cp] = 0 : cell[cp] += 1 
  when '-' then
    cell[cp] == 0 ? cell[cp]  = 0 : cell[cp] -= 1
  when '.' then
    puts cell[cp].chr()
  when '[' then
    cell[cp] == 0 && ip = bm[ip]
  when ']' then
    cell[cp] != 0 && ip = bm.key(ip)
  when ',' then
    cell[cp] = get_character.to_i
  end
  
end



allPokemon = open("nat.txt", "r")
kanto = open("kanto.txt", "r")
johto = open("johto.txt", "r")
hoenn = open("hoenn.txt", "r")
sinnoh = open("sinnoh.txt", "r")
unova = open("unova.txt", "r")
natReadlines = allPokemon.readlines()
kReadlines = kanto.readlines()
jReadlines = johto.readlines()
hReadlines = hoenn.readlines()
sReadlines = sinnoh.readlines()
uReadlines = unova.readlines()

kanto.close()
sinnoh.close()
johto.close()
hoenn.close()
unova.close()
allPokemon.close()




natList = []
kList = []
jList = []
hList = []
sList = []
uList = []




for aline in natReadlines:
    pokemon = aline.split()
    pokemon.append({})
    pokemon[-1]["nat"] = pokemon[0]
    natList.append(pokemon)

for aline in kReadlines:
    pokemon = aline.split()
    pokemon.append('k')
    kList.append(pokemon)

for aline in jReadlines:
    pokemon = aline.split()
    pokemon.append('j')
    jList.append(pokemon)

for aline in hReadlines:
    pokemon = aline.split()
    pokemon.append('h')
    hList.append(pokemon)

for aline in sReadlines:
    pokemon = aline.split()
    pokemon.append('s')
    sList.append(pokemon)

for aline in uReadlines:
    pokemon = aline.split()
    pokemon.append('u')    
    uList.append(pokemon)


for pokemonx in natList:
    for pokedex in [kList, jList, hList, sList, uList]:
        for pokemony in pokedex:
            if pokemonx[1] == pokemony[1]:
                pokemonx[2][pokemony[-1]] = pokemony[0]
                pokemony.append(pokemonx[0])
                break
            else:
                pokemonx[2][pokemony[2]] = '?'
            


print(natList[485:490])



for dex in [kList, jList, hList, sList, uList]:
    print(dex[0][2])
    outputfile = open(dex[0][2]+".plist", 'w')
    outputfile.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    outputfile.write('<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">\n')
    outputfile.write('<plist version="1.0">\n')
    outputfile.write('<dict>\n')
    for pokemon in dex:
        outputfile.write('  <key>'+str(int(pokemon[0])) +'</key>\n   <dict>\n      <key>'+"name"+'</key>\n      <string>'+pokemon[1]+'</string>\n      <key>'+"num"+'</key>\n      <string>'+pokemon[0]+'</string>\n      <key>'+"pic"+'</key>\n      <string>'+pokemon[-1]+'MS.png</string>\n      <key>isCaught</key>\n      <false/>\n   </dict>\n')

    outputfile.write('</dict>\n</plist>')
    outputfile.close()

outputfile = open("nat.plist", 'w')
outputfile.write('<?xml version="1.0" encoding="UTF-8"?>\n')
outputfile.write('<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">\n')
outputfile.write('<plist version="1.0">\n')
outputfile.write('<dict>\n')
for pokemon in natList:
    outputfile.write('  <key>'+str(int(pokemon[0])) +'</key>\n   <dict>\n      <key>'+"name"+'</key>\n      <string>'+pokemon[1]+'</string>\n      <key>'+"num"+'</key>\n      <string>'+pokemon[0]+'</string>\n      <key>'+"pic"+'</key>\n      <string>'+pokemon[0]+'MS.png</string>\n      <key>isCaught</key>\n      <false/>\n   </dict>\n')

outputfile.write('</dict>\n</plist>')
outputfile.close()












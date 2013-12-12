from operator import itemgetter, attrgetter
pokemon = open("pokemon.txt", 'r')
pReadlines = pokemon.readlines()
pokemon.close()



natList = []
kList = []

jGSCList = []
jHGSSList = []

hList = []

sDPList = []
sPTList = []

uBWList = []
uB2W2List = []

kCentList= []
kCoastList = []
kMountList = []

#pokemon[0] = name
#pokemon[1] = nationl dex
#pokemon[2] = GSC dex
#pokemon[3] = HGSS dex
#pokemon[4] = RSE dex
#pokemon[5] = DP dex
#pokemon[6] = PT dex
#pokemon[7] = BW dex
#pokemon[8] = B2W2 dex
#pokemon[9] = xyCent dex
#pokemon[10] = xyCoast dex
#pokemon[11] = xyMount dex
#pokemon[12] = img


for aline in pReadlines:
    pokemon = aline.split()
    natList.append([pokemon[0],int(pokemon[1]),pokemon[-1]])
    #print(pokemon)

    if pokemon[2] != "???":
        jGSCList.append([pokemon[0], int(pokemon[2]),int(pokemon[1]), pokemon[-1]])
    if pokemon[6] != "???":
        jHGSSList.append([pokemon[0], int(pokemon[6]),int(pokemon[1]), pokemon[-1],])
    if pokemon[3] != "???":
        hList.append([pokemon[0], int(pokemon[3]),int(pokemon[1]), pokemon[-1]])
    if pokemon[4] != "???":
        sDPList.append([pokemon[0], int(pokemon[4]),int(pokemon[1]), pokemon[-1]])
    if pokemon[5] != "???":
        sPTList.append([pokemon[0], int(pokemon[5]),int(pokemon[1]), pokemon[-1]])
    if pokemon[7] != "???":
        uBWList.append([pokemon[0], int(pokemon[7]),int(pokemon[1]), pokemon[-1]])
    if pokemon[8] != "???":
        uB2W2List.append([pokemon[0], int(pokemon[8]),int(pokemon[1]), pokemon[-1]])
    if pokemon[9] != "???":
        kCentList.append([pokemon[0], int(pokemon[9]),int(pokemon[1]), pokemon[-1]])
    if pokemon[10] != "???":
        kCoastList.append([pokemon[0], int(pokemon[10]),int(pokemon[1]), pokemon[-1]])
    if pokemon[11] != "???":
        kMountList.append([pokemon[0], int(pokemon[11]),int(pokemon[1]), pokemon[11]])
dexs = [jGSCList, jHGSSList, hList,  sDPList, sPTList, uBWList, uB2W2List, kCentList, kCoastList, kMountList]
for x in range(len(dexs)):
    dexs[x] = sorted(dexs[x], key = itemgetter(1))
dexNames= ["jGSC", "jHGSS", "hRSE", "sDP", "sPT", "uBW", "uB2W2", "kCent", "kCoast", "kMount"]
i = 0
for dex in dexs:
    print(dex[0][2])
    outputfile = open(dexNames[i]+".plist", 'w')
    outputfile.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    outputfile.write('<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">\n')
    outputfile.write('<plist version="1.0">\n')
    outputfile.write('<dict>\n')
    for pokemon in dex:
        outputfile.write('  <key>'+str(int(pokemon[1])) +'</key>\n   <dict>\n      <key>'+"name"+'</key>\n      <string>'+pokemon[0]+'</string>\n      <key>'+"num"+'</key>\n      <string>'+str(pokemon[1])+'</string>\n      <key>'+"pic"+'</key>\n      <string>'+pokemon[3]+'</string>\n      <key>isCaught</key>\n      <false/>\n   </dict>\n')

    outputfile.write('</dict>\n</plist>')
    outputfile.close()
    i+=1
outputfile = open("nat.plist", 'w')
outputfile.write('<?xml version="1.0" encoding="UTF-8"?>\n')
outputfile.write('<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">\n')
outputfile.write('<plist version="1.0">\n')
outputfile.write('<dict>\n')
for x in range(len(natList)):
    outputfile.write('  <key>'+str(int(natList[x][1])) +'</key>\n   <dict>\n      <key>'+"name"+'</key>\n      <string>'+natList[x][0]+'</string>\n      <key>'+"num"+'</key>\n      <string>'+str(natList[x][1])+'</string>\n      <key>'+"pic"+'</key>\n      <string>'+natList[x][2]+'</string>\n      <key>isCaught</key>\n      <false/>\n   </dict>\n')
outputfile.write('</dict>\n</plist>')
outputfile.close()

        

import json, httplib


natList = []
objectIDs = []
allPokemon = open("nat.txt", 'r')
natReadlines = allPokemon.readlines()

allPokemon.close()

for aline in natReadlines:
    pokemonInfo = aline.split()
    pokemon = {"name":pokemonInfo[1], "num":pokemonInfo[0], "pic":pokemonInfo[0]+"MS.png", "isCaught":False}
    natList.append(pokemon)

connection = httplib.HTTPSConnection("api.parse.com",443)
connection.connect()
a = []

for i in range(649):
    a.append(False)


##for pokemon in natList:
##    connection.request('POST', '/1/classes/NationalPokedex', json.dumps({
##       "name": pokemon["name"],
##       "num": pokemon["num"],
##       "pic": pokemon["pic"],
##       "isCaught":pokemon["isCaught"]
##     }), {
##       "X-Parse-Application-Id": "WR1klxy9Rkbpey6hVlqKxVctcpvcb287PpsdI1GI",
##       "X-Parse-REST-API-Key": "JH9Ac9Jmct6FNnymIRDEyrDi3XTIrCQJTznJosC5",
##       "Content-Type": "application/json"
##     })
##    result = json.loads(connection.getresponse().read())
##    objectIDs.append(result[u"objectId"].encode("ascii"))
####print result

connection.request('POST', '/1/classes/NationalPokedex', json.dumps({
    "isCaughtArray": a}),{
       "X-Parse-Application-Id": "WR1klxy9Rkbpey6hVlqKxVctcpvcb287PpsdI1GI",
       "X-Parse-REST-API-Key": "JH9Ac9Jmct6FNnymIRDEyrDi3XTIrCQJTznJosC5",
       "Content-Type": "application/json"
     })
result = json.loads(connection.getresponse().read())
    

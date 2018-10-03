import random
letters=[]
letters.extend([chr(i) for i in range(48,57)])
letters.extend([chr(i) for i in range(65,90)])

letters.extend([chr(i) for i in range(97,122)])
users=[ "mugarte2@miuandes.cl",
"imgarrido@miuandes.cl",
"cminzunza@miuandes.cl",
"eloy.navarrete@hotmail.com",
"oscar.rodriguez.psi@gmail.com","3592294@gmail.com",
"bcaros@uc.cl",
"Jfhenriquez@miuandes.cl",
"pamela.figueroaas.@gmail.com",
"tamarshantal@icloud.com", 
"mjcampero@uc.cl",
"alfuentealba@uc.cl",
"skclaussen@miuandes.cl",
"manuelfsc78@gmail.com",
"pemorata@uc.cl",
"jgvaldivieso@uc.cl", 
"caperez14@uc.cl",
"mlvaldivia@uc.cl",
"ignacio.galvezr@mail.udp.cl",
"valeria.troncoso@usach.cl",
"ipgonzale@miuandes.cl"]

print letters
for user in users:
    #gen passw
    k=0
    pass_len=10
    password=""
    while k<pass_len:
        password+= random.choice(letters)
        k+=1
    print user+": "+password+"\n"

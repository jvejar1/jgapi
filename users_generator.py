import random
letters=[]
letters.extend([chr(i) for i in range(48,57)])
letters.extend([chr(i) for i in range(65,90)])

letters.extend([chr(i) for i in range(97,122)])
users=["crojash@uc.cl"]

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

load("base-bmv.sage")

# n = 4
# makeY = True

y = []

yindexing1 = []
yindexing2 = []
yindexing3 = []
for i in range(1,n+1):
    for j in range(i+1,n+1):
        for k in range(j+1,n+1):
            if makeY:
                y.append(avar(j,i)*avar(i,k)*bvar(j,k))
                y.append(avar(j,i)*avar(j,k)*bvar(i,k))
                y.append(avar(i,k)*avar(j,k)*bvar(j,i))
            yindexing1.append(((i,j,k),i))
            yindexing1.append(((i,j,k),j))
            yindexing1.append(((i,j,k),k))

for i in range(1,n+1):
    for j in range(1,n+1):
        if i != j:
            if makeY:
                y.append(avar(j,i)*avar(i,i)*bvar(i,j))
            yindexing2.append((i,j))


for i in range(1,n+1):
    for j in range(1,n+1):
        if makeY:
            y.append(avar(j,i)*avar(j,i)*bvar(i,i))
        yindexing3.append((i,j))


U = matrix(ZZ,len(yindexing1)+len(yindexing2)+len(yindexing3),len(yindexing1)+len(yindexing2)+len(yindexing3));




block1Matrix = matrix(ZZ, len(yindexing1), len(yindexing1));

for row_num, row_index in enumerate(yindexing1):
    i = row_index[0][0]
    j = row_index[0][1]
    k = row_index[0][2]
    l = row_index[1]
    for col_num, col_index in enumerate(yindexing1):
        iprime = col_index[0][0]
        jprime = col_index[0][1]
        kprime = col_index[0][2]
        lprime = col_index[1]
        
        entryVal = len({i,j,k}.intersection({iprime,jprime,kprime}))
        if l == lprime:
            entryVal += 1
        block1Matrix[row_num,col_num] = entryVal * 6
        U[row_num,col_num] = block1Matrix[row_num,col_num]

# for i in range(len(yindexing1)):
#     for j in range(len(yindexing1)):
#         seti = Set(yindexing1[i][0])
#         setj = Set(yindexing1[j][0])
#         entryVal = len(seti.intersection(setj))
#         if yindexing1[i][1] == yindexing1[j][1]:
#             entryVal += 1
#         block1Matrix[i,j] = entryVal * 6
#         U[i,j] = block1Matrix[i,j]







block2Matrix = matrix(ZZ, len(yindexing2), len(yindexing2));

for row_num, row_index in enumerate(yindexing2):
    i = row_index[0]
    j = row_index[1]
    for col_num, col_index in enumerate(yindexing2):
        iprime = col_index[0]
        jprime = col_index[1]
# for i in range(len(yindexing2)):
#     for j in range(len(yindexing2)):
        # val = 6(j n j') + 30(i n i') + 12(i n j') + 12(j n i')
        block2Matrix[row_num,col_num] = 6*len({j}.intersection({jprime})) + 30*len({i}.intersection({iprime})) + 12*len({i}.intersection({jprime})) + 12*len({j}.intersection({iprime}))
        # block2Matrix[i,j] = 6*len({yindexing2[i][1]}.intersection({yindexing2[j][1]})) + 30*len({yindexing2[i][0]}.intersection({yindexing2[j][0]})) + 12*len({yindexing2[i][0]}.intersection({yindexing2[j][1]})) + 12*len({yindexing2[i][1]}.intersection({yindexing2[j][0]}))

        U[row_num + len(yindexing1), col_num + len(yindexing1)] = block2Matrix[row_num,col_num]
        U[col_num + len(yindexing1), row_num + len(yindexing1)] = U[row_num + len(yindexing1), col_num + len(yindexing1)]
        # U[i + len(yindexing1), j + len(yindexing1)] = block2Matrix[i,j]
        # U[j + len(yindexing1), i + len(yindexing1)] = U[i + len(yindexing1), j + len(yindexing1)]


block3Matrix = matrix(ZZ, len(yindexing3), len(yindexing3));

for row_num, row_index in enumerate(yindexing3):
    ihat = row_index[0]
    jhat = row_index[1]
    for col_num, col_index in enumerate(yindexing3):
        ihatprime = col_index[0]
        jhatprime = col_index[1]
        if ihat != jhat and ihatprime != jhatprime:
            intersection = 4 - len(Set([ihat, jhat, ihatprime, jhatprime]))
            if ihat == ihatprime:
                intersection += 1
            block3Matrix[row_num,col_num] = intersection*3
        else:
            intersections = 0
            if ihat == ihatprime:
                intersections = 3
            if jhat == jhatprime:
                intersections += 2
            block3Matrix[row_num,col_num] = intersections*3

        U[row_num + len(yindexing1) + len(yindexing2), col_num + len(yindexing1) + len(yindexing2)] = block3Matrix[row_num,col_num]







# S12Matrix = matrix(ZZ, len(yindexing2), len(yindexing1));

# for i in range(len(yindexing2)):
#     for j in range(len(yindexing1)):
#         if yindexing2[i][0] in yindexing1[j][0]:
#             S12Matrix[i,j] = S12Matrix[i,j] + 12
#         if yindexing2[i][1] in yindexing1[j][0]:
#             S12Matrix[i,j] = S12Matrix[i,j] + 6
#         if yindexing2[i][0] == yindexing1[j][1]:
#             S12Matrix[i,j] = S12Matrix[i,j] + 6

#         U[i + len(yindexing1), j] = S12Matrix[i,j]
#         U[j, i + len(yindexing1)] = U[i + len(yindexing1), j]

S12Matrix = matrix(ZZ, len(yindexing1), len(yindexing2));

for row_num, row_index in enumerate(yindexing1):
    i = row_index[0][0]
    j = row_index[0][1]
    k = row_index[0][2]
    l = row_index[1]
    for col_num, col_index in enumerate(yindexing2):
        iprime = col_index[0]
        jprime = col_index[1]    
        if iprime in [i,j,k]:
            S12Matrix[row_num,col_num] = S12Matrix[row_num,col_num] + 12
        if jprime in [i,j,k]:
            S12Matrix[row_num,col_num] = S12Matrix[row_num,col_num] + 6
        if iprime == l:
            S12Matrix[row_num,col_num] = S12Matrix[row_num,col_num] + 6

        U[row_num, col_num + len(yindexing1)] = S12Matrix[row_num,col_num]
        U[col_num + len(yindexing1), row_num] = U[row_num, col_num + len(yindexing1)]


# S13Matrix = matrix(ZZ, len(yindexing3), len(yindexing1));

# for i in range(len(yindexing3)):
#     for j in range(len(yindexing1)):
#         if yindexing3[i][0] in yindexing1[j][0]:
#             S13Matrix[i,j] = S13Matrix[i,j] + 6
#         if yindexing3[i][1] in yindexing1[j][0]:
#             S13Matrix[i,j] = S13Matrix[i,j] + 3
#         if yindexing3[i][1] == yindexing1[j][1]:
#             S13Matrix[i,j] = S13Matrix[i,j] + 3

#         U[i + len(yindexing1) + len(yindexing2), j] = S13Matrix[i,j]
#         U[j, i + len(yindexing1) + len(yindexing2)] = U[i + len(yindexing1) + len(yindexing2), j]

S13Matrix = matrix(ZZ, len(yindexing1), len(yindexing3));

for row_num, row_index in enumerate(yindexing1):
    i = row_index[0][0]
    j = row_index[0][1]
    k = row_index[0][2]
    l = row_index[1]
    for col_num, col_index in enumerate(yindexing3):
        ihat = col_index[0]
        jhat = col_index[1]
        if ihat in [i,j,k]:
            S13Matrix[row_num,col_num] = S13Matrix[row_num,col_num] + 6
        if jhat in [i,j,k]:
            S13Matrix[row_num,col_num] = S13Matrix[row_num,col_num] + 3
        if jhat == l:
            S13Matrix[row_num,col_num] = S13Matrix[row_num,col_num] + 3

        U[row_num, col_num + len(yindexing1) + len(yindexing2)] = S13Matrix[row_num,col_num]
        U[col_num + len(yindexing1) + len(yindexing2), row_num] = U[row_num, col_num + len(yindexing1) + len(yindexing2)]



S23Matrix = matrix(ZZ, len(yindexing2), len(yindexing3));
for row_num, row_index in enumerate(yindexing2):
    i = row_index[0]
    j = row_index[1]
    for col_num, col_index in enumerate(yindexing3):
        ihat = col_index[0]
        jhat = col_index[1]
        if ihat == i and jhat == j:
            S23Matrix[row_num,col_num] = 15
        elif ihat == i and jhat == i:
            S23Matrix[row_num,col_num] = 21
        elif ihat == i and j != i and ihat != j and jhat != i:
            S23Matrix[row_num,col_num] = 12
        elif ihat == j and jhat == i:
            S23Matrix[row_num,col_num] = 15
        elif jhat == i and ihat != j and ihat != i:
            S23Matrix[row_num,col_num] = 9
        elif ihat == jhat and ihat == j:
            S23Matrix[row_num,col_num] = 9
        elif ihat == j and jhat != i and jhat != j:
            S23Matrix[row_num,col_num] = 6
        elif jhat == j and ihat != jhat:
            S23Matrix[row_num,col_num] = 3
        else:
            S23Matrix[row_num,col_num] = 0

        U[row_num + len(yindexing1), col_num + len(yindexing1) + len(yindexing2)] = S23Matrix[row_num,col_num]
        U[col_num + len(yindexing1)+ len(yindexing2), row_num + len(yindexing1)] = U[row_num + len(yindexing1), col_num + len(yindexing1) + len(yindexing2)]



# S23Matrix = matrix(ZZ, len(yindexing3), len(yindexing2));

# for i in range(len(yindexing3)):
#     for j in range(len(yindexing2)):
#         if yindexing3[i][0] == yindexing2[j][0] and yindexing3[i][1] == yindexing2[j][1]:
#             S23Matrix[i,j] = 15
#         elif yindexing3[i][0] == yindexing2[j][0] and yindexing3[i][1] == yindexing2[j][0]:
#             S23Matrix[i,j] = 21
#         elif yindexing3[i][0] == yindexing2[j][0] and yindexing2[j][1] != yindexing2[j][0] and yindexing3[i][0] != yindexing2[j][1] and yindexing3[i][1] != yindexing2[j][0]:
#             S23Matrix[i,j] = 12
#         elif yindexing3[i][0] == yindexing2[j][1] and yindexing3[i][1] == yindexing2[j][0]:
#             S23Matrix[i,j] = 15
#         elif yindexing3[i][1] == yindexing2[j][0] and yindexing3[i][0] != yindexing2[j][1] and yindexing3[i][0] != yindexing2[j][0]:
#             S23Matrix[i,j] = 9
#         elif yindexing3[i][0] == yindexing3[i][1] and yindexing3[i][0] == yindexing2[j][1]:
#             S23Matrix[i,j] = 9
#         elif yindexing3[i][0] == yindexing2[j][1] and yindexing3[i][1] != yindexing2[j][0] and yindexing3[i][1] != yindexing2[j][1]:
#             S23Matrix[i,j] = 6
#         elif yindexing3[i][1] == yindexing2[j][1] and yindexing3[i][0] != yindexing3[i][1]:
#             S23Matrix[i,j] = 3
#         else:
#             S23Matrix[i,j] = 0

#         U[i + len(yindexing1) + len(yindexing2), j + len(yindexing1)] = S23Matrix[i,j]
#         U[j + len(yindexing1), i + len(yindexing1) + len(yindexing2)] = U[i + len(yindexing1) + len(yindexing2), j + len(yindexing1)]




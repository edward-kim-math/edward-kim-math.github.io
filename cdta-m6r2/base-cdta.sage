MyRing.<t, a11, a12, a13, a14, a15, a16, a17, a18, a19, a22, a23, a24, a25, a26, a27, a28, a29, a33, a34, a35, a36, a37, a38, a39, a44, a45, a46, a47, a48, a49, a55, a56, a57, a58, a59, a66, a67, a68, a69, a77, a78, a79, a88, a89, a99, b11, b12, b13, b14, b15, b16, b17, b18, b19, b22, b23, b24, b25, b26, b27, b28, b29, b33, b34, b35, b36, b37, b38, b39, b44, b45, b46, b47, b48, b49, b55, b56, b57, b58, b59, b66, b67, b68, b69, b77, b78, b79, b88, b89, b99> = QQ[];

def avar(i,j):
    if i <= j:
        return MyRing("a" + str(i) + str(j))
    else:
        return MyRing("a" + str(j) + str(i))

def bvar(i,j):
    if i <= j:
        return MyRing("b" + str(i) + str(j))
    else:
        return MyRing("b" + str(j) + str(i))

def makeyandU(n):
    if n < 10:
        makeY = True
    else:
        makeY = False

    # create y vector and y vector indexing
    y = []
    yindexing1 = []
    yindexing2 = []
    yindexing3 = []
    yIndexlatex = []
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
                yIndexlatex.append(latex((Set([i,j,k]),i)))
                yIndexlatex.append(latex((Set([i,j,k]),j)))
                yIndexlatex.append(latex((Set([i,j,k]),k)))

    for i in range(1,n+1):
        for j in range(1,n+1):
            if i != j:
                if makeY:
                    y.append(avar(j,i)*avar(i,i)*bvar(i,j))
                yindexing2.append((i,j))
                yIndexlatex.append(latex((i,j)))
    for i in range(1,n+1):
        for j in range(1,n+1):
            if makeY:
                y.append(avar(j,i)*avar(j,i)*bvar(i,i))
            yindexing3.append((i,j))
            yIndexlatex.append("(\\hat{" + str(i) + "}, \\hat{" + str(j) + "})")

    # create U, block by block
    U = matrix(ZZ,len(yindexing1)+len(yindexing2)+len(yindexing3),len(yindexing1)+len(yindexing2)+len(yindexing3))

    block1Matrix = matrix(ZZ, len(yindexing1), len(yindexing1))
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

    block2Matrix = matrix(ZZ, len(yindexing2), len(yindexing2))
    for row_num, row_index in enumerate(yindexing2):
        i = row_index[0]
        j = row_index[1]
        for col_num, col_index in enumerate(yindexing2):
            iprime = col_index[0]
            jprime = col_index[1]
            block2Matrix[row_num,col_num] = 6*len({j}.intersection({jprime})) + 30*len({i}.intersection({iprime})) + 12*len({i}.intersection({jprime})) + 12*len({j}.intersection({iprime}))
            U[row_num + len(yindexing1), col_num + len(yindexing1)] = block2Matrix[row_num,col_num]
            U[col_num + len(yindexing1), row_num + len(yindexing1)] = U[row_num + len(yindexing1), col_num + len(yindexing1)]

    block3Matrix = matrix(ZZ, len(yindexing3), len(yindexing3))
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

    S12Matrix = matrix(ZZ, len(yindexing1), len(yindexing2))
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

    S13Matrix = matrix(ZZ, len(yindexing1), len(yindexing3))
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

    S23Matrix = matrix(ZZ, len(yindexing2), len(yindexing3))
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

    return y, yIndexlatex, U

def getIndexOfU(n, index):
    indexAt = 0
    for i in range(1,n+1):
        for j in range(i+1,n+1):
            for k in range(j+1,n+1):
                if index == ((i,j,k),i):
                    return indexAt
                indexAt += 1
                if index == ((i,j,k),j):
                    return indexAt
                indexAt += 1
                if index == ((i,j,k),k):
                    return indexAt
                indexAt += 1
    for i in range(1,n+1):
        for j in range(1,n+1):
            if i != j:
                if index == ("s2",i,j):
                    return indexAt
                indexAt += 1
    for i in range(1,n+1):
        for j in range(1,n+1):
            if index == ("s3",i,j):
                return indexAt
            indexAt += 1
    return -1

def makezVecsandR(n):
    blocksizes = [1,n-1,n-1,(n-1)^2,n*(n-1),n*(n-1)]

    entriesbyblock = matrix(
    [[30, 21, 21, 12, 9, 9],
    [21, 18, 12, 9, 3, 9],
    [21, 12, 18, 9, 9, 3],
    [12, 9, 9, 6, 3, 3],
    [9, 3, 9, 3, 6, 0],
    [9, 9, 3, 3, 0, 6]])

    matrixrows = []
    for rowblocknum in range(len(blocksizes)):
        matrixrow = []
        for colblocknum in range(len(blocksizes)):
            for colnuminblock in range(blocksizes[colblocknum]):
                matrixrow.append(entriesbyblock[rowblocknum,colblocknum])
        for rownuminblock in range(blocksizes[rowblocknum]):
            matrixrows.append(matrixrow)
    R = matrix(matrixrows)

    zVecs = [[] for i in range(binomial(n,2))]
    zIndex = [[] for i in range(binomial(n,2))]

    if n < 10:
        h = 0
        for j in range (2,n+1):
            for i in range (1, j):
                # section 1
                zVecs[h].append(avar(i,j)^2*bvar(i,j))
                zIndex[h].append(vector([1]))

                # section 2
                zVecs[h].append(avar(i,i)*avar(i,j)*bvar(i,i))
                zIndex[h].append(vector([2,1]))
                for k in range (1,n+1):
                    if k != i and k != j:
                        zVecs[h].append(avar(i,j)*avar(i,k)*bvar(i,k))
                        zIndex[h].append(vector([2,2,k]))

                # section 3
                for k in range (1,n+1):
                    if k != i:
                        zVecs[h].append(avar(i,j)*avar(j,k)*bvar(j,k))
                        zIndex[h].append(vector([3,k]))

                # section 4
                zVecs[h].append(avar(i,i)*avar(j,j)*bvar(i,j))
                zIndex[h].append(vector([4,1]))
                for k in range (1,n+1):
                    if k != i and k != j:
                        zVecs[h].append(avar(i,i)*avar(j,k)*bvar(i,k))
                        zIndex[h].append(vector([4,2,k]))
                for k in range (1,n+1):
                    if k != i and k != j:
                        zVecs[h].append(avar(i,k)*avar(j,j)*bvar(j,k))
                        zIndex[h].append(vector([4,3,k]))
                for k in range (1,n+1):
                    if k != i and k != j:
                        zVecs[h].append(avar(i,k)*avar(j,k)*bvar(k,k))
                        zIndex[h].append(vector([4,4,k]))
                for k in range (1,n+1):
                    for l in range (1,n+1):
                        if l != i and l != j and l != k and k != i and k != j:
                            zVecs[h].append(avar(i,k)*avar(j,l)*bvar(k,l))
                            zIndex[h].append(vector([4,5,k,l]))

                # section 5
                zVecs[h].append(avar(i,i)*avar(i,i)*bvar(i,j))
                zIndex[h].append(vector([5,1]))
                zVecs[h].append(avar(i,i)*avar(i,j)*bvar(j,j))
                zIndex[h].append(vector([5,2]))
                for k in range (1,n+1):
                    if k != i and k != j:
                        zVecs[h].append(avar(i,i)*avar(i,k)*bvar(k,j))
                        zIndex[h].append(vector([5,3,k]))
                for k in range (1,n+1):
                    if k != i and k != j:
                        zVecs[h].append(avar(i,k)*avar(i,k)*bvar(i,j))
                        zIndex[h].append(vector([5,4,k]))
                for k in range (1,n+1):
                    if k != i and k != j:
                        zVecs[h].append(avar(i,k)*avar(j,k)*bvar(j,j))
                        zIndex[h].append(vector([5,5,k]))
                for k in range (1,n+1):
                    if k != i and k != j:
                        zVecs[h].append(avar(i,k)*avar(k,k)*bvar(j,k))
                        zIndex[h].append(vector([5,6,k]))
                for k in range (1,n+1):
                    for l in range (1,n+1):
                        if l != i and l != j and l != k and k != i and k != j:
                            zVecs[h].append(avar(i,k)*avar(k,l)*bvar(j,l))
                            zIndex[h].append(vector([5,7,k,l]))

                # section 6
                zVecs[h].append(avar(j,j)*avar(i,j)*bvar(i,i))
                zIndex[h].append(vector([6,1]))
                zVecs[h].append(avar(j,j)*avar(j,j)*bvar(i,j))
                zIndex[h].append(vector([6,2]))
                for k in range (1,n+1):
                    if k != i and k != j:
                        zVecs[h].append(avar(j,j)*avar(k,j)*bvar(i,k))
                        zIndex[h].append(vector([6,3,k]))
                for k in range (1,n+1):
                    if k != i and k != j:
                        zVecs[h].append(avar(j,k)*avar(i,k)*bvar(i,i))
                        zIndex[h].append(vector([6,4,k]))
                for k in range (1,n+1):
                    if k != i and k != j:
                        zVecs[h].append(avar(j,k)*avar(j,k)*bvar(i,j))
                        zIndex[h].append(vector([6,5,k]))
                for k in range (1,n+1):
                    if k != i and k != j:
                        zVecs[h].append(avar(j,k)*avar(k,k)*bvar(i,k))
                        zIndex[h].append(vector([6,6,k]))
                for k in range (1,n+1):
                    for l in range (1,n+1):
                        if l != i and l != j and l != k and k != i and k != j:
                            zVecs[h].append(avar(j,k)*avar(k,l)*bvar(i,l))
                            zIndex[h].append(vector([6,7,k,l]))

                h = h + 1

    return zVecs, zIndex, R

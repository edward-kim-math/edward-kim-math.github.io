load("base-bmv.sage")

# n = 4

baseRepeatedMatrix = matrix(ZZ, [[30, 21, 21, 12, 9, 9], [21, 18, 12, 9, 3, 9], [21, 12, 18, 9, 9, 3], [12, 9, 9, 6, 3, 3], [9, 3, 9, 3, 6, 0], [9, 9, 3, 3, 0, 6]])

zVecs = [[] for i in range(binomial(n,2))]

h = 0

rowNums = [0 for i in range(6)]

for j in range (2,n+1):
    for i in range (1, j):
        # section 1
        zVecs[h].append(avar(i,j)^2*bvar(i,j))
        rowNums[0] = 1

        # section 2
        zVecs[h].append(avar(i,i)*avar(i,j)*bvar(i,i))
        rowNums[1] = 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(i,j)*avar(i,k)*bvar(i,k))
                rowNums[1] = rowNums[1] + 1

        
        # section 3
        rowNums[2] = 0
        for k in range (1,n+1):
            if k != i:
                zVecs[h].append(avar(i,j)*avar(j,k)*bvar(j,k))
                rowNums[2] = rowNums[2] + 1
        
        # section 4
        zVecs[h].append(avar(i,i)*avar(j,j)*bvar(i,j))
        rowNums[3] = 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(i,i)*avar(j,k)*bvar(i,k))
                rowNums[3] = rowNums[3] + 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(i,k)*avar(j,j)*bvar(j,k))
                rowNums[3] = rowNums[3] + 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(i,k)*avar(j,k)*bvar(k,k))
                rowNums[3] = rowNums[3] + 1
        for k in range (1,n+1):
            for l in range (1,n+1):
                if l != i and l != j and l != k and k != i and k != j:
                    zVecs[h].append(avar(i,k)*avar(j,l)*bvar(k,l))
                    rowNums[3] = rowNums[3] + 1

        # section 5
        zVecs[h].append(avar(i,i)*avar(i,i)*bvar(i,j))
        zVecs[h].append(avar(i,i)*avar(i,j)*bvar(j,j))
        rowNums[4] = 2
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(i,i)*avar(i,k)*bvar(k,j))
                rowNums[4] = rowNums[4] + 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(i,k)*avar(i,k)*bvar(i,j))
                rowNums[4] = rowNums[4] + 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(i,k)*avar(j,k)*bvar(j,j))
                rowNums[4] = rowNums[4] + 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(i,k)*avar(k,k)*bvar(j,k))
                rowNums[4]= rowNums[4] + 1
        for k in range (1,n+1):
            for l in range (1,n+1):
                if l != i and l != j and l != k and k != i and k != j:
                    # if avar(i,k)*avar(k,l)*bvar(j,l) not in zVecs[h]: # and avar(i,l)*avar(k,l)*bvar(j,k) not in zVecs[h]:
                    zVecs[h].append(avar(i,k)*avar(k,l)*bvar(j,l))
                        # zVecs[h].append(avar(i,l)*avar(k,l)*bvar(j,k))
                        # print("jnrfk")
                    # rowNums[4] = rowNums[4] + 2
                    rowNums[4] = rowNums[4] + 1
                    # else:
                    #     print("not working")
                    
        # section 6
        zVecs[h].append(avar(j,j)*avar(i,j)*bvar(i,i))
        zVecs[h].append(avar(j,j)*avar(j,j)*bvar(i,j))
        rowNums[5] = 2
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(j,j)*avar(k,j)*bvar(i,k))
                rowNums[5] = rowNums[5] + 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(j,k)*avar(i,k)*bvar(i,i))
                rowNums[5] = rowNums[5] + 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(j,k)*avar(j,k)*bvar(i,j))
                rowNums[5] = rowNums[5] + 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(j,k)*avar(k,k)*bvar(i,k))
                rowNums[5] = rowNums[5] + 1
        for k in range (1,n+1):
            for l in range (1,n+1):
                if l != i and l != j and l != k and k != i and k != j:
                    
                    zVecs[h].append(avar(j,k)*avar(k,l)*bvar(i,l))
                        # zVecs[h].append(avar(j,l)*avar(k,l)*bvar(i,k))
                    # rowNums[5] = rowNums[5] + 2
                    rowNums[5] = rowNums[5] + 1
                    # else:
                    #     print("not working")
        h = h + 1

rowList = []
for i in range(6):
    for j in range(rowNums[i]):
        rowList.append(i)

R = baseRepeatedMatrix[rowList,rowList]

n = 4

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

E = R[range(n^2,3*n^2-2*n),range(n^2,3*n^2-2*n)]
F = R[range(n^2),range(n^2)]
G = R[range(n^2,3*n^2-2*n),range(n^2)]

print("E^+ =")
print(E.pseudoinverse())
print("")
print("H = I - E E^+ = ")
print(identity_matrix(2*n^2-2*n) - E * E.pseudoinverse())
print("")
print("(I - E E^+)G = ")
print((identity_matrix(2*n^2-2*n) - E * E.pseudoinverse())*G)
print("")
print("F - G^t E^+ G =")
print(F - G.transpose() * E.pseudoinverse() * G)

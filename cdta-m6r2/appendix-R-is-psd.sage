load("base-cdta.sage")

n = 4

zVecs, zIndex, R = makezVecsandR(n)

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

load("base-bmv.sage")


m = 6 # Power to raise 
n = 6 # Matrix size 
r = 2 # t^r 
 
# Define our matrices 
M = MatrixSpace(MyRing, n); 
A = M(); 
B = M(); 
 
 
 
for i in range(1,n+1): 
    for j in range (1,n+1): 
        A[i-1,j-1] = avar(i,j) 
        B[i-1,j-1] = bvar(i,j) 
 
print("matrices have been created") 
# Set up the polynomial that we will examine in this sage file 
C = A + t*B 
print("C has been created") 
bmvpolynomial = (C^m).trace(); 
print("Trace computed") 
p = bmvpolynomial.coefficient(t^r) 
print("p created") 

makeY = True
load("appendix-uniqueMatrix.sage")
print("uniqueMatrix:")
print(U)
load("appendix-repeatedMatrix.sage")
print("repeatedMatrix:")
print(R)
# print("reached")
yUy = vector(y)*U*vector(y)

sumOfzRz = 0
for i in range(len(zVecs)):
    sumOfzRz += vector(zVecs[i])*R*vector(zVecs[i])


print("p - yUy - sumOfzRz = " + str(p - yUy - sumOfzRz))


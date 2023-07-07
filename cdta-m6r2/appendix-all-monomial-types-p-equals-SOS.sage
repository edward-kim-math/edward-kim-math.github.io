# load("../Google\ Drive/My\ Drive/BMV-Sage-NG/base-bmv.sage")
load("../base-bmv/base-bmv.sage")
load("../base-bmv/Necklace.sage")

m = 6 # Power to raise
n = 6 # Matrix size
r = 2 # t^r

load_saved = True
saved_monomialtypes_filename = "saved_monomialtypes-n6.sobj"
# How verbose should the on-screen output be?
verbose_monomial_type = True
verbose_monomial = False
verbose_entries = False
verbose_matrix = True

# Define our matrices
M = MatrixSpace(MyRing, n);
A = M();
B = M();

for i in range(1,n+1):
    for j in range (1,n+1):
        A[i-1,j-1] = avar(i,j)
        B[i-1,j-1] = bvar(i,j)

Rcopynumbertolatex = []

Rintegertoindex = []
for j in range(2,n+1):
    for i in range(1,j):
        Rintegertoindex.append([])

baseRepeatedMatrix = matrix(ZZ, [[30, 21, 21, 12, 9, 9], [21, 18, 12, 9, 3, 9], [21, 12, 18, 9, 9, 3], [12, 9, 9, 6, 3, 3], [9, 3, 9, 3, 6, 0], [9, 9, 3, 3, 0, 6]])

zVecs = [[] for i in range(binomial(n,2))]

h = 0

rowNums = [0 for i in range(6)]

for j in range (2,n+1):
    for i in range (1, j):
        Rcopynumbertolatex.append(latex((i,j)))

        # section 1
        zVecs[h].append(avar(i,j)^2*bvar(i,j))
        Rintegertoindex[h].append(vector([1]))
        rowNums[0] = 1

        # section 2
        zVecs[h].append(avar(i,i)*avar(i,j)*bvar(i,i))
        Rintegertoindex[h].append(vector([2,1]))
        rowNums[1] = 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(i,j)*avar(i,k)*bvar(i,k))
                Rintegertoindex[h].append(vector([2,2,k]))
                rowNums[1] = rowNums[1] + 1

        # section 3
        #zVecs[h].append(avar(i,j)*avar(j,j)*bvar(j,j))
        #Rintegertoindex[h].append(vector([3,j]))
        rowNums[2] = 0
        for k in range (1,n+1):
            if k != i: # and k != j:
                zVecs[h].append(avar(i,j)*avar(j,k)*bvar(j,k))
                Rintegertoindex[h].append(vector([3,k]))
                rowNums[2] = rowNums[2] + 1

        # section 4
        zVecs[h].append(avar(i,i)*avar(j,j)*bvar(i,j))
        Rintegertoindex[h].append(vector([4,1]))
        rowNums[3] = 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(i,i)*avar(j,k)*bvar(i,k))
                Rintegertoindex[h].append(vector([4,2,k]))
                rowNums[3] = rowNums[3] + 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(i,k)*avar(j,j)*bvar(j,k))
                Rintegertoindex[h].append(vector([4,3,k]))
                rowNums[3] = rowNums[3] + 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(i,k)*avar(j,k)*bvar(k,k))
                Rintegertoindex[h].append(vector([4,4,k]))
                rowNums[3] = rowNums[3] + 1
        for k in range (1,n+1):
            for l in range (1,n+1):
                if l != i and l != j and l != k and k != i and k != j:
                    zVecs[h].append(avar(i,k)*avar(j,l)*bvar(k,l))
                    Rintegertoindex[h].append(vector([4,5,k,l]))
                    rowNums[3] = rowNums[3] + 1

        # section 5
        zVecs[h].append(avar(i,i)*avar(i,i)*bvar(i,j))
        Rintegertoindex[h].append(vector([5,1]))
        zVecs[h].append(avar(i,i)*avar(i,j)*bvar(j,j))
        Rintegertoindex[h].append(vector([5,2]))
        rowNums[4] = 2
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(i,i)*avar(i,k)*bvar(k,j))
                Rintegertoindex[h].append(vector([5,3,k]))
                rowNums[4] = rowNums[4] + 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(i,k)*avar(i,k)*bvar(i,j))
                Rintegertoindex[h].append(vector([5,4,k]))
                rowNums[4] = rowNums[4] + 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(i,k)*avar(j,k)*bvar(j,j))
                Rintegertoindex[h].append(vector([5,5,k]))
                rowNums[4] = rowNums[4] + 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(i,k)*avar(k,k)*bvar(j,k))
                Rintegertoindex[h].append(vector([5,6,k]))
                rowNums[4]= rowNums[4] + 1
        for k in range (1,n+1):
            for l in range (1,n+1):
                if l != i and l != j and l != k and k != l and k != j:
                    if avar(i,k)*avar(k,l)*bvar(j,l) not in zVecs[h]: # and avar(i,l)*avar(k,l)*bvar(j,k) not in zVecs[h]:
                        zVecs[h].append(avar(i,k)*avar(k,l)*bvar(j,l))
                        Rintegertoindex[h].append(vector([5,7,k,l]))
                        # zVecs[h].append(avar(i,l)*avar(k,l)*bvar(j,k))
                        # print("jnrfk")
                    # rowNums[4] = rowNums[4] + 2
                        rowNums[4] = rowNums[4] + 1
                    # else:
                        # print(avar(i,k)*avar(k,l)*bvar(j,l), avar(i,l)*avar(k,l)*bvar(j,k))

        # section 6
        zVecs[h].append(avar(j,j)*avar(i,j)*bvar(i,i))
        Rintegertoindex[h].append(vector([6,1]))
        zVecs[h].append(avar(j,j)*avar(j,j)*bvar(i,j))
        Rintegertoindex[h].append(vector([6,2]))
        rowNums[5] = 2
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(j,j)*avar(k,j)*bvar(i,k))
                Rintegertoindex[h].append(vector([6,3,k]))
                rowNums[5] = rowNums[5] + 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(j,k)*avar(i,k)*bvar(i,i))
                Rintegertoindex[h].append(vector([6,4,k]))
                rowNums[5] = rowNums[5] + 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(j,k)*avar(j,k)*bvar(i,j))
                Rintegertoindex[h].append(vector([6,5,k]))
                rowNums[5] = rowNums[5] + 1
        for k in range (1,n+1):
            if k != i and k != j:
                zVecs[h].append(avar(j,k)*avar(k,k)*bvar(i,k))
                Rintegertoindex[h].append(vector([6,6,k]))
                rowNums[5] = rowNums[5] + 1
        for k in range (1,n+1):
            for l in range (1,n+1):
                if l != i and l != j and l != k and k != i and k != j:
                    if avar(j,k)*avar(k,l)*bvar(i,l) not in zVecs[h]: # and avar(j,l)*avar(k,l)*bvar(i,k) not in zVecs[h]:
                        zVecs[h].append(avar(j,k)*avar(k,l)*bvar(i,l))
                        Rintegertoindex[h].append(vector([6,7,k,l]))
                        # zVecs[h].append(avar(j,l)*avar(k,l)*bvar(i,k))
                    # rowNums[5] = rowNums[5] + 2
                        rowNums[5] = rowNums[5] + 1
                    else:
                        print("not working")
        h = h + 1

rowList = []
for i in range(6):
    for j in range(rowNums[i]):
        rowList.append(i)

repeatedMatrix = baseRepeatedMatrix[rowList,rowList]








# row = []
# for i in range(0,6):
#     row.append(0)
#
# for j in range (2,n+1):
#     for i in range (1, j):
#         Rcopynumbertolatex.append(latex((i,j)))
#
#         blockVecs[h].append(avar(i,j)^2*bvar(i,j))
#         Rintegertoindex[h].append(vector([1]))
#         row[0] = row[0] + 1
#
#         #21's
#         blockVecs[h].append(avar(i,i)*avar(i,j)*bvar(i,i))
#         Rintegertoindex[h].append(vector([2,1]))
#
#         row[1] = row[1]+ 1
#         for k in range (1,n+1):
#             if k != i and k != j:
#                 blockVecs[h].append(avar(i,j)*avar(i,k)*bvar(i,k))
#                 Rintegertoindex[h].append(vector([2,2,k]))
#                 row[1] = row[1] + 1
#         #blockVecs[h].append(avar(i,j)*avar(j,j)*bvar(j,j))
#         #Rintegertoindex[h].append(vector([0]))
#         #row[2] = row[2] + 1
#         for k in range (1,n+1):
#             if k != i: #and k != j:
#                 blockVecs[h].append(avar(i,j)*avar(j,k)*bvar(j,k))
#                 Rintegertoindex[h].append(vector([3,k]))
#                 row[2] = row[2] + 1
#
#         #12's
#         blockVecs[h].append(avar(i,i)*avar(j,j)*bvar(i,j))
#         Rintegertoindex[h].append(vector([4,1]))
#         row[3] = row[3] + 1
#         for k in range (1,n+1):
#             if k != i and k != j:
#                 blockVecs[h].append(avar(i,i)*avar(j,k)*bvar(i,k))
#                 Rintegertoindex[h].append(vector([4,2,k]))
#                 row[3] = row[3] + 1
#         for k in range (1,n+1):
#             if k != i and k != j:
#                 blockVecs[h].append(avar(i,k)*avar(j,j)*bvar(j,k))
#                 Rintegertoindex[h].append(vector([4,3,k]))
#                 row[3] = row[3] + 1
#         for k in range (1,n+1):
#             if k != i and k != j:
#                 blockVecs[h].append(avar(i,k)*avar(j,k)*bvar(k,k))
#                 Rintegertoindex[h].append(vector([4,4,k]))
#                 row[3] = row[3] + 1
#         for k in range (1,n+1):
#             for l in range (1,n+1):
#                 if l != i and l != j and l!=k:
#                     if avar(i,k)*avar(j,l)*bvar(k,l) not in blockVecs[h] and avar(j,k)*avar(i,l)*bvar(k,l) not in blockVecs[h]:
#                         blockVecs[h].append(avar(i,k)*avar(j,l)*bvar(k,l))
#                         Rintegertoindex[h].append(vector([4,5,1,k,l]))
#                         blockVecs[h].append(avar(j,k)*avar(i,l)*bvar(k,l))
#                         Rintegertoindex[h].append(vector([4,5,2,k,l]))
#                         row[3] = row[3] + 2
#
#         blockVecs[h].append(avar(i,i)*avar(i,i)*bvar(i,j))
#         Rintegertoindex[h].append(vector([5,1]))
#         blockVecs[h].append(avar(i,i)*avar(i,j)*bvar(j,j))
#         Rintegertoindex[h].append(vector([5,1]))
#         row[4] = row[4] + 2
#         for k in range (1,n+1):
#             if k != i and k != j:
#                 blockVecs[h].append(avar(i,i)*avar(i,k)*bvar(k,j))
#                 Rintegertoindex[h].append(vector([5,3,k]))
#                 row[4] = row[4] + 1
#         for k in range (1,n+1):
#             if k != i and k != j:
#                 blockVecs[h].append(avar(i,k)*avar(i,k)*bvar(i,j))
#                 Rintegertoindex[h].append(vector([5,4,k]))
#                 row[4] = row[4] + 1
#         for k in range (1,n+1):
#             if k != i and k != j:
#                 blockVecs[h].append(avar(i,k)*avar(j,k)*bvar(j,j))
#                 Rintegertoindex[h].append(vector([5,5,k]))
#                 row[4] = row[4] + 1
#         for k in range (1,n+1):
#             if k != i and k != j:
#                 blockVecs[h].append(avar(i,k)*avar(k,k)*bvar(j,k))
#                 Rintegertoindex[h].append(vector([5,6,k]))
#                 row[4]= row[4] + 1
#         for k in range (1,n+1):
#             for l in range (1,n+1):
#                 if l != i and l != j and l!=k:
#                     if avar(i,k)*avar(k,l)*bvar(j,l) not in blockVecs[h] and avar(i,l)*avar(k,l)*bvar(j,k) not in blockVecs[h]:
#                         blockVecs[h].append(avar(i,k)*avar(k,l)*bvar(j,l))
#                         Rintegertoindex[h].append(vector([5,7,1,k,l]))
#                         blockVecs[h].append(avar(i,l)*avar(k,l)*bvar(j,k))
#                         Rintegertoindex[h].append(vector([5,7,2,k,l]))
#                         row[4] = row[4] + 2
#
#         blockVecs[h].append(avar(j,j)*avar(i,j)*bvar(i,i))
#         Rintegertoindex[h].append(vector([6,1]))
#         blockVecs[h].append(avar(j,j)*avar(j,j)*bvar(i,j))
#         Rintegertoindex[h].append(vector([6,1]))
#         row[5] = row[5] + 2
#         for k in range (1,n+1):
#             if k != i and k != j:
#                 blockVecs[h].append(avar(j,j)*avar(k,j)*bvar(i,k))
#                 Rintegertoindex[h].append(vector([6,3,k]))
#                 row[5] = row[5] + 1
#         for k in range (1,n+1):
#             if k != i and k != j:
#                 blockVecs[h].append(avar(j,k)*avar(i,k)*bvar(i,i))
#                 Rintegertoindex[h].append(vector([6,4,k]))
#                 row[5] = row[5] + 1
#         for k in range (1,n+1):
#             if k != i and k != j:
#                 blockVecs[h].append(avar(j,k)*avar(j,k)*bvar(i,j))
#                 Rintegertoindex[h].append(vector([6,5,k]))
#                 row[5] = row[5] + 1
#         for k in range (1,n+1):
#             if k != i and k != j:
#                 blockVecs[h].append(avar(j,k)*avar(k,k)*bvar(i,k))
#                 Rintegertoindex[h].append(vector([6,6,k]))
#                 row[5] = row[5] + 1
#         for k in range (1,n+1):
#             for l in range (1,n+1):
#                 if l != i and l != j and l!=k:
#                     if avar(j,k)*avar(k,l)*bvar(i,l) not in blockVecs[h] and avar(j,l)*avar(k,l)*bvar(i,k) not in blockVecs[h]:
#                         blockVecs[h].append(avar(j,k)*avar(k,l)*bvar(i,l))
#                         Rintegertoindex[h].append(vector([6,7,1,k,l]))
#                         blockVecs[h].append(avar(j,l)*avar(k,l)*bvar(i,k))
#                         Rintegertoindex[h].append(vector([6,7,2,k,l]))
#                         row[5] = row[5] + 2
#         h = h + 1
#
# blockMatrixlist = []
# for i in range(0,6):
#     for j in range(0,int(row[i]/int(factorial(n)/(factorial(2)*factorial(n-2))))):
#         blockMatrixlist.append(i)
#
# blockMatrix = baseblockMatrix[blockMatrixlist,blockMatrixlist]

automateuniquevec = []

Uintegertolatexindex = []
testlist1 = []
testlist2 = []
testlist3 = []
for i in range(1,n+1):
    for j in range(i+1,n+1):
        for k in range(j+1,n+1):
            automateuniquevec.append(avar(j,i)*avar(j,k)*bvar(i,k))
            automateuniquevec.append(avar(j,i)*avar(i,k)*bvar(j,k))
            automateuniquevec.append(avar(i,k)*avar(j,k)*bvar(j,i))
            testlist1.append(((i,j,k),j))
            testlist1.append(((i,j,k),i))
            testlist1.append(((i,j,k),k))
            Uintegertolatexindex.append(latex((Set([i,j,k]),j)))
            Uintegertolatexindex.append(latex((Set([i,j,k]),i)))
            Uintegertolatexindex.append(latex((Set([i,j,k]),k)))

for i in range(1,n+1):
    for j in range(1,n+1):
        if i != j:
            automateuniquevec.append(avar(j,i)*avar(i,i)*bvar(i,j))
            testlist2.append((i,j))
            Uintegertolatexindex.append(latex((i,j)))

#last 16
for i in range(1,n+1):
    for j in range(1,n+1):
        automateuniquevec.append(avar(j,i)*avar(j,i)*bvar(i,i))
        testlist3.append((i,j))
        Uintegertolatexindex.append("(\\hat{" + str(i) + "}, \\hat{" + str(j) + "})")

U = matrix(ZZ,len(testlist1)+len(testlist2)+len(testlist3),len(testlist1)+len(testlist2)+len(testlist3));

S1 = MatrixSpace(MyRing, len(testlist1))
section1Matrix = S1();
for i in range(0,len(testlist1)):
	for j in range(0,len(testlist1)):
		section1Matrix[i,j] = 0

for i in range(0,len(testlist1)):
	for j in range(0,len(testlist1)):
		comparelist = []
		numberofdup = 0
		for k in range(0,3):
			if testlist1[i][0][k] in testlist1[j][0] and testlist1[i][0][k] not in comparelist:
				comparelist.append(testlist1[i][0][k])

			if testlist1[j][0][k] in testlist1[i][0] and testlist1[j][0][k] not in comparelist:
				comparelist.append(testlist1[j][0][k])

		numberofdup = len(comparelist)

		if numberofdup == 0:
			section1Matrix[i,j] = 0

		elif numberofdup == 1:
			if testlist1[i][1] in testlist1[j][0] and testlist1[j][1] in testlist1[i][0]:
				section1Matrix[i,j] = 12
			elif testlist1[i][1] not in testlist1[j][0] and testlist1[j][1] in testlist1[i][0]:
				section1Matrix[i,j] = 6
			elif testlist1[i][1] in testlist1[j][0] and testlist1[j][1] not in testlist1[i][0]:
				section1Matrix[i,j] = 6
			elif testlist1[i][1] not in testlist1[j][0] and testlist1[j][1] not in testlist1[i][0]:
				section1Matrix[i,j] = 6

		elif numberofdup == 2:
			if testlist1[i][1] in testlist1[j][0] and testlist1[j][1] in testlist1[i][0]:
				if testlist1[i][1] == testlist1[j][1]:
					section1Matrix[i,j] = 18
				elif testlist1[i][1] != testlist1[j][1]:
					section1Matrix[i,j] = 12
			elif testlist1[i][1] not in testlist1[j][0] and testlist1[j][1] in testlist1[i][0]:
				section1Matrix[i,j] = 12
			elif testlist1[i][1] in testlist1[j][0] and testlist1[j][1] not in testlist1[i][0]:
				section1Matrix[i,j] = 12
			elif testlist1[i][1] not in testlist1[j][0] and testlist1[j][1] not in testlist1[i][0]:
				section1Matrix[i,j] = 12

		elif numberofdup == 3:
			if testlist1[i][1] == testlist1[j][1]:
				section1Matrix[i,j] = 24
			elif testlist1[i][1] != testlist1[j][1]:
				section1Matrix[i,j] = 18

		U[i,j] = section1Matrix[i,j]


S2 = MatrixSpace(MyRing, len(testlist2))
section2Matrix = S2();
for i in range(0,len(testlist2)):
    for j in range(0,len(testlist2)):
        section2Matrix[i,j] = 0

for i in range(len(testlist2)):
    for j in range(len(testlist2)):
        if testlist2[i][0] == testlist2[j][0]:
            if testlist2[i][1] == testlist2[j][1]:
                section2Matrix[i,j] = 36 #if i == i', j == j'
            elif testlist2[i][1] != testlist2[j][1]:
                section2Matrix[i,j] =  30 #if i == i', j != j'
        elif testlist2[i][0] != testlist2[j][0]:
            if testlist2[i][0] == testlist2[j][1]:
                if testlist2[i][1] == testlist2[j][0]:
                    section2Matrix[i,j] = 24 #if i != j, i == j', j == i'
                elif testlist2[i][1] != testlist2[j][0]:
                    section2Matrix[i,j] = 12 #if i != j, i == j', j != i'
                    # section2Matrix[j,i] = 100 ### LOOK INTO CONDITIONS
            elif testlist2[i][0] != testlist2[j][1]:
                if testlist2[i][1] == testlist2[j][1]:
                    section2Matrix[i,j] =  6 #if i != j, j == j'

        U[i + len(testlist1), j + len(testlist1)] = section2Matrix[i,j]
        U[j + len(testlist1), i + len(testlist1)] = U[i + len(testlist1), j + len(testlist1)]

XRing.<x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27>=QQ[];

MX = MatrixSpace(XRing, len(testlist3))
section3Matrix = MX()
for i in range(0,len(testlist3)):
	for j in range(0,len(testlist3)):
		section3Matrix[i,j] = 0


for i in range(len(testlist3)):
	for j in range(len(testlist3)):
		if testlist3[i][0] == testlist3[j][0]:
			if testlist3[i][0] == testlist3[i][1]:
				if testlist3[i][1] == testlist3[j][1]:
					section3Matrix[i,j] = 15 #if i == i', i == j, j == j'
				else:
					section3Matrix[i,j] = 9 #if i == i', i == j, j != j'
					section3Matrix[j,i] = 9
			elif testlist3[i][1] == testlist3[j][1]:
				section3Matrix[i,j] = 9 #if i == i', j == j', i != j
			elif testlist3[i][0] == testlist3[j][1]:
				section3Matrix[i,j] = 9 #if i == i', i == j'
			else:
				section3Matrix[i,j] = 6 #if i == i', i != j, j != j', i != j'

		elif testlist3[i][0] != testlist3[j][0]:
			if testlist3[i][0] == testlist3[j][1] and testlist3[i][1] == testlist3[j][1]:
				section3Matrix[i,j] = 6 #if i != j, i == j', j == j'
			elif testlist3[i][1] == testlist3[j][1] and testlist3[j][0] == testlist3[i][1]:
				section3Matrix[i,j] = 6 #if i != j, i' = j', j == j'
			elif testlist3[i][0] == testlist3[j][1] and testlist3[j][0] == testlist3[i][1]:
				section3Matrix[i,j] = 6 #if i != j, i' = j', i == j'
			elif testlist3[i][0] == testlist3[j][1]:
				section3Matrix[i,j] = 3 #if i != j, i == j', j != j'
			elif testlist3[i][1] == testlist3[j][1]:
				section3Matrix[i,j] = 3 #if i != j, j = j', i' != j'
			elif testlist3[j][0] == testlist3[i][1]:
				section3Matrix[i,j] = 3 #if i != j, i' == j, i != j'
			else:
				section3Matrix[i,j] = 0 #if i != j, i != j', j != j', i' != j

		U[i + len(testlist1) + len(testlist2), j + len(testlist1) + len(testlist2)] = section3Matrix[i,j]


S23Matrix = matrix(ZZ, len(testlist3), len(testlist2));
# for i in range(0,len(testlist1)):
# 	for j in range(0,len(testlist1)):
# 		S23Matrix[i,j] = 0


for i in range(len(testlist3)):
	for j in range(len(testlist2)):
		if testlist3[i][0] == testlist2[j][0] and testlist3[i][1] == testlist2[j][1]:
			S23Matrix[i,j] = 15
		elif testlist3[i][0] == testlist2[j][0] and testlist3[i][1] == testlist2[j][0]:
			S23Matrix[i,j] = 21
		elif testlist3[i][0] == testlist2[j][0] and testlist2[j][1] != testlist2[j][0] and testlist3[i][0] != testlist2[j][1] and testlist3[i][1] != testlist2[j][0]:
			S23Matrix[i,j] = 12
		elif testlist3[i][0] == testlist2[j][1] and testlist3[i][1] == testlist2[j][0]:
			S23Matrix[i,j] = 15
		elif testlist3[i][1] == testlist2[j][0] and testlist3[i][0] != testlist2[j][1] and testlist3[i][0] != testlist2[j][0]:
			S23Matrix[i,j] = 9
		elif testlist3[i][0] == testlist3[i][1] and testlist3[i][0] == testlist2[j][1]:
			S23Matrix[i,j] = 9
		elif testlist3[i][0] == testlist2[j][1] and testlist3[i][1] != testlist2[j][0] and testlist3[i][1] != testlist2[j][1]:
			S23Matrix[i,j] = 6
		elif testlist3[i][1] == testlist2[j][1] and testlist3[i][0] != testlist3[i][1]:
			S23Matrix[i,j] = 3
		else:
			S23Matrix[i,j] = 0

		U[i + len(testlist1) + len(testlist2), j + len(testlist1)] = S23Matrix[i,j]
		U[j + len(testlist1), i + len(testlist1) + len(testlist2)] = U[i + len(testlist1) + len(testlist2), j + len(testlist1)]


S13Matrix = matrix(ZZ, len(testlist3), len(testlist1));

for i in range(len(testlist3)):
	for j in range(len(testlist1)):
		if testlist3[i][0] in testlist1[j][0]:
			S13Matrix[i,j] = S13Matrix[i,j] + 6
		if testlist3[i][1] in testlist1[j][0]:
			S13Matrix[i,j] = S13Matrix[i,j] + 3
		if testlist3[i][1] == testlist1[j][1]:
			S13Matrix[i,j] = S13Matrix[i,j] + 3

		U[i + len(testlist1) + len(testlist2), j] = S13Matrix[i,j]
		U[j, i + len(testlist1) + len(testlist2)] = U[i + len(testlist1) + len(testlist2), j]


S12Matrix = matrix(ZZ, len(testlist2), len(testlist1));

for i in range(len(testlist2)):
	for j in range(len(testlist1)):
		if testlist2[i][0] in testlist1[j][0]:
			S12Matrix[i,j] = S12Matrix[i,j] + 12
		if testlist2[i][1] in testlist1[j][0]:
			S12Matrix[i,j] = S12Matrix[i,j] + 6
		if testlist2[i][0] == testlist1[j][1]:
			S12Matrix[i,j] = S12Matrix[i,j] + 6

		U[i + len(testlist1), j] = S12Matrix[i,j]
		U[j, i + len(testlist1)] = U[i + len(testlist1), j]




def myQ(n):
    m = 6 # Power to raise
    #n = 4 # Matrix size
    r = 2 # t^r

    # Define our matrices
    M = MatrixSpace(MyRing, n);
    A = M();
    B = M();

    automateuniquevec = []

    testlist1 = []
    testlist2 = []
    testlist3 = []
    for i in range(1,n+1):
        for j in range(i+1,n+1):
            for k in range(j+1,n+1):
                #automateuniquevec.append(avar(j,i)*avar(j,k)*bvar(i,k))
                #automateuniquevec.append(avar(j,i)*avar(i,k)*bvar(j,k))
                #automateuniquevec.append(avar(i,k)*avar(j,k)*bvar(j,i))
                testlist1.append(((i,j,k),j))
                testlist1.append(((i,j,k),i))
                testlist1.append(((i,j,k),k))

    for i in range(1,n+1):
        for j in range(1,n+1):
            if i != j:
                #automateuniquevec.append(avar(j,i)*avar(i,i)*bvar(i,j))
                testlist2.append((i,j))

    #last 16
    for i in range(1,n+1):
        for j in range(1,n+1):
            #automateuniquevec.append(avar(j,i)*avar(j,i)*bvar(i,i))
            testlist3.append((i,j))

    automatedUniqueMatrix = matrix(ZZ,len(testlist1)+len(testlist2)+len(testlist3),len(testlist1)+len(testlist2)+len(testlist3));

    S1 = MatrixSpace(MyRing, len(testlist1))
    section1Matrix = S1();
    for i in range(0,len(testlist1)):
    	for j in range(0,len(testlist1)):
    		section1Matrix[i,j] = 0

    for i in range(0,len(testlist1)):
    	for j in range(0,len(testlist1)):
    		comparelist = []
    		numberofdup = 0
    		for k in range(0,3):
    			if testlist1[i][0][k] in testlist1[j][0] and testlist1[i][0][k] not in comparelist:
    				comparelist.append(testlist1[i][0][k])

    			if testlist1[j][0][k] in testlist1[i][0] and testlist1[j][0][k] not in comparelist:
    				comparelist.append(testlist1[j][0][k])

    		numberofdup = len(comparelist)

    		if numberofdup == 0:
    			section1Matrix[i,j] = 0

    		elif numberofdup == 1:
    			if testlist1[i][1] in testlist1[j][0] and testlist1[j][1] in testlist1[i][0]:
    				section1Matrix[i,j] = 12
    			elif testlist1[i][1] not in testlist1[j][0] and testlist1[j][1] in testlist1[i][0]:
    				section1Matrix[i,j] = 6
    			elif testlist1[i][1] in testlist1[j][0] and testlist1[j][1] not in testlist1[i][0]:
    				section1Matrix[i,j] = 6
    			elif testlist1[i][1] not in testlist1[j][0] and testlist1[j][1] not in testlist1[i][0]:
    				section1Matrix[i,j] = 6

    		elif numberofdup == 2:
    			if testlist1[i][1] in testlist1[j][0] and testlist1[j][1] in testlist1[i][0]:
    				if testlist1[i][1] == testlist1[j][1]:
    					section1Matrix[i,j] = 18
    				elif testlist1[i][1] != testlist1[j][1]:
    					section1Matrix[i,j] = 12
    			elif testlist1[i][1] not in testlist1[j][0] and testlist1[j][1] in testlist1[i][0]:
    				section1Matrix[i,j] = 12
    			elif testlist1[i][1] in testlist1[j][0] and testlist1[j][1] not in testlist1[i][0]:
    				section1Matrix[i,j] = 12
    			elif testlist1[i][1] not in testlist1[j][0] and testlist1[j][1] not in testlist1[i][0]:
    				section1Matrix[i,j] = 12

    		elif numberofdup == 3:
    			if testlist1[i][1] == testlist1[j][1]:
    				section1Matrix[i,j] = 24
    			elif testlist1[i][1] != testlist1[j][1]:
    				section1Matrix[i,j] = 18

    		automatedUniqueMatrix[i,j] = section1Matrix[i,j]
    		#print(testlist1[i],testlist1[j], section1Matrix[i,j])

    S2 = MatrixSpace(MyRing, len(testlist2))
    section2Matrix = S2();
    for i in range(0,len(testlist2)):
        for j in range(0,len(testlist2)):
            section2Matrix[i,j] = 0

    for i in range(len(testlist2)):
        for j in range(len(testlist2)):
            if testlist2[i][0] == testlist2[j][0]:
                if testlist2[i][1] == testlist2[j][1]:
                    section2Matrix[i,j] = 36 #if i == i', j == j'
                elif testlist2[i][1] != testlist2[j][1]:
                    section2Matrix[i,j] =  30 #if i == i', j != j'
            elif testlist2[i][0] != testlist2[j][0]:
                if testlist2[i][0] == testlist2[j][1]:
                    if testlist2[i][1] == testlist2[j][0]:
                        section2Matrix[i,j] = 24 #if i != j, i == j', j == i'
                    elif testlist2[i][1] != testlist2[j][0]:
                        section2Matrix[i,j] = 12 #if i != j, i == j', j != i'
                        section2Matrix[j,i] = 12 ### LOOK INTO CONDITIONS
                elif testlist2[i][0] != testlist2[j][1]:
                    if testlist2[i][1] == testlist2[j][1]:
                        section2Matrix[i,j] =  6 #if i != j, j == j'

            automatedUniqueMatrix[i + len(testlist1), j + len(testlist1)] = section2Matrix[i,j]
            automatedUniqueMatrix[j + len(testlist1), i + len(testlist1)] = automatedUniqueMatrix[i + len(testlist1), j + len(testlist1)]

    XRing.<x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12>=QQ[]; # XRing.<x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27>=QQ[];

    MX = MatrixSpace(XRing, len(testlist3))
    section3Matrix = MX()
    for i in range(0,len(testlist3)):
    	for j in range(0,len(testlist3)):
    		section3Matrix[i,j] = 0


    for i in range(len(testlist3)):
    	for j in range(len(testlist3)):
    		if testlist3[i][0] == testlist3[j][0]:
    			if testlist3[i][0] == testlist3[i][1]:
    				if testlist3[i][1] == testlist3[j][1]:
    					section3Matrix[i,j] = 15 #if i == i', i == j, j == j'
    				else:
    					section3Matrix[i,j] = 9 #if i == i', i == j, j != j'
    					section3Matrix[j,i] = 9
    			elif testlist3[i][1] == testlist3[j][1]:
    				section3Matrix[i,j] = 9 #if i == i', j == j', i != j
    			elif testlist3[i][0] == testlist3[j][1]:
    				section3Matrix[i,j] = 9 #if i == i', i == j'
    			else:
    				section3Matrix[i,j] = 6 #if i == i', i != j, j != j', i != j'

    		elif testlist3[i][0] != testlist3[j][0]:
    			if testlist3[i][0] == testlist3[j][1] and testlist3[i][1] == testlist3[j][1]:
    				section3Matrix[i,j] = 6 #if i != j, i == j', j == j'
    			elif testlist3[i][1] == testlist3[j][1] and testlist3[j][0] == testlist3[i][1]:
    				section3Matrix[i,j] = 6 #if i != j, i' = j', j == j'
    			elif testlist3[i][0] == testlist3[j][1] and testlist3[j][0] == testlist3[i][1]:
    				section3Matrix[i,j] = 6 #if i != j, i' = j', i == j'
    			elif testlist3[i][0] == testlist3[j][1]:
    				section3Matrix[i,j] = 3 #if i != j, i == j', j != j'
    			elif testlist3[i][1] == testlist3[j][1]:
    				section3Matrix[i,j] = 3 #if i != j, j = j', i' != j'
    			elif testlist3[j][0] == testlist3[i][1]:
    				section3Matrix[i,j] = 3 #if i != j, i' == j, i != j'
    			else:
    				section3Matrix[i,j] = 0 #if i != j, i != j', j != j', i' != j

    		automatedUniqueMatrix[i + len(testlist1) + len(testlist2), j + len(testlist1) + len(testlist2)] = section3Matrix[i,j]


    S23Matrix = matrix(ZZ, len(testlist3), len(testlist2));
    # for i in range(0,len(testlist1)):
    # 	for j in range(0,len(testlist1)):
    # 		S23Matrix[i,j] = 0


    for i in range(len(testlist3)):
    	for j in range(len(testlist2)):
    		if testlist3[i][0] == testlist2[j][0] and testlist3[i][1] == testlist2[j][1]:
    			S23Matrix[i,j] = 15
    		elif testlist3[i][0] == testlist2[j][0] and testlist3[i][1] == testlist2[j][0]:
    			S23Matrix[i,j] = 21
    		elif testlist3[i][0] == testlist2[j][0] and testlist2[j][1] != testlist2[j][0] and testlist3[i][0] != testlist2[j][1] and testlist3[i][1] != testlist2[j][0]:
    			S23Matrix[i,j] = 12
    		elif testlist3[i][0] == testlist2[j][1] and testlist3[i][1] == testlist2[j][0]:
    			S23Matrix[i,j] = 15
    		elif testlist3[i][1] == testlist2[j][0] and testlist3[i][0] != testlist2[j][1] and testlist3[i][0] != testlist2[j][0]:
    			S23Matrix[i,j] = 9
    		elif testlist3[i][0] == testlist3[i][1] and testlist3[i][0] == testlist2[j][1]:
    			S23Matrix[i,j] = 9
    		elif testlist3[i][0] == testlist2[j][1] and testlist3[i][1] != testlist2[j][0] and testlist3[i][1] != testlist2[j][1]:
    			S23Matrix[i,j] = 6
    		elif testlist3[i][1] == testlist2[j][1] and testlist3[i][0] != testlist3[i][1]:
    			S23Matrix[i,j] = 3
    		else:
    			S23Matrix[i,j] = 0

    		automatedUniqueMatrix[i + len(testlist1) + len(testlist2), j + len(testlist1)] = S23Matrix[i,j]
    		automatedUniqueMatrix[j + len(testlist1), i + len(testlist1) + len(testlist2)] = automatedUniqueMatrix[i + len(testlist1) + len(testlist2), j + len(testlist1)]


    S13Matrix = matrix(ZZ, len(testlist3), len(testlist1));
    # for i in range(0,len(testlist3)):
    	# for j in range(0,len(testlist1)):
    	# 	S13Matrix[i,j] = 0

    for i in range(len(testlist3)):
    	for j in range(len(testlist1)):
    		if testlist3[i][0] in testlist1[j][0]:
    			S13Matrix[i,j] = S13Matrix[i,j] + 6
    		if testlist3[i][1] in testlist1[j][0]:
    			S13Matrix[i,j] = S13Matrix[i,j] + 3
    		if testlist3[i][1] == testlist1[j][1]:
    			S13Matrix[i,j] = S13Matrix[i,j] + 3

    		automatedUniqueMatrix[i + len(testlist1) + len(testlist2), j] = S13Matrix[i,j]
    		automatedUniqueMatrix[j, i + len(testlist1) + len(testlist2)] = automatedUniqueMatrix[i + len(testlist1) + len(testlist2), j]


    S12Matrix = matrix(ZZ, len(testlist2), len(testlist1));
    # for i in range(0,len(testlist2)):
    	# for j in range(0,len(testlist1)):
    	# 	S12Matrix[i,j] = 0

    for i in range(len(testlist2)):
    	for j in range(len(testlist1)):
    		if testlist2[i][0] in testlist1[j][0]:
    			S12Matrix[i,j] = S12Matrix[i,j] + 12
    		if testlist2[i][1] in testlist1[j][0]:
    			S12Matrix[i,j] = S12Matrix[i,j] + 6
    		if testlist2[i][0] == testlist1[j][1]:
    			S12Matrix[i,j] = S12Matrix[i,j] + 6

    		automatedUniqueMatrix[i + len(testlist1), j] = S12Matrix[i,j]
    		automatedUniqueMatrix[j, i + len(testlist1)] = automatedUniqueMatrix[i + len(testlist1), j]

    return automatedUniqueMatrix

U = myQ(n)

###########################

# for rownum in range(len(automateuniquevec)):
#     for colnum in range(len(automateuniquevec)):
#         if automateuniquevec[rownum]*automateuniquevec[colnum] == a11*a12*a13*a22*b12*b13:
#             print(rownum, colnum, U[rownum,colnum])
#print(U)

monomialdictionary = {}

for rownum in range(len(automateuniquevec)):
    for colnum in range(len(automateuniquevec)):
        if U[rownum, colnum] != 0:
            currentmonomial = automateuniquevec[rownum]*automateuniquevec[colnum]
            if currentmonomial in monomialdictionary.keys():
                monomialdictionary[currentmonomial].append(["U", rownum, colnum, U[rownum, colnum], automateuniquevec[rownum], automateuniquevec[colnum]])
            else:
                monomialdictionary[currentmonomial] = []
                monomialdictionary[currentmonomial].append(["U",rownum, colnum, U[rownum, colnum], automateuniquevec[rownum], automateuniquevec[colnum]])


for i in range(len(zVecs)):
    for rownum in range(len(zVecs[i])):
        for colnum in range(len(zVecs[i])):
            if repeatedMatrix[rownum, colnum] != 0:
                currentmonomial = zVecs[i][rownum]*zVecs[i][colnum]
                if currentmonomial in monomialdictionary.keys():
                    monomialdictionary[currentmonomial].append(["R", rownum, colnum, repeatedMatrix[rownum, colnum], zVecs[i][rownum], zVecs[i][colnum], i]) # i is which copy, starting at 0
                else :
                    monomialdictionary[currentmonomial] = []
                    monomialdictionary[currentmonomial].append(["R", rownum, colnum, repeatedMatrix[rownum, colnum], zVecs[i][rownum], zVecs[i][colnum], i])

########################

Rs = []
for i in range(len(zVecs)):
    Rs.append(deepcopy(repeatedMatrix))

C = A + t*B
bmvpolynomial = (C^m).trace();
p = bmvpolynomial.coefficient(t^r)

texfile = open("all-monomial-types-p-equals-SOS-n" + str(n) + ".tex", "w")
texfile.write('\\documentclass{article}\n')
texfile.write('\\usepackage[margin=1.0in]{geometry}\n\n')
texfile.write('\\begin{document}\n\n')

texfile.write('\\section{Monomial type representatives}\nThe following is a list of monomial type representatives: ')

if load_saved:
    monomialtypes = load(saved_monomialtypes_filename)
    for monomialtype, monomials in monomialtypes.items():
        texfile.write('$' + latex(monomialtype) + '$,\n')
else:
    monomialtypes = {}
    unprocessed = p.monomials()
    processed = []
    while len(unprocessed) > 0:
        monom1 = unprocessed[0]
        print(str(len(unprocessed)) + " unprocessed monomials. Processing orbit " + str(monom1))
        texfile.write('$' + latex(monom1) + '$,\n')
        monomialtypes[monom1] = []
        vars1 = monom1.variables()

        for g in SymmetricGroup(n):
            newmonom = 1
            for var1 in vars1:
                letter = str(var1)[0]
                findex = int(str(var1)[1])
                sindex = int(str(var1)[2])
                dg = monom1.degree(var1)
                if letter == 'a':
                    newmonom = newmonom * avar(g(findex),g(sindex))^dg
                if letter == 'b':
                    newmonom = newmonom * bvar(g(findex),g(sindex))^dg
            # at this point, newmonom is of the same type as monom1
            if newmonom not in Set(processed):
                monomialtypes[monom1].append(newmonom)
                unprocessed.remove(newmonom)
                processed.append(newmonom)
        # monomialtypes[monom1] = list(Set(monomialtypes[monom1])) # used to "unique"ify
    save(monomialtypes, 'saved_monomialtypes')
    texfile.write('\n\n')

texfile.write('There are ' + str(len(monomialtypes)) + ' monomial types.')
texfile.write('\n\n')
#print("Monomial type representatives:")
#print(monomialtyperepresentatives)
# latex(monomialtyperepresentatives)


texfile.write('\\section{Monomials accounted by $U$ and copies of $R$}\n')

for monomialtype, monomials in monomialtypes.items():
    if verbose_monomial_type:
        print('Monomial type ' + str(monomialtype) + ', coefficient ' + str(p.coefficient(monomialtype)))
    texfile.write('\\subsection{Monomial type $' + latex(monomialtype) + '$ with coefficient $' + str(p.coefficient(monomialtype)) + '$}\n\n')

    for monomial in monomials:
        if verbose_monomial:
            print('\tMonomial ' + str(monomial))
        texfile.write('\\subsubsection{Monomial $' + latex(monomial) + '$}\n\n')
        unaccounted = p.coefficient(monomialtype) # reset "unaccounted" for new monomial

        texfile.write('\\begin{itemize}\n')
        #print(str(monomialdictionary[monomial]))
        for matrixentry in monomialdictionary[monomial]:
            if matrixentry[0] == 'U':
                rownum = matrixentry[1]
                colnum = matrixentry[2]
                entryvalue = matrixentry[3]
                monomialvecrow = matrixentry[4]
                monomialveccol = matrixentry[5]
                if verbose_entries:
                    print('\t\t' + str(matrixentry))
                texfile.write('\\item The $' + Uintegertolatexindex[rownum] + '$-row $' + Uintegertolatexindex[colnum] + '$-column entry of $U$ is $' + str(entryvalue) + '$, for $(' + latex(monomialvecrow) + ')(' + latex(monomialveccol) + ')$ \n')
                U[rownum,colnum] -= entryvalue
                unaccounted -= entryvalue
            else:
                rownum = matrixentry[1]
                colnum = matrixentry[2]
                entryvalue = matrixentry[3]
                monomialvecrow = matrixentry[4]
                monomialveccol = matrixentry[5]
                copynum = matrixentry[6]
                if verbose_entries:
                    print('\t\t' + str(matrixentry))
                texfile.write('\\item The $' + str(Rintegertoindex[copynum][rownum]) + '$-row $' + str(Rintegertoindex[copynum][colnum]) + '$-column entry of the $' + Rcopynumbertolatex[copynum] + '$-copy of ' + '$R$ is $' + str(entryvalue) + '$, for $(' + latex(monomialvecrow) + ')(' + latex(monomialveccol) + ')$ \n')
                Rs[copynum][rownum,colnum] -= entryvalue
                unaccounted -= entryvalue
        if unaccounted != 0:
            print('!!!!! Monomial ' + str(monomial) + ' is not properly accounted')
            texfile.write('\\item ERROR! Monomial $' + latex(monomial) + '$ is not accounted for ' + str(unaccounted) + ' times in the matrices!\n')
        texfile.write('\\end{itemize}\n')

texfile.write('\\section{Checking matrix entries were not doubly-used}\n')

if verbose_matrix:
    print("The matrix U should now be zeroed out. Any negative entries indicate double-use of a location in the matrix.")
    print(U)
texfile.write('\\subsection{$U$}\n')
texfile.write('\\[' + latex(U) + '\\]\n')

if verbose_matrix:
    print("Each copy of R should now be zeroed out. Any negative entries indicate double-use.")
for copynum in range(len(Rs)):
    if verbose_matrix:
        print("Copy number: " + str(copynum))
        print(Rs[copynum])
    texfile.write('\\subsection{The $' + Rcopynumbertolatex[copynum] + '$-copy of $R$}\n')
    texfile.write('\\[' + latex(Rs[copynum]) + '\\]\n')

texfile.write('\\end{document}\n\n')

texfile.close()

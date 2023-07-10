load("base-cdta.sage")

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

M = MatrixSpace(MyRing, n)
A = M()
B = M()
for i in range(1,n+1):
    for j in range (1,n+1):
        A[i-1,j-1] = avar(i,j)
        B[i-1,j-1] = bvar(i,j)
C = A + t*B
bmvpolynomial = (C^m).trace();
p = bmvpolynomial.coefficient(t^r)

Rcopynumbertolatex = []
for j in range (2,n+1):
    for i in range (1, j):
        Rcopynumbertolatex.append(latex((i,j)))

y, yIndexlatex, U = makeyandU(n)
zVecs, zIndex, R = makezVecsandR(n)
Rs = [deepcopy(R) for i in range(binomial(n,2))] # need copies of R matrix

monomialdictionary = {}
for rownum in range(len(y)):
    for colnum in range(len(y)):
        if U[rownum, colnum] != 0:
            currentmonomial = y[rownum]*y[colnum]
            if currentmonomial in monomialdictionary.keys():
                monomialdictionary[currentmonomial].append(["U", rownum, colnum, U[rownum, colnum], y[rownum], y[colnum]])
            else:
                monomialdictionary[currentmonomial] = []
                monomialdictionary[currentmonomial].append(["U",rownum, colnum, U[rownum, colnum], y[rownum], y[colnum]])
for i in range(len(zVecs)):
    for rownum in range(len(zVecs[i])):
        for colnum in range(len(zVecs[i])):
            if R[rownum, colnum] != 0:
                currentmonomial = zVecs[i][rownum]*zVecs[i][colnum]
                if currentmonomial in monomialdictionary.keys():
                    monomialdictionary[currentmonomial].append(["R", rownum, colnum, R[rownum, colnum], zVecs[i][rownum], zVecs[i][colnum], i]) # i is which copy, starting at 0
                else :
                    monomialdictionary[currentmonomial] = []
                    monomialdictionary[currentmonomial].append(["R", rownum, colnum, R[rownum, colnum], zVecs[i][rownum], zVecs[i][colnum], i])

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
            # At this point, newmonom is of the same type as monom1
            if newmonom not in processed:
                monomialtypes[monom1].append(newmonom)
                unprocessed.remove(newmonom)
                processed.append(newmonom)
    save(monomialtypes, 'saved_monomialtypes') # The sobj file created can be used next time
    texfile.write('\n\n')

texfile.write('There are ' + str(len(monomialtypes)) + ' monomial types.')
texfile.write('\n\n')

texfile.write('\\section{Monomials accounted by $U$ and copies of $R$}\n')

for monomialtype, monomials in monomialtypes.items():
    monomialtype = MyRing(monomialtype)
    if verbose_monomial_type:
        print('Monomial type ' + str(monomialtype) + ', coefficient ' + str(p.coefficient(monomialtype)))
    texfile.write('\\subsection{Monomial type $' + latex(monomialtype) + '$ with coefficient $' + str(p.coefficient(monomialtype)) + '$}\n\n')

    for monomial in monomials:
        if verbose_monomial:
            print('\tMonomial ' + str(monomial))
        texfile.write('\\subsubsection{Monomial $' + latex(monomial) + '$}\n\n')
        unaccounted = p.coefficient(monomialtype) # reset "unaccounted" for new monomial

        texfile.write('\\begin{itemize}\n')
        for matrixentry in monomialdictionary[monomial]:
            if matrixentry[0] == 'U':
                rownum = matrixentry[1]
                colnum = matrixentry[2]
                entryvalue = matrixentry[3]
                monomialvecrow = matrixentry[4]
                monomialveccol = matrixentry[5]
                if verbose_entries:
                    print('\t\t' + str(matrixentry))
                texfile.write('\\item The $' + yIndexlatex[rownum] + '$-row $' + yIndexlatex[colnum] + '$-column entry of $U$ is $' + str(entryvalue) + '$, for $(' + latex(monomialvecrow) + ')(' + latex(monomialveccol) + ')$ \n')
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
                texfile.write('\\item The $' + str(zIndex[copynum][rownum]) + '$-row $' + str(zIndex[copynum][colnum]) + '$-column entry of the $' + Rcopynumbertolatex[copynum] + '$-copy of ' + '$R$ is $' + str(entryvalue) + '$, for $(' + latex(monomialvecrow) + ')(' + latex(monomialveccol) + ')$ \n')
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

load("base-cdta.sage")
load("appendix-min-poly-U-data.sage")
var('x1','x2','x3','x4')

for n in range(6, 13):
    y, yIndexlatex, U = makeyandU(n)
    Upower = matrix.identity(U.nrows())
    for power in range(4):
        Upower = U*Upower
        for index in powersofUvalues:
            powersofUvalues[index][power].append(Upower[getIndexOfU(n,index[0]),getIndexOfU(n,index[1])])

for index in powersofUvalues:
    print("Index: " + str(index))
    print("Entry of U^1 from matrix: " + str(powersofUvalues[index][0][0]))
    print("Entry of U^1 from stored data: " + str(Udata[0][index]))
    print("Lists are Equal = " + str(Udata[0][index] == powersofUvalues[index][0][0]))

    for power in range(2,5):
        print("Entries of U^" + str(power) + " for n from 6 to 12 from matrix: " + str(powersofUvalues[index][power-1]))
        entryList = []
        for n in range(6,13):
            entryList.append(Udata[power-1][index].subs(x=n))
        print("Entries of U^" + str(power) + " for n from 6 to 12 from equation " + str(Udata[power-1][index]) + ": " + str(entryList))
        print("Lists are Equal = " + str(entryList == powersofUvalues[index][power-1]))
    print("======================================")

b = -3*x*(4*x-3) # = -12*x^2 + 9*x
c = 54*(2*binomial(x+2,4)+5*binomial(x+1,4)+binomial(x,4)) # = 18*x^4 - 27*x^3 + 9*x^2
d = 15*x*(2*x-1) # = 30*x^2 - 15*x

f = b-d # = -42*x^2 + 24*x
g = c-b*d # = 378*x^4 - 477*x^3 + 144*x^2
h = -c*d # = -540*x^6 + 1080*x^5 - 675*x^4 + 135*x^3

minpoly = x4 + f*x3 + g*x2 + h*x1

for index in U1data:
    print("Minimum polynomial subsitituiting values at index " + str(index) + " = " + str(minpoly.subs(x4=U4data[index], x3=U3data[index], x2=U2data[index], x1=U1data[index]).expand()))

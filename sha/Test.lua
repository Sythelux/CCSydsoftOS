-------------------------------------------------
---      *** Crypto Test ***                  ---
-------------------------------------------------
--- Author:  Martin Huesser                   ---
--- Date:    2008-06-16                       ---
-------------------------------------------------

dofile("BitLibEmu.lua") --in case you do not have access to BitLib
dofile("Sha1.lua")

s = "The quick brown fox jumps over the lazy dog"
print("Sha1('"..s.."')")
print("Expected: 2fd4e1c67a2d28fced849ee1bb76e7391b93eb12")
print("Result  : "..Sha1(s))

--Generated with RSA.java, use <BigInteger>.toString(16) for hex output.
public  = "10001"
private = "816f0d36f0874f9f2a78acf5643acda3b59b9bcda66775b7720f57d8e9015536160e72"..
"8230ac529a6a3c935774ee0a2d8061ea3b11c63eed69c9f791c1f8f5145cecc722a220d2bc7516b6"..
"d05cbaf38d2ab473a3f07b82ec3fd4d04248d914626d2840b1bd337db3a5195e05828c9abf8de8da"..
"4702a7faa0e54955c3a01bf121"
modulus = "bfedeb9c79e1c6e425472a827baa66c1e89572bbfe91e84da94285ffd4c7972e1b9be3"..
"da762444516bb37573196e4bef082e5a664790a764dd546e0d167bde1856e9ce6b9dc9801e4713e3"..
"c8cb2f12459788a02d2e51ef37121a0f7b086784f0e35e76980403041c3e5e98dfa43ab9e6e85558"..
"c5dc00501b2f2a2959a11db21f"

dofile("BigInt.lua")
m = BigInt_HexToNum("FEEDBEEFBADF00D")
d = BigInt_HexToNum(public)
e = BigInt_HexToNum(private)
n = BigInt_HexToNum(modulus)

print("\nMessage = "..BigInt_NumToHex(m))
print("\nEncrypting... (this will take a few minutes)")
x = BigInt_ModPower(m,e,n)
print("Encrypted Message = "..BigInt_NumToHex(x))
print("\nDecrypting... (very fast)")
y = BigInt_ModPower(x,d,n)
print("Decrypted Message = "..BigInt_NumToHex(y))

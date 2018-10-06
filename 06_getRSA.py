#!/usr/bin/python3
import base64
import re
print('\033[1m\033[95mOpenSSL 512 bit RSA Private Key Breakdown\033[0m\n')
# 512 BIT RSA PRIVATE KEY PEM
f = open('key.pem','r')
text = f.read()
b64re = re.search('-----BEGIN RSA PRIVATE KEY-----(.*?)\*',text,re.DOTALL)

b64text=''
for i in b64re.groups():
	b64text+=i
b64text += '=='
hextext= base64.b64decode(b64text).hex()

#https://etherhack.co.uk/asymmetric/docs/rsa_512.html
RSAparts = re.search('.*0241(.*?)02030100010240(.*?)0221.*',hextext)
modulus = RSAparts.group(1)
privExp = RSAparts.group(2)
print ('\033[93mModulus: \033[94m' + modulus + '\033[0m')
print ('\033[93mPrivateExponent: \033[94m' + privExp + '\n\033[0m')

print('\033[93mCommand: \033[94mpython rsatool.py -f PEM -o k.pem -n ' + str(int(modulus,16)) + '-d ' + str(int(privExp,16)) + '\033[0m\n')

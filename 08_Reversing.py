#!/usr/bin/python
# Reto 8 Cybercamp18 (Online)
import re

SHA1 = [15474416150235697017043280589699178375L,
 291181071307803139498438131966588955205L,
 109873136872180403981887852593133114079L,
 115202235886395046817983293445716821568L,
 242056712403709180973346710358452011247L]

print "https://hashkiller.co.uk/ - Crack these hashes:\n"
for i in SHA1:
	i = str(hex(int(i)))
	r = re.search('0x(.*)L',i)
	r = r.group(1)
	if len(r) < 32:
		r = (32-len(r)) * '0' + r
	print '\033[91m' + r + '\033[0m'

print ""
flag = ''
for i in range(0,5):
	flag += raw_input('\033[0mKey ' + str(i+1) +'--> \033[92m')
	
print "\033[93m\nFlag: \033[1m" + flag + "\033[0m\n"

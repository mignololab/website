#!/usr/bin/env python

import os, glob, re
from urlparse import urlparse

print "Content-type: text/html\n"

print """

<div class="well navigation">
  <ul class="nav nav-list">
    <li class="nav-header">Navigazione</li>

"""

query = os.environ['QUERY_STRING']
params = query.split('&')
data = dict()

for p in params:
  k, v = p.split('=')
  data[k] = v

path = '../tutorials/' + data['tut'] + '/tut*.shtml'

def sort_tut(k):
  return int(re.search('tut(\d+).shtml', k).group(1))

files = sorted(glob.glob(path), key=sort_tut)
for n in files:
    fn = os.path.basename(n)
    i = re.search('tut(\d+).shtml', fn)
    print "<li><a href=\"" + fn + "\">Lezione " + i.group(1) + "</a></li>"

print """
  </ul>
</div>
"""

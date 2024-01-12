import sys
import matplotlib.pyplot as plt
import numpy as np

def atoi(s):
  n = s.split(",")
  l = len(n)
  res = 0
  for i in range(l):
    res += int(n[i])*10**((l-i-1)*3)
  return res

def retrieveData(datas, sourceLines, srcLine):
  res = []
  i = 0
  for reportLines in sourceLines:
    j = 0
    for line in reportLines:
      if line == srcLine: break
      j += 1
    if j == len(reportLines):
      res.append([0 for k in range(12)])
    else:
      res.append(datas[i][j])
    i += 1
  return res

def getMax(datasTemps, rangeMin, rangeMax):
  max = 0
  for i in range(len(datasTemps)-1):
    for j in range(rangeMin, rangeMax):
      if datasTemps[i][j] > max:
        max = datasTemps[i][j]
  for j in range(rangeMin, rangeMax):
    for x in datasTemps[-1][j]:
      if x > max:
        max = x
  return max

dataTemps = []
suffix = sys.argv[1].split('/')[-1][0]
for arg in sys.argv[1:-1]:
  if arg.split('/')[-1][:2] == "HT" or arg.split('/')[-1][:2] == "Ba":
    suffix += "-" + arg.split('/')[-1].split('-')[-1].split('.')[0]
    break
for arg in sys.argv[1:-1]:
  if arg.split('/')[-1][:4] == "pass":
    suffix += "-pass"
    break
    
for i in range(len(sys.argv)-2):
  file = open(sys.argv[i+1])
  skipFirst2 = 0
  datas = dict()
  datas_ht = dict()
  datas_mt = dict()
  datas["name"] = sys.argv[i+1].split('/')[-1].split('.')[0].split('-')[0][:-1]
  if datas["name"] == "": datas["name"] = "Baseline"
  if datas["name"] == "CORO": datas["name"] = "Coroutine"
  if datas["name"] == "Ba": datas["name"] = "Basic prefetching"
  if datas["name"] == "pass":
      if sys.argv[i+1].split('/')[-1].split('.')[0].split('-')[1] == "heuristic":
        datas["name"] = "Pass (heuristic)"
      else:
        datas["name"] = "Pass (annotation)"
  if datas["name"] == "HT":
    datas["name"] = "Helper Thread (Init)"
    datas_ht["name"] = "Helper Thread (HT)"
    datas_mt["name"] = "Helper Thread (MT)"
    datas_mt["L1Stalls"] = 0
    datas_mt["L2Stalls"] = 0
    datas_mt["L3Stalls"] = 0
    datas_mt["L1miss"] = 0
    datas_mt["L1hits"] = 0
    datas_mt["L2miss"] = 0
    datas_mt["L2hits"] = 0
    datas_mt["L3miss"] = 0
    datas_mt["L3hits"] = 0
    datas_ht["L1Stalls"] = 0
    datas_ht["L2Stalls"] = 0
    datas_ht["L3Stalls"] = 0
    datas_ht["L1miss"] = 0
    datas_ht["L1hits"] = 0
    datas_ht["L2miss"] = 0
    datas_ht["L2hits"] = 0
    datas_ht["L3miss"] = 0
    datas_ht["L3hits"] = 0
  if datas['name'] == "Ba3": datas["name"] = "Basic prefetching"
  datas["L1Stalls"] = 0
  datas["L2Stalls"] = 0
  datas["L3Stalls"] = 0
  datas["L1miss"] = 0
  datas["L1hits"] = 0
  datas["L2miss"] = 0
  datas["L2hits"] = 0
  datas["L3miss"] = 0
  datas["L3hits"] = 0
  for line in file:
    if skipFirst2 < 2:
      skipFirst2 += 1
      continue
    splitLine = line.split()
    if datas_ht:
      if splitLine[2].split('_')[0] == "ht":
        if splitLine[2].split('_')[-1] == "init":
          datas["L1Stalls"] += atoi(splitLine[4])
          datas["L2Stalls"] += atoi(splitLine[5])
          datas["L3Stalls"] += atoi(splitLine[6])
          datas["L1hits"] += atoi(splitLine[8])
          datas["L1miss"] += atoi(splitLine[9])
          datas["L2hits"] += atoi(splitLine[10])
          datas["L2miss"] += atoi(splitLine[11])
          datas["L3hits"] += atoi(splitLine[12])
          datas["L3miss"] += atoi(splitLine[13])
        else:
          datas_ht["L1Stalls"] += atoi(splitLine[4])
          datas_ht["L2Stalls"] += atoi(splitLine[5])
          datas_ht["L3Stalls"] += atoi(splitLine[6])
          datas_ht["L1hits"] += atoi(splitLine[8])
          datas_ht["L1miss"] += atoi(splitLine[9])
          datas_ht["L2hits"] += atoi(splitLine[10])
          datas_ht["L2miss"] += atoi(splitLine[11])
          datas_ht["L3hits"] += atoi(splitLine[12])
          datas_ht["L3miss"] += atoi(splitLine[13])
      else:
        datas_mt["L1Stalls"] += atoi(splitLine[4])
        datas_mt["L2Stalls"] += atoi(splitLine[5])
        datas_mt["L3Stalls"] += atoi(splitLine[6])
        datas_mt["L1hits"] += atoi(splitLine[8])
        datas_mt["L1miss"] += atoi(splitLine[9])
        datas_mt["L2hits"] += atoi(splitLine[10])
        datas_mt["L2miss"] += atoi(splitLine[11])
        datas_mt["L3hits"] += atoi(splitLine[12])
        datas_mt["L3miss"] += atoi(splitLine[13])
    else:
      datas["L1Stalls"] += atoi(splitLine[4])
      datas["L2Stalls"] += atoi(splitLine[5])
      datas["L3Stalls"] += atoi(splitLine[6])
      datas["L1hits"] += atoi(splitLine[8])
      datas["L1miss"] += atoi(splitLine[9])
      datas["L2hits"] += atoi(splitLine[10])
      datas["L2miss"] += atoi(splitLine[11])
      datas["L3hits"] += atoi(splitLine[12])
      datas["L3miss"] += atoi(splitLine[13])
  dataTemps.append(datas)
  if (datas_ht):
    dataTemps.append(datas_ht)
    dataTemps.append(datas_mt)

fig = plt.figure(figsize=[10,7])
ax = fig.add_subplot(111)
nbCols = len(dataTemps)
width = 1/(nbCols+1)
rects = []
colors = ['#a6cee3', '#1f78b4', '#b2df8a', '#33a02c', '#fb9a99', '#e31a1c', '#fdbf6f']
hatches = ['/','\\',"|","-","+","x","."]
keys = ["L1Stalls","L2Stalls","L3Stalls","L1hits","L1miss","L2hits","L2miss","L3hits","L3miss"]
index = 0
ht_x = -1
data_ht_init = []
legend = []
for datas in dataTemps:
  if (datas["name"] == "Helper Thread (HT)" or datas["name"] == "Helper Thread (MT)"): continue
  if datas["name"] == "Helper Thread (Init)": 
    data_ht_init = [datas[key] for key in keys[:3]]
    ht_x = width*index
  rects.append(ax.bar(np.array([0,1,2])+width*index, [datas[key] for key in keys[:3]], width, color=colors[index],edgecolor="black",hatch=hatches[index]))
  legend.append(datas["name"])
  index += 1
first = True
for datas in dataTemps:
  if not(datas["name"] == "Helper Thread (HT)" or datas["name"] == "Helper Thread (MT)"): continue
  if first:
    first = False
    rects.append(ax.bar(np.array([0,1,2])+ht_x-width/4, [datas[key] for key in keys[:3]], width/2, bottom=data_ht_init, color=colors[index],edgecolor="black",hatch=hatches[index]))
  else:
    rects.append(ax.bar(np.array([0,1,2])+ht_x+width/4, [datas[key] for key in keys[:3]], width/2, bottom=data_ht_init, color=colors[index],edgecolor="black",hatch=hatches[index]))
  legend.append(datas["name"])
  index += 1

ax.set_xlim(-width,2+nbCols*width)
ax.set_ylim(0,max([max([datas[key] for key in keys[:3]]) for datas in dataTemps]))
ax.set_ylabel("Count", fontsize=14)
xTickMarks = ["L1 stalls", "L2 stalls", "L3 stalls"]
ax.set_xticks([(nbCols-1)*width/2,1+(nbCols-1)*width/2,2+(nbCols-1)*width/2])
xtickNames = ax.set_xticklabels(xTickMarks)
plt.setp(xtickNames, fontsize=14)

ax.legend(tuple([rect[0] for rect in rects]), 
          tuple(legend),
          bbox_to_anchor=(0.5, -0.05), loc='upper center',
          fancybox=True, shadow=True, ncol=3, fontsize=14
         )
plt.tight_layout()
plt.savefig(sys.argv[len(sys.argv)-1] + "stalls-" + suffix + ".pdf")

fig = plt.figure(figsize=[10,7])
ax = fig.add_subplot(111)

rects = []
index = 0
legend = []
ht_x = -1
data_ht_init = []
for datas in dataTemps:
  if (datas["name"] == "Helper Thread (HT)" or datas["name"] == "Helper Thread (MT)"): continue
  if datas["name"] == "Helper Thread (Init)": 
    data_ht_init = [datas[key] for key in keys[3:]]
    ht_x = width*index
  rects.append(ax.bar(np.array([0,1,2,3,4,5])+width*index, [datas[key] for key in keys[3:]], width, color=colors[index],edgecolor="black",hatch=hatches[index]))
  legend.append(datas["name"])
  index += 1
first = True
for datas in dataTemps:
  if not(datas["name"] == "Helper Thread (HT)" or datas["name"] == "Helper Thread (MT)"): continue
  if first:
    rects.append(ax.bar(np.array([0,1,2,3,4,5])+ht_x-width/4, [datas[key] for key in keys[3:]], width/2, bottom=data_ht_init, color=colors[index],edgecolor="black",hatch=hatches[index]))
    first = False
  else:
    rects.append(ax.bar(np.array([0,1,2,3,4,5])+ht_x+width/4, [datas[key] for key in keys[3:]], width/2, bottom=data_ht_init, color=colors[index],edgecolor="black",hatch=hatches[index]))
  legend.append(datas["name"])
  index += 1

ax.set_xlim(-width,5+nbCols*width)
ax.set_ylim(0,max([max([datas[key] for key in keys[3:]]) for datas in dataTemps]))
ax.set_ylabel("Count", fontsize=14)
xTickMarks = ["L1 hits", "L1 miss", "L2 hits", "L2 miss", "L3 hits", "L3 miss"]
ax.set_xticks([(nbCols-1)*width/2,1+(nbCols-1)*width/2,2+(nbCols-1)*width/2,3+(nbCols-1)*width/2,4+(nbCols-1)*width/2,5+(nbCols-1)*width/2])
xtickNames = ax.set_xticklabels(xTickMarks)
plt.setp(xtickNames, fontsize=14)

ax.legend(tuple([rect[0] for rect in rects]), 
          tuple(legend),
          bbox_to_anchor=(0.5, -0.05), loc='upper center',
          fancybox=True, shadow=True, ncol=3, fontsize=14
         )

plt.tight_layout()
plt.savefig(sys.argv[len(sys.argv)-1] + "hit-miss-" + suffix + ".pdf")
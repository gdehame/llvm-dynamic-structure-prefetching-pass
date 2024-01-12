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

def addData(datas, sourceLines, line, lineData):
  for i in range(len(sourceLines)):
    if sourceLines[i] == line:
      datas[i] += lineData
      return
  sourceLines.append(line)
  datas.append(lineData)

def minNonZero(datasTemp, indMin, indMax):
  min = 0
  for i in range(indMin, indMax):
    for data in datasTemp:
      if data[i] != 0 and (min == 0 or data[i] < min):
        min = data[i]
  return min

with open(sys.argv[1]) as report:
  sourceLinesTemp = []
  datasTemp = []
  totalL1stalls = 0
  totalL2stalls = 0
  totalL3stalls = 0
  totalL1miss = 0
  i=0
  for line in report:
    splitLine = line.split()
    if i<2: #head lines
      i += 1
      continue
    lineData = []
    totalL1stalls += atoi(splitLine[4])
    totalL2stalls += atoi(splitLine[5])
    totalL3stalls += atoi(splitLine[6])
    totalL1miss += atoi(splitLine[9])
    lineData.append(atoi(splitLine[4])) #L1 stalls
    lineData.append(atoi(splitLine[5])) #L2 stalls
    lineData.append(atoi(splitLine[6])) #L3 stalls
    lineData.append(atoi(splitLine[8])) #L1 load hit
    lineData.append(atoi(splitLine[9])) #L1 load miss
    lineData.append(atoi(splitLine[10])) #L2 load hit
    lineData.append(atoi(splitLine[11])) #L2 load miss
    lineData.append(atoi(splitLine[12])) #L3 load hit
    lineData.append(atoi(splitLine[13])) #L3 load miss
    lineData = np.array(lineData)
    addData(datasTemp, sourceLinesTemp, splitLine[1], lineData) #combine lines together if they point to the same source line
  
  #Now that we gathered the data, we make computations with it

  datas = []
  sourceLines = []
  i = -1
  reductionFactorHM = 10**(np.floor(np.log10(minNonZero(datasTemp,3,9))))
  reductionFactorStalls = 10**(np.floor(np.log10(minNonZero(datasTemp,0,3))))

  for data in datasTemp:
    i += 1
    if (data[4] == 0 or (data[0] < 0.05*totalL1stalls and data[4] < 0.05*totalL1miss) or data[4]/(data[4]+data[3]) < 0.3): continue #the line isn't impactful enough
    newdata = []
    sourceLines.append(sourceLinesTemp[i])
    if data[3]+data[4] == 0: newdata.append(0) #L1 miss rate
    else: newdata.append(data[4]/(data[3]+data[4]))
    if data[5]+data[6] == 0: newdata.append(0) #L2 miss rate
    else: newdata.append(data[6]/(data[5]+data[6]))
    if data[7]+data[8] == 0: newdata.append(0) #L3 miss rate
    else: newdata.append(data[8]/(data[7]+data[8]))
    for j in range(len(data)):
      #if j < 3:
      #  newdata.append(data[j] / reductionFactorStalls)
      #else:
      #  newdata.append(data[j] / reductionFactorHM)
      newdata.append(data[j])
    datas.append(newdata)

  ind = np.arange(len(sourceLines))                # the x locations for the groups
  width = 0.25                    # the width of the bars
  suffix = sys.argv[1].split("/")[-1][:-4]
  colors = ['#a6cee3', '#1f78b4', '#b2df8a', '#33a02c', '#fb9a99', '#e31a1c', '#fdbf6f']
  hatches = ['/','\\',"|","-","+","x","."]

  """
  fig = plt.figure(figsize=[10,7])
  ax = fig.add_subplot(111)
  ## the bars
  rects1 = ax.bar(ind, [data[0] for data in datas], width,color=colors[0])
  rects2 = ax.bar(ind+width, [data[1] for data in datas], width,color=colors[1])
  rects3 = ax.bar(ind+width*2, [data[2] for data in datas], width,color=colors[2])

  # axes and labels
  ax.set_xlim(-width,len(ind)-1+3*width)
  ax.set_ylim(0,1.1)
  ax.set_ylabel('Miss rates', fontsize=14)
  xTickMarks = ['Line n°'+str(i) for i in sourceLines]
  ax.set_xticks(ind+width)
  xtickNames = ax.set_xticklabels(xTickMarks)
  plt.setp(xtickNames, fontsize=14)

  ## add a legend
  ax.legend((rects1[0], rects2[0], rects3[0]), ('L1', 'L2', "L3"), 
            loc='upper center', bbox_to_anchor=(0.5, -0.05),
            fancybox=True, shadow=True, ncol=3
           )
  plt.tight_layout()
  plt.savefig(sys.argv[2] + "missrates-" + suffix + ".pdf")
  """

  fig = plt.figure(figsize=[10,7])
  ax = fig.add_subplot(111)

  rects1 = ax.bar(ind, [data[3] for data in datas], width,color=colors[0],edgecolor="black",hatch=hatches[0])
  rects2 = ax.bar(ind+width, [data[4] for data in datas], width,color=colors[1],edgecolor="black",hatch=hatches[1])
  rects3 = ax.bar(ind+width*2, [data[5] for data in datas], width,color=colors[2],edgecolor="black",hatch=hatches[2])

  # axes and labels
  ax.set_xlim(-width,len(ind)-1+width*3)
  m = max([max([data[i] for i in range(3,6)]) for data in datas])
  #ymax = (10**np.floor(np.log10(m)))*np.ceil(m/(10**np.floor(np.log10(m)))) gives a bit more space above max (ex: if max=1600 will be 2000) but can lead to half of the height unused
  ax.set_ylim(0,m*1.1)
  #ax.set_yscale("log")
  #ax.set_ylabel("Number of cycle stalls / "+str(reductionFactorStalls), fontsize=14)
  ax.set_ylabel("Number of cycles spent stalling", fontsize=14)
  xTickMarks = ['Line n°'+str(i) for i in sourceLines]
  ax.set_xticks(ind+width)
  xtickNames = ax.set_xticklabels(xTickMarks)
  plt.setp(xtickNames, fontsize=14)

  ## add a legend
  ax.legend((rects1[0], rects2[0], rects3[0]), ('L1', 'L2', "L3"), 
            bbox_to_anchor=(0.5, -0.05), loc='upper center',
            fancybox=True, shadow=True, ncol=3
           )
  plt.tight_layout()
  plt.savefig(sys.argv[2] + "stalls-" + suffix + ".pdf")

  fig = plt.figure(figsize=[10,7])
  ax = fig.add_subplot(111)

  width = 1/7

  rects1 = ax.bar(ind, [data[6] for data in datas], width,color=colors[0],edgecolor="black",hatch=hatches[0])
  rects2 = ax.bar(ind+width, [data[7] for data in datas], width,color=colors[1],edgecolor="black",hatch=hatches[1])
  rects3 = ax.bar(ind+width*2, [data[8] for data in datas], width,color=colors[2],edgecolor="black",hatch=hatches[2])
  rects4 = ax.bar(ind+width*3, [data[9] for data in datas], width,color=colors[3],edgecolor="black",hatch=hatches[3])
  rects5 = ax.bar(ind+width*4, [data[10] for data in datas], width,color=colors[4],edgecolor="black",hatch=hatches[4])
  rects6 = ax.bar(ind+width*5, [data[11] for data in datas], width,color=colors[5],edgecolor="black",hatch=hatches[5])

  # axes and labels
  ax.set_xlim(-width,len(ind)-1+6*width)
  m = max([max([data[i] for data in datas]) for i in range(6,12)])
  #ymax = (10**np.floor(np.log10(m)))*np.ceil(m/(10**np.floor(np.log10(m))))
  ax.set_ylim(0,m*1.1)
  #ax.set_ylabel("Count/"+str(reductionFactorHM), fontsize=14)
  ax.set_ylabel("Count", fontsize=14)
  #ax.set_yscale('log')
  xTickMarks = ['Line n°'+str(i) for i in sourceLines]
  ax.set_xticks(ind+width*2.5)
  xtickNames = ax.set_xticklabels(xTickMarks)
  plt.setp(xtickNames, fontsize=14)

  ## add a legend
  ax.legend((rects1[0], rects2[0], rects3[0], rects4[0], rects5[0], rects6[0]), 
            ('L1 hit', "L1 miss", 'L2 hit', "L2 miss", "L3 hit", "L3 miss"),
            bbox_to_anchor=(0.5, -0.05), loc='upper center',
            fancybox=True, shadow=True, ncol=3, fontsize=14
          )
  plt.tight_layout()
  plt.savefig(sys.argv[2] + "hit-miss-" + suffix + ".pdf")

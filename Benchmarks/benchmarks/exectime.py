import sys
import matplotlib.pyplot as plt

if sys.argv[1] != "graph" and sys.argv[1] != "graphPass": #then we call to compute an average
    with open(sys.argv[1]) as file:
        totalTime = 0
        nbLines = 0
        for line in file:
            if line.split()[0] != "exectime": continue
            nbLines += 1
            totalTime += float(line.split()[1])
        if nbLines > 0: print(totalTime/nbLines)
        else: print(0)
else: #then we call for a graph creation
    files = sys.argv[2:-1]
    nbCols = int(len(files)/3)
    if sys.argv[1] == "graphPass": nbCols = int(len(files)/3)
    averages = []
    for file in files:
        f = open(file)
        for line in f:
            x = float(line)
        averages.append(x)

    suffix = sys.argv[2].split("/")[-1].split("-")[0]
    plt.rc('font', size=14)
    fig = plt.figure(figsize=[11,7])
    ax = fig.add_subplot(111)

    width = 1/(nbCols+1)
    rects = []
    colors = ['#a6cee3', '#1f78b4', '#b2df8a', '#33a02c', '#fb9a99', '#e31a1c', '#fdbf6f']
    hatches = ['/','\\',"|","-","+","x","."]
    if (sys.argv[1] == "graph"):
        if nbCols > 3: #then we are either doing a comparison for HT1 or for Basic3
            #to find the optimal chunk size / prefetch distance
            if suffix == "1": suffix = "compHT1"
            else: suffix = "compBa3"
    
        if suffix == "compHT1": legends = ["HT1 " + sys.argv[i].split("/")[-1].split("-")[1] for i in range(3,nbCols+2)]
        elif suffix == "compBa3": legends = ["Basic " + sys.argv[i].split("/")[-1].split("-")[1] for i in range(3,nbCols+2)]
        rects.append(ax.bar([0,1], [1,1], width,color=colors[0],edgecolor="black",hatch=hatches[0]))
        ax.text(0,1,str(format(1, ".2f")), fontsize=14, horizontalalignment="center", verticalalignment="bottom")
        ax.text(1,1,str(format(1, ".2f")), fontsize=14, horizontalalignment="center", verticalalignment="bottom")
        for i in range(1,nbCols):
            ax.text(width*i, averages[nbCols+i] / averages[nbCols], str(format(round(averages[nbCols+i] / averages[nbCols],2), ".2f")), fontsize=14, horizontalalignment="center", verticalalignment="bottom")
            ax.text(width*i + 1, averages[i] / averages[0] , str(format(round(averages[i] / averages[0],2), ".2f")), fontsize=14, horizontalalignment="center", verticalalignment="bottom")
            rects.append(ax.bar([width*i,1+i*width], [averages[nbCols+i] / averages[nbCols],averages[i] / averages[0]], width,color=colors[i],edgecolor="black",hatch=hatches[i]))

        # axes and labels
        ax.set_xlim(-width,1+nbCols*width)
        ax.set_ylim(0,1.1*max([averages[i]/averages[0] for i in range(nbCols)] + [averages[i]/averages[nbCols] for i in range(nbCols,len(files))]))
        ax.set_ylabel("Execution time relative to the baseline", fontsize=14)
        xTickMarks = ["Target function", "Application"]
        ax.set_xticks([(nbCols-1)*width/2,1+(nbCols-1)*width/2])
        xtickNames = ax.set_xticklabels(xTickMarks)
        plt.setp(xtickNames, fontsize=14)

        ## add a legend
        if suffix == "3":
            ax.legend((rects[0][0], rects[1][0], rects[2][0]), 
                        ('Baseline', "Coroutine", 'Basic'),
                        bbox_to_anchor=(0.5, -0.05), loc='upper center',
                        fancybox=True, shadow=True, ncol=4, fontsize=14
                     )
        elif nbCols > 3:
            ax.legend(tuple([rect[0] for rect in rects]), 
                        tuple(["Baseline"]+legends[:nbCols-1]),
                        bbox_to_anchor=(0.5, -0.05), loc='upper center',
                        fancybox=True, shadow=True, ncol=4, fontsize=14
                     )
        else:    
            ax.legend((rects[0][0], rects[1][0], rects[2][0]), 
                        ('Baseline', "Coroutine", 'Helper thread'),
                        bbox_to_anchor=(0.5, -0.05), loc='upper center',
                        fancybox=True, shadow=True, ncol=4, fontsize=14
                     )
    else:
        suffix = "pass"
        if nbCols == 5: suffix += "-all"
        for i in range(nbCols):
            ax.text(width*i, averages[i] / averages[0], str(format(round(averages[i] / averages[0],2), ".2f")), fontsize=14, horizontalalignment="center", verticalalignment="bottom")
            ax.text(1+i*width, averages[nbCols+i] / averages[nbCols], str(format(round(averages[nbCols+i] / averages[nbCols],2), ".2f")), fontsize=14, horizontalalignment="center", verticalalignment="bottom")
            ax.text(2+i*width, averages[nbCols*2+i] / averages[nbCols*2], str(format(round(averages[nbCols*2+i] / averages[nbCols*2],2), ".2f")), fontsize=14, horizontalalignment="center", verticalalignment="bottom")
            rects.append(ax.bar([width*i,1+i*width,2+i*width], [averages[i] / averages[0], averages[nbCols+i] / averages[nbCols], averages[nbCols*2+i] / averages[nbCols*2]], width,color=colors[i],edgecolor="black",hatch=hatches[i]))

        # axes and labels
        ax.set_xlim(-width,2+nbCols*width)
        ax.set_ylim(0,1.1*max([averages[i]/averages[0] for i in range(nbCols)] + [averages[i]/averages[nbCols] for i in range(nbCols,2*nbCols)] + [averages[i]/averages[nbCols*2] for i in range(nbCols*2,len(files))]))
        ax.set_ylabel("Execution time relative to the baseline", fontsize=14)
        xTickMarks = ["Benchmark 1", "Benchmark 2", "Benchmark 3"]
        ax.set_xticks([(nbCols-1)*width/2, 1+(nbCols-1)*width/2, 2+(nbCols-1)*width/2])
        xtickNames = ax.set_xticklabels(xTickMarks)
        plt.setp(xtickNames, fontsize=14)

        legend = ["Baseline", "Coroutine", "Pass (with annotations)", "Pass (with heuristic)", "HT/Basic prefetching"]
        ax.legend(tuple([rect[0] for rect in rects]), 
                  tuple(legend[:nbCols]),
                  bbox_to_anchor=(0.5, -0.05), loc='upper center',
                  fancybox=True, shadow=True, ncol=3, fontsize=14
                 )

    plt.tight_layout()
    plt.savefig(sys.argv[-1] + "exectime-" + suffix + ".pdf")
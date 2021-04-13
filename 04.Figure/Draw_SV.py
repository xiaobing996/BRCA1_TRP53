#!/usr/bin/python
# -*- coding: UTF-8 -*-
###chr=$1
###pos1=$2
###pos2=$3
import time

print(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()))

filePath = 'C:/Users/SV/'
sample_new=["Brca1_10.5E","Brca1_16.5E","Brca1_1M","Brca1_4M","Brca1_8M","Brca1_12M"]
new_list=[(filePath+i+".each_sample.out") for i in sample_new]
save_list=[("C:/Users/SV/out/"+i+"_$1_onlySV.pdf") for i in sample_new]
 
for i in range(len(sample_new)):
	fo = open(new_list[i], "r+")
	chromosome=$1;minLocus=$2;maxLocus=$3
	typeDictionary={"BND":"#483D8B","INV":"#FF7F50",".":"#00A144","DUP":"red","DEL":"blue"}
	postionList=[]
	line = fo.readline()#first line
	while line:
		#print(line)
		lineList=line.split("\t")
		if lineList[0]==chromosome and lineList[2]==chromosome:
			if not(float(lineList[1])<minLocus and float(lineList[3])>maxLocus):
				postionTuple=((float(lineList[1])/maxLocus),(float(lineList[3])/maxLocus),lineList[4])
				postionList.append(postionTuple)
		elif lineList[0]==chromosome and lineList[2]!=chromosome:
			if minLocus<float(lineList[1]) and float(lineList[1])<maxLocus:
				postionTuple=((float(lineList[1])/maxLocus),((2*maxLocus-float(lineList[1]))/maxLocus),lineList[4])
				postionList.append(postionTuple)
		elif lineList[0]!=chromosome and lineList[2]==chromosome:
			if minLocus<float(lineList[3]) and float(lineList[3])<maxLocus:
				postionTuple=(((2*minLocus-float(lineList[3]))/maxLocus),(float(lineList[3])/maxLocus),lineList[4])
				postionList.append(postionTuple)
		line = fo.readline()
	fo.close()

#for postionTuple in postionList:
#    print(postionTuple[0],"\t",postionTuple[1])
    
#draw control loop

	import matplotlib.pyplot as plt
	from matplotlib.patches import Ellipse

	ax=plt.gca()

	for postionTuple in postionList:
		x=(postionTuple[0]+postionTuple[1])/2
		width=postionTuple[1]-postionTuple[0]
		ellipse = Ellipse(xy=(x,0),width=width,height=0.2,fc='None',ec=typeDictionary[postionTuple[2]],linewidth=0.5,alpha=0.7)
		ax.add_patch(ellipse)

	ax.set_xlim([minLocus/maxLocus,maxLocus/maxLocus])
	ax.set_ylim([0,1])
	ax.spines['bottom'].set_linewidth(1.5)
	ax.spines['right'].set_color('none')
	ax.spines['left'].set_color('none')
	ax.spines['top'].set_color('none')
	ax.axes.get_xaxis().set_visible(False)
	ax.axes.get_yaxis().set_visible(False)

	plt.savefig(save_list[i])
	plt.close()
	print ('it is ok')

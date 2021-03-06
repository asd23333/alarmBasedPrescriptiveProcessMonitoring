library(ggplot2)
library(plyr)
library(RColorBrewer)
library(reshape2)

setwd("/Users/stephanf/Dropbox/Dokumente/Masterstudium/Masterthesis/OutputArtificialEvalSingleAlarm/")
files <- list.files()
data <- data.frame()
for (file in files) {
  tmp <- read.table(file, sep=";", header=T)
  tmp$cls <- "rf"
  data <- rbind(data, tmp)
}

data$metric <- gsub("_mean", "", data$metric)
data$ratio <- paste(data$c_miss, data$c_action, sep=":")

base_size <- 36
line_size <- 1
point_size <- 4

data <- subset(data, dataset != "bpic2018")
data <- subset(data, dataset != "uwv")
data$method <- as.character(data$method)
data$dataset <- as.character(data$dataset)
data$method[data$method=="fixed0"] <- "always alarm"
data$method[data$method=="fixed110"] <- "never alarm"
data$method[data$method=="fixed50"] <- "tau=0.5"
data$method[data$method=="single_threshold"] <- "Single Alarm"
data$method[data$method=="opt_threshold"] <- "optimized"
data$dataset[data$dataset=="uwv_all"] <- "uwv"
data$dataset[data$dataset=="traffic_fines_1"] <- "traffic_fines"

data <- subset(data, cls=="rf")
#print(subset(data,method=="perfect_prediction"))

head(data)

color_palette <- c("#0072B2", "#000000", "#E69F00", "#009E73", "#56B4E9","#D55E00", "#999999", "#F0E442", "#CC79A7")
ggplot(subset(data, c_postpone==0 & metric=="cost_avg" & !grepl("fixed", method) & c_com==2 & c_miss <= 20 & early_type=="const"), aes(x=c_miss, y=value, color=method, shape=method)) +
  geom_point(size=point_size) + geom_line(size=line_size)+  scale_shape_manual(values=seq(0,15)) + scale_x_continuous(breaks=c(3,10,20),
                                                                                                                      labels=c("3:1", "10:1", "20:1"))+
  theme_bw(base_size=26) + ylab("Avg. cost per case") + xlab("c_out : c_in") + facet_wrap( ~ dataset, ncol=4) +
  scale_color_manual(values=color_palette) + theme(legend.position="top")
ggsave("/Users/stephanf/Dropbox/Dokumente/Masterstudium/Masterthesis/testresults/artificialClassifiersSingle/results_ratios_const.pdf",width = 20, height = 20)

color_palette <- c("#0072B2", "#000000", "#E69F00", "#009E73", "#56B4E9","#D55E00", "#999999", "#F0E442", "#CC79A7")
ggplot(subset(data, c_postpone==0 & metric=="cost_avg" & !grepl("fixed", method) & c_com==2 & c_miss <= 20 & early_type=="linear"), aes(x=c_miss, y=value, color=method, shape=method)) +
  geom_point(size=point_size) + geom_line(size=line_size)+  scale_shape_manual(values=seq(0,15)) + scale_x_continuous(breaks=c(3,10,20),
                                                                                                                      labels=c("3:1", "10:1", "20:1"))+
  theme_bw(base_size=26) + ylab("Avg. cost per case") + xlab("c_out : c_in") + facet_wrap( ~ dataset, ncol=4) +
  scale_color_manual(values=color_palette) + theme(legend.position="top")
ggsave("/Users/stephanf/Dropbox/Dokumente/Masterstudium/Masterthesis/testresults/artificialClassifiersSingle/results_ratios_linear.pdf",width = 20, height = 20)


color_palette <- c("#0072B2", "#000000", "#E69F00", "#009E73", "#56B4E9","#D55E00", "#999999", "#F0E442", "#CC79A7")
ggplot(subset(data, c_postpone==0 & metric=="cost_avg" & !grepl("fixed", method) & c_com==20 & c_miss <= 20 & early_type=="const"), aes(x=c_miss, y=value, color=method, shape=method)) +
  geom_point(size=point_size) + geom_line(size=line_size)+  scale_shape_manual(values=seq(0,15)) + scale_x_continuous(breaks=c(3,10,20),
                                                                                                                      labels=c("3:1", "10:1", "20:1"))+
  theme_bw(base_size=26) + ylab("Avg. cost per case") + xlab("c_out : c_in") + facet_wrap( ~ dataset, ncol=4) +
  scale_color_manual(values=color_palette) + theme(legend.position="top")
ggsave("/Users/stephanf/Dropbox/Dokumente/Masterstudium/Masterthesis/testresults/artificialClassifiersSingle/results_ratios_linear_com20.pdf",width = 20, height = 20)

color_palette <- c("#0072B2", "#000000", "#E69F00", "#009E73", "#56B4E9","#D55E00", "#999999", "#F0E442", "#CC79A7")
ggplot(subset(data, c_postpone==0 & metric=="fscore" & !grepl("fixed", method) & c_com==2 & c_miss <= 20 & early_type=="linear"), aes(x=c_miss, y=value, color=method, shape=method)) +
  geom_point(size=point_size) + geom_line(size=line_size)+  scale_shape_manual(values=seq(0,15)) + scale_x_continuous(breaks=c(3,10,20),
                                                                                                                      labels=c("3:1", "10:1", "20:1"))+
  theme_bw(base_size=26) + ylab("F-Score") + xlab("c_out : c_in") + facet_wrap( ~ dataset, ncol=4) +
  scale_color_manual(values=color_palette) + theme(legend.position="top")
ggsave("/Users/stephanf/Dropbox/Dokumente/Masterstudium/Masterthesis/testresults/artificialClassifiersSingle/fscore_ratios_linear.pdf",width = 20, height = 20)

color_palette <- c("#0072B2", "#000000", "#E69F00", "#009E73", "#56B4E9","#D55E00", "#999999", "#F0E442", "#CC79A7")
ggplot(subset(data, c_postpone==0 & metric=="fscore" & !grepl("fixed", method) & c_com==2 & c_miss <= 20 & early_type=="const"), aes(x=c_miss, y=value, color=method, shape=method)) +
  geom_point(size=point_size) + geom_line(size=line_size)+  scale_shape_manual(values=seq(0,15)) + scale_x_continuous(breaks=c(3,10,20),
                                                                                                                      labels=c("3:1", "10:1", "20:1"))+
  theme_bw(base_size=26) + ylab("fscore") + xlab("c_out : c_in") + facet_wrap( ~ dataset, ncol=4) +
  scale_color_manual(values=color_palette) + theme(legend.position="top")
ggsave("/Users/stephanf/Dropbox/Dokumente/Masterstudium/Masterthesis/testresults/artificialClassifiersSingle/fscore_ratios_const.pdf",width = 20, height = 20)

color_palette <- c("#0072B2", "#000000", "#E69F00", "#009E73", "#56B4E9","#D55E00", "#999999", "#F0E442", "#CC79A7")
ggplot(subset(data, c_postpone==0 & metric=="fscore" & !grepl("fixed", method) & c_com==20 & c_miss <= 20 & early_type=="const"), aes(x=c_miss, y=value, color=method, shape=method)) +
  geom_point(size=point_size) + geom_line(size=line_size)+  scale_shape_manual(values=seq(0,15)) + scale_x_continuous(breaks=c(3,10,20),
                                                                                                                      labels=c("3:1", "10:1", "20:1"))+
  theme_bw(base_size=26) + ylab("fscore") + xlab("c_out : c_in") + facet_wrap( ~ dataset, ncol=4) +
  scale_color_manual(values=color_palette) + theme(legend.position="top")
ggsave("/Users/stephanf/Dropbox/Dokumente/Masterstudium/Masterthesis/testresults/artificialClassifiersSingle/fscore_ratios_linear_com20.pdf",width = 20, height = 20)


dt_as_bad <- subset(data, metric=="cost_avg" & method=="0.5_Classifier")
dt_as_good <- subset(data, metric=="cost_avg" & method=="0.9_Classifier")
dt_merged <- merge(dt_as_bad, dt_as_good, by=c("dataset", "c_miss", "c_action", "c_postpone", "c_com", "early_type", "cls", "ratio"), suffixes=c("_as_bad", "_as_good"))


dt_merged$ratioBestWort <- (dt_merged$value_as_good/dt_merged$value_as_bad)
dt_merged$ratio <- as.factor(dt_merged$ratio)
#print(dt_merged$ratio)
dt_merged$ratio <- factor(dt_merged$ratio, levels(dt_merged$ratio)[c(1,3,5,6,2,4)])
#print(dt_merged$ratio)
dt_merged$ratio_com <- as.factor(dt_merged$c_com)
#dt_merged$ratio_com <- factor(dt_merged$ratio_com, levels(dt_merged$ratio_com)[c(1,13,10,2,14,12,11,3,5,7,9,4,6,8)])
#print(dt_merged$ratio_com)

ggplot(subset(dt_merged, cls=="rf" & c_miss %in% c(1,2,3,5,10,20)  & grepl("const", early_type) & ratio!="3:1"), aes(factor(ratio_com), factor(ratio))) + geom_tile(aes(fill = ratioBestWort), colour = "black") + 
  theme_bw(base_size=base_size) + scale_fill_gradientn(colours=c("green","white","red"),breaks=c(0.4,1.0,1.3)) + 
  xlab("c_in : c_com") + ylab("c_out : c_in") +  theme(axis.text.x = element_text(size=20))  + facet_wrap( ~ dataset, ncol=4)
ggsave("/Users/stephanf/Dropbox/Dokumente/Masterstudium/Masterthesis/testresults/artificialClassifiersSingle/results_heatmap_best_vs_worst_const.pdf", width = 40, height = 40)


ggplot(subset(dt_merged, cls=="rf" & c_miss %in% c(1,2,3,5,10,20)  & grepl("linear", early_type) & ratio!="3:1"), aes(factor(ratio_com), factor(ratio))) + geom_tile(aes(fill = ratioBestWort), colour = "black") + 
  theme_bw(base_size=base_size) + scale_fill_gradientn(colours=c("green","white","red"),breaks=c(0.4,1.0,1.7))  + 
  xlab("c_in : c_com") + ylab("c_out : c_in") +  theme(axis.text.x = element_text(size=20)) + facet_wrap( ~ dataset, ncol=4)
ggsave("/Users/stephanf/Dropbox/Dokumente/Masterstudium/Masterthesis/testresults/artificialClassifiersSingle/results_heatmap_best_vs_worst_linear.pdf", width = 40, height = 40)
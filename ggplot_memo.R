library(ggplot2)

SEX <- c("MALE", "FEMALE")
GRADE <- c("BAD", "GOOD", "EXCELLENT")

dat <- data.frame(SEX = SEX[floor(runif(1000, 1, 3))],
                  GRADE = GRADE[floor(runif(1000, 1, 4))], 
                  VALUE = sample.int(50,size=1000,replace=TRUE),
                  stringsAsFactors = FALSE
                  )

#
ggplot(data=dat[dat$SEX=="FEMALE",], aes(x=GRADE)) + 
  geom_bar(fill=c(I("#D87093"))) + 
  geom_text(stat='count',aes(label=..count..),vjust=-1) + 
  ylab("COUNT") +
  ggtitle("TITLE")+
  theme_minimal() +
  #theme(panel.background = element_rect(fill = "white", colour = "grey50")) + 
  theme(axis.text.x = element_text(size=14),#, family = "微軟細"),
        axis.text.y = element_text(size=14),#, family = "微軟細"),  
        axis.title.x = element_text(size=14, face="bold"),#, family = "微軟粗"),
        axis.title.y = element_text(size=14, face="bold"),#, family = "微軟粗"),
        plot.title = element_text(hjust = 0.5,size=20, face="bold"),#, family = "微軟粗"),
        plot.margin = unit(c(1,1,1,1), "cm")
  )

## different colors with different bars
ggplot(data=dat, aes(x=SEX)) + 
  geom_bar(aes(y = (..count..)/sum(..count..)), fill=c(I("#D87093"), I("#1E90FF"))) + 
  ylab("PERCENTAGE") +
  ggtitle("TITLE")+
  theme_minimal() +
  #theme(panel.background = element_rect(fill = "white", colour = "grey50")) + 
  theme(axis.text.x = element_text(size=14),#, family = "微軟細"),
        axis.text.y = element_text(size=14),#, family = "微軟細"),  
        axis.title.x = element_text(size=14, face="bold"),#, family = "微軟粗"),
        axis.title.y = element_text(size=14, face="bold"),#, family = "微軟粗"),
        plot.title = element_text(hjust = 0.5,size=20, face="bold"),#, family = "微軟粗"),
        plot.margin = unit(c(1,1,1,1), "cm")
  )


# bar with order
theTable <- within(dat[dat$SEX=="MALE",], 
                   GRADE <- factor(GRADE, levels=c("BAD", "GOOD", "EXCELLENT")))
ggplot(data=theTable, aes(x=GRADE)) + 
  geom_bar(aes(y = (..count..)/sum(..count..)), fill=I("#1E90FF")) + 
  ylab("PERCENTAGE") +
  ggtitle("TITLE")+
  theme_minimal() +
  #theme(panel.background = element_rect(fill = "white", colour = "grey50")) + 
  theme(axis.text.x = element_text(size=14),#, family = "微軟細"),
        axis.text.y = element_text(size=14),#, family = "微軟細"),  
        axis.title.x = element_text(size=14, face="bold"),#, family = "微軟粗"),
        axis.title.y = element_text(size=14, face="bold"),#, family = "微軟粗"),
        plot.title = element_text(hjust = 0.5,size=20, face="bold"),#, family = "微軟粗"),
        plot.margin = unit(c(1,1,1,1), "cm")
  )

# histogram
x = dat$VALUE
x = x[!x %in% boxplot.stats(x)$out]
qplot(x, geom="histogram", fill=I("#1E90FF")) + xlab("XLAB") +
  ylab("YLAB") +
  ggtitle("TITLE")+
  theme_minimal() +
  #theme(panel.background = element_rect(fill = "white", colour = "grey50")) + 
  theme(axis.text.x = element_text(size=14),#, family = "微軟細"),
        axis.text.y = element_text(size=0),#, family = "微軟細"),  
        axis.title.x = element_text(size=14, face="bold"),#, family = "微軟粗"),
        axis.title.y = element_text(size=14, face="bold"),#, family = "微軟粗"),
        plot.title = element_text(hjust = 0.5,size=20, face="bold"),#, family = "微軟粗"),
        plot.margin = unit(c(1,1,1,1), "cm")
  )

# pyramid
ggplot(data=dat, aes(x=VALUE,fill=SEX)) + 
  geom_bar(data=subset(dat, SEX=="FEMALE")) + 
  geom_bar(data=subset(dat, SEX=="MALE"),aes(y=..count..*(-1))) + 
  #scale_y_continuous(breaks=seq(-40,40,10),labels=abs(seq(-40,40,10))) + 
  scale_fill_manual(name = "SEX", values = c("#D87093", "#1E90FF"))+
  xlab("XLAB")+
  ylab("YLAB")+
  theme_minimal() +
  theme(axis.text.x = element_text(size=0),#, family = "微軟細"),
        axis.text.y = element_text(size=14),#, family = "微軟細"),  
        axis.title.x = element_text(size=14, face="bold"),#, family = "微軟粗"),
        axis.title.y = element_text(size=14, face="bold"),#, family = "微軟粗"),
        plot.title = element_text(hjust = 0.5,size=20, face="bold"),#, family = "微軟粗"),
        plot.margin = unit(c(1,1,1,1), "cm"),
        legend.title=element_text(size=14, face="bold"),#, family = "微軟粗"), 
        legend.text=element_text(size=14, face="bold"),#, family = "微軟粗")
  )+
  coord_flip()


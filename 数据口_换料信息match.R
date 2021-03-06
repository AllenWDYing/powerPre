#install.packages("raster")
library(raster)
relaod_sht2 <- read_excel("relaod.xls", sheet = "Sheet2")
relaod_sht3 <- read_excel("relaod.xls", sheet = "Sheet3")

relaod_sht2 <- as.matrix(relaod_sht2)#reactor导出完整满功率日序列
relaod_sht3 <- as.matrix(relaod_sht3)#relaod里面的实际换料满功率日
l <- list()
fpd_unlist <- unlist(relaod_sht2)
for (i in 1:(length(fpd_unlist)-1)) {
  
  l[[i]] <- unlist(c(fpd_unlist[i],fpd_unlist[i+1]))
  
}

#f <- function(x,left_right){
#}
#
m <- matrix(data = 0,ncol = 2)
colnames(m) <- c("relaod_channel_name","relaod_fpd")
for (i in 1:length(l)) {
  for (j in 1:nrow(relaod_sht3)) {
    if((!is.na(relaod_sht3[j,1])) & as.numeric(trim(relaod_sht3[j,1]))> l[[i]][2] 
       & as.numeric(trim(relaod_sht3[j,1])) <= l[[i]][1]){
    c <- cbind(relaod_sht3[j,2],as.numeric(l[[i]][1])) 
    colnames(c) <- c("relaod_channel_name","relaod_fpd")
    m <- rbind(m,c)
    }

  }
}
write.csv(m,"relaod_macth.csv")
m[1:20,]
relaod_sht3[relaod_sht3[,2] == "M19",]


start <- NULL
for (i in 1:length(l)) {
  for (j in 1:nrow(relaod_sht3)) {
    if((!is.na(relaod_sht3[j,1])) & as.numeric(trim(relaod_sht3[j,1]))> l[[i]][2] & as.numeric(trim(relaod_sht3[j,1])) <= l[[i]][1]
       & relaod_sht3[j,2] == "M19"){
      c <- cbind(relaod_sht3[j,2],as.numeric(l[[i]][1]),as.numeric(l[[i]][2]),relaod_sht3[j,1]) 
      start <- rbind(start,c)
    }
    
  }
}

l[[1]]






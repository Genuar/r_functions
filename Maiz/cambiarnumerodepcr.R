# cambiar el directorio por el directorio de trabajo
d<-c("/media/genuar/Datos/Documents/3_Experimentos_PCRs (cambios genuar)/16-PCR_951-1046/")
setwd(d)
dir(paste(d,"electroferogramas",sep = ""))->olds;olds

setwd(paste(d,"electroferogramas",sep=""))
for(i in 1:length(olds))
{
split<-as.data.frame(strsplit(olds[i],"-"))
split.1<-as.numeric(paste(split[1,]))+1
cambio<-paste(split.1,split[2,],split[3,],sep = "-")
file.rename(olds[i],cambio)

}

setwd(d)
dir(paste(d,"electroferogramas",sep = ""))->olds;olds
read.csv("nombres.txt")->new;new
n=NULL
for(i in 2:length(new[1,])){
  a<-as.vector(t(new[,i]))
  n<-c(n,a)
}
n
n<-sort(n);n

cbind(olds,n)

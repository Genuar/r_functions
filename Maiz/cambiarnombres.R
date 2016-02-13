########
# Este código está pensado para cambiar el nombre de
# varias archivos a la vez contenidos en una carpeta,
# en este caso de electroferogramas, cuyos nombres
# están en el mismo orden que la lista de los nombres
# nuevas que se van a cambiar.


# cambiar el directorio por el directorio de trabajo
d<-c("directorio que contiene la carpeta de electroferogramas y el archivo nombres.txt")
setwd(d)
# Lee el nombre de los electroferogramas y los almacena en el objeto archivos
dir(paste(d,"electroferogramas",sep = ""))->archivos;archivos
#archivos<-archivos[1:40] # En caso de que la carpeta de electroferogramas
                          # contenga archivos o carpetas no deseadas, se eliminan
archivos<-sort(archivos);archivos # ordenar el nombre de los archivos por número de PCR, en este caso
# Con este cobjeto se va a llamar posteriormente a cada archivo para cambiarle el nombre
#########################

# Se lee el archivo con la tabla de datos que contiene los nuevos nombres
read.csv("nombres.txt")->newnames
newnames
# Este for ordena los nuevos nombres en un vector
n=NULL
for(i in 2:length(newnames[1,]))
  { a<-as.vector(t(newnames[,i]))
    n<-c(n,a)
  }
n
n<-sort(n);n
#n<-n[10:88] # Esto elimina los nombres nulos o controles negativos son numero de PCR
cbind(archivos,paste(n,".fsa",sep="")) # unir nombres viejos y nuevos para compara similitudes y diferencias
# as.vector(t((as.data.frame(strsplit(n,"_")))[1,]))->n.1 # Código no usado
sum(archivos!=paste(n,".fsa",sep=""))# Indica cuantos nombres son diferentes
# Se cambian los nombres
setwd(paste(d,"electroferogramas",sep=""))
dir()
for(i in 1:length(archivos))
  { file.rename(archivos[i],paste(n[i],".fsa",sep=""))
    #file.rename(archivos[i],paste(archivos[i],".fsa",sep = ""))
  }

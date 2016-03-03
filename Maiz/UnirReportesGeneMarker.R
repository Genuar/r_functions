###################################################################################
#############
## En Unix ##
#############
# sudo apt-get install sshfs
# sudo mkdir /media/genuar/Maiz_Red
# sudo sshfs Maiz@163.178.108.4:/Maiz /media/genuar/Maiz_Red/ -o allow_other
#
# Para desmontar la unidad
# sudo fusermount -u /media/genuar/Maiz_Red/
###################################################################################
# Definir directorio de tabajo
directorio<-c("/media/genuar/Maiz_Red/3_Experimentos_PCRs (cambios genuar)")
setwd(directorio)
# Obtener nombre de las carpetas
plates<-dir();plates

# Ingresar a cada carpeta y buscar la capeta GeneMarker, dentro sacar los archivos "*Genos.csv"
genotipos=NULL # Guarda todos los genotipos hacia abajo
for(i in 1:length(plates))
{
  # Obtener el nombre de los archivos
  GM<-paste(directorio,plates[i],"GeneMarker",sep = "/") # Dirección de la carpeta GeneMarker
  print(GM)
  reports <- dir(GM,pattern = "Genos.csv") # Aquí se guardan los reportes de GeneMarker
  GM.multiplex = NULL # Contiene los multiplex de cada reporte
  for(j in 1:length(reports))
  {
    msat.file<-df2msatallele(paste(GM,reports[j],sep="/"))
    report.name<-rep(reports[j],length(msat.file[,1]))
    msat.file<-cbind(msat.file,report.name)
    GM.multiplex<-rbind(GM.multiplex, msat.file)
  }
  # Ahora el objeto GM.multiplex se guarda en los genotipos
  genotipos<-rbind(genotipos, GM.multiplex)
}

write.csv(genotipos,"Todos_unidos_JSV.csv")

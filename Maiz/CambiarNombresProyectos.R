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
plates<-dir()
plates<-plates[plates!=grep(".csv",plates,value = TRUE)]

for(i in 1:length(plates))# i_th plate
{
  plate_i <- paste(directorio,plates[i],sep = "/");plate_i # Carpeta de la placa i
  electros_i <- dir(paste(plate_i, "electroferogramas", sep="/")) # Lista de electroferogramas de la placa i
  reports <- dir(paste(plate_i,"GeneMarker",sep = "/"),pattern = "Genos.csv") # Aquí se guardan los reportes de GeneMarker
  
  for(j in 1:length(reports)) #j_th report
  {
    report_j<-read.csv(paste(plate_i, "GeneMarker", reports[j],sep = "/"))
    Multi <- as.vector(unique(report_j$Multiplex)) # Extrae el multiplex del reporte J
    eletros_j <- grep(Multi,electros_i,value = TRUE)
    if(length(eletros_j) == length(report_j[,1]))
    {
      
    }else{
      print("Difieren en:")
      print(paste(plates[i],length(eletros_j)))
      print(paste(reports[j],length(report_j[,1])))
    }
  }
}

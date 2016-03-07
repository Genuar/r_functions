# 
# En ocasiones se requiere que los alelos de un set de datos genéticos
# estén separados por un "/", pero se han estado trabajando una columna
# por alelo. Esta función reformatea los datos para dar una matriz de 
# genotipos de dos alelos por columna, posteriormente podrá hacer lo
# contrario: separar alelos que se encuantran unidos por una caracter.

concatelo<-function(x, cols, sep="/", split=FALSE)
  {
  if(split==FALSE)
  {
    MG<-x[,cols] # Matriz de genotipos
    MI<-x[,-cols] # Matriz de la información
    if((length(colnames(MG))%%2)!=0){print("Dimensión de la matriz de genotipos incorrecto");stop()}
    cols<-1:length(cols)
    nombre<-colnames(MG)[cols%%2==1]
    r=1;MGU=NULL
    repeat{
            MGU<-rbind(MGU,paste(MG[r,cols%%2==1],MG[r,cols%%2==0],sep = "/"))
            r<-r+1
            if(r>length(MG[,1])){break}
          }
    as.data.frame(MGU)->MGU
    colnames(MGU)<-nombre
    cbind(MI,MGU)
  }
}

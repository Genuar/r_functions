# "m" es una matriz de 3 columnas, la primera contiene el ID de los puntos
# la segunda y tercera columna contiene información sobre las coordenadas
# geográficas, que deben estár proyectadas si se requiere que las distancias
# obtenidas representen medidas reales en el espacio.
A2B<-function(m,densidad){
nrow(m)
distancias=NULL

for (i in 1:nrow(m)) {
  
  for(j in 1:nrow(m))
  {
    x<-c(as.numeric(as.vector(m[i,2])),as.numeric(as.vector(m[j,2])))
    y<-c(as.numeric(as.vector(m[i,3])),as.numeric(as.vector(m[j,3])))
    
    
    if((diff(x))==0)
    {
      
      if((diff(y))==0)
      {
        C1<-cbind(paste(m[i,1],m[j,1],sep = "/"),x[1],y[1])
      }else{
        a<-(max(y)-min(y))/densidad
        dY<-seq(from=min(y), to=max(y), by=a)
        dX<-rep(x[1],length(dY))
        comp<-rep(paste(m[i,1],m[j,1],sep = "/"),length(dX))
        C1<-cbind(comp,dX,dY)
        }
      
    }else{
      pend<-(diff(y)) / (diff(x))
      b<- (y[1]-(pend*x[1]))
      s<-(max(x)-min(x))/densidad
      dX<-seq(from=min(x), to=max(x), by=s)
      dY<-apply(as.data.frame(dX),1,function(x){(pend*x)+b})
      comp<-rep(paste(m[i,1],m[j,1],sep = "/"),length(dX))
      C1<-cbind(comp,dX,dY)
    }
    distancias<-rbind(distancias,C1)
  }
  
}
as.data.frame(distancias)->distancias
colnames(distancias)<-c("pares","X","Y")
return(distancias)
}

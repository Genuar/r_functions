BinnerScoring <- function(DB,marker,motif=2)
{
  DB[DB$Marker==marker,]->mi # matriz de alelos del marcador i
  min(mi$Fragment)->a1 # Primer alelo del set de alelos i
  max(mi$Fragment)->an # último alelo del set de alelos i
  
  inicio<-a1-((a1%%2)-1)
  final<-an-((an%%2)-1)
  binnerstats<-NULL
  for (i in inicio:final) {
    # Sección de alelos upstream y downstream del alelo i
    ai<-mi$Fragment[mi$Fragment < i+(motif/2) & mi$Fragment > i-(motif/2)]
    if(length(ai)<4)
    {
      W<-0;pv<-0
    }else{
      PN<-shapiro.test(ai)# Prueba de normalidad
      as.numeric(PN$statistic)->W
      as.numeric(PN$p.value)->pv
    }
    
    moda<-mfv(ai)       # Moda de los datos, obtenido con el paquete modeest
    mediana<-median(ai) # Mediana de los datos, en el caso de numero de datos impar, el valor existe
    promedio<-mean(ai)  # Promedio de los alelos en la sección analizada 
    de<-sd(ai)          # Desviación Estándar
    
    # Abundancia
    ni<-length(ai)/length(mi$Fragment)
    
    # Distancia de la media al bin
    xb<-abs(i-promedio)/2
    
    # Distancia de la mediana al bin
    mb<-abs(i-mediana)/2
    
    # Simetría
      # Cantidad de datos del lado izquierdo
      izquierda<-mi$Fragment[mi$Fragment < i & mi$Fragment > i-(motif/2)]
      # Cantidad de datos del lado derecho
      derecha<-mi$Fragment[mi$Fragment < i+(motif/2) & mi$Fragment > i]
      # Distancia entre ambos datos
      simetria <-abs((length(izquierda)/(length(ai))) - (length(derecha)/(length(ai))))
    
    ################### Chevichev #################
    aimin<-(median(ai)-sd(ai))
    aimax<-(median(ai)+sd(ai))
    chev<-length(ai[ai>aimin & ai<aimax])/length(ai)
    ################################################
    
    
    ### Score
    score<-(chev*ni)/(xb*mb*simetria)
    
    statsi<-cbind(i,promedio,de,moda,mediana,W,pv,chev,score)
    colnames(statsi)<-c("Alelo","Promedio","DesvEst","Moda","Mediana","W","Shapiro.p","68%","Score")
    binnerstats<-rbind(binnerstats,statsi)
  }
  binnerstats<-as.data.frame(na.omit(binnerstats))
  return(binnerstats)
}

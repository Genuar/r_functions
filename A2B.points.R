A2B.points <- function(M,prop=0.10)
{
  segmentos<-NULL
  
    for(i in 1:length(M[,1]))
      {
    
          linea<-M[i,c(1,3,4,5)] # Inicio de la línea
          ### Ecuación de la recta
          x1<-as.numeric(as.vector(M[i,4]))
          x2<-as.numeric(as.vector(M[i,6]))
          y1<-as.numeric(as.vector(M[i,5]))
          y2<-as.numeric(as.vector(M[i,7]))
          
          if((x1-x2)==0 && (y1-y2)==0)
            {
              end<-M[i,c(2,3,4,5)];rownames(end)<-NULL;colnames(linea)->colnames(end)
              linea<-rbind(linea,end) # Final de la línea
      
            }else{
      
              m<-((y2-y1)/(x2-x1))
              b<- (y1-(m*x1))
      
              ### Pitágoras
              cat.x  <-max(x1,x2)-min(x1,x2) # Catéto X.
              cat.y  <-max(y1,y2)-min(y1,y2) # Catéto y.
              hip    <-sqrt((cat.x^2)+(cat.y^2)) # Hipótenusa que se forma entre los puntos.
              
              ### Generar los puntos sobre la recta
              deltax <-(hip*prop) # Número de incrementos que tedrá x.
              n.vert   <-cat.x%/%deltax # Número de vertices.
              vert<-1 # Primer Vértice luego del inicio de la recta
              
              #plot(c(x1,x2),c(y1,y2))
              
                    while (vert <= n.vert) 
                      {
                          xi<-round((min(x1,x2)+(deltax*vert)),4)
                          yi<-round(((m*xi)+b),4)
                          v<-cbind(paste(linea[1,1],".",vert,sep = ""),as.character(linea[1,2]),xi,yi)
                          colnames(linea)->colnames(v);rownames(v)<-NULL;as.data.frame(v)->v
                          linea<-rbind(linea,v)
                          vert<-vert+1
                          #points(xi,yi)
                
                        }
              
              end<-M[i,c(2,3,4,5)];rownames(end)<-NULL;colnames(linea)->colnames(end)
              linea<-rbind(linea,end) # Final de la línea
              
            }
    
            segmentos<-rbind(segmentos,linea)
        }

  return(segmentos)  
}
